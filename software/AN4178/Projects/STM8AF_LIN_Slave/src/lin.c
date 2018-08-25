/**
  ******************************************************************************
  * @file    lin.c
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    12-Sept-2012
  * @brief   STM8AF demo / LIN functions
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2012 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software
  * distributed under the License is distributed on an "AS IS" BASIS,
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "lin.h"
#include "main.h"

/* External variables --------------------------------------------------------*/
extern bool ErrorState;

/* Private typedef -----------------------------------------------------------*/

typedef enum
{
  Idle,
  Break,
  SynchField,
  Identifier,
  DataTransmission,
  DataReception
}
LIN_FSM_state;

/* LIN Frame type */
typedef struct
{
  uint8_t LINFrameIdentifier;
  uint8_t LINFrameDirection;
  uint8_t LINFrameDataLength;
  uint8_t LINFrameBuffer[9];
}
LINFrame_Type;

/* LIN Schedule table type */
typedef struct
{
  LINFrame_Type LINScheduleTableFrame;
  uint8_t LINScheduleTableFrameDelay;
}
LINScheduleTable_Type;

LIN_FSM_state LIN_FSM;

LINScheduleTable_Type LINScheduleTable[4];

/* Private defines -----------------------------------------------------------*/

#define DELAY_10MS 10
#define DELAY_20MS 20

#define RECEIVE 0
#define TRANSMIT 1

#define LIN_MASTER_RECEPTION_TIMEOUT 4
#define LIN_SLAVE_RECEPTION_TIMEOUT 100

#define MS0ID 0xC1 /* Master to slave frame 0, ID=0x01 with parity */
#define MS2ID 0x03 /* Master to slave frame 2, ID=0x03 with parity */
#define SM1ID 0x42 /* Slave to master frame 1, ID=0x02 with parity */
#define SM3ID 0xC4 /* Slave to master frame 3, ID=0x04 with parity */

/* Private macros ------------------------------------------------------------*/

#define IncrementScheduleTableTick() ScheduleTableTick++;
#define ClearScheduleTableTick() ScheduleTableTick=0;

/* Private variables ---------------------------------------------------------*/

static uint8_t DataToSend[9] =
  {
    0, 0, 0, 0, 0, 0, 0, 0, 0
  }
  ; /* Data to be sent */
static uint8_t DataBuffer[4][8] =
  {
    0
  }
  ; /* Reception data buffer for Frames*/
static uint8_t LINChecksumBuffer[10] =
  {
    0
  }
  ; /* Buffer for checksum calculation */
static uint8_t ResponseDataByteIndex = 0;
static uint8_t LINTransmitBuffer[9];
static uint8_t LINReceiveBuffer[9];
static uint8_t DLC; /* Response length */
static uint8_t ChecksumError = 0;
static uint8_t Index = 0;

uint8_t DataReceived = 0; /* Flag to indicate data reception on RX pin (RXNE) */
uint8_t HeaderReceived = 0; /* Flag to indicate Break reception on RX pin (LHDF) */
uint8_t BreakReceived = 0; /* Flag to indicate Break reception on RX pin (LBDF) */
uint8_t IdentifierParityError = 0; /*Flag to indicate parity error in received LIN Identifier */
uint8_t LINReceptionTimeoutValue = 0;
bool LINReceptionTimeout = FALSE;
bool LINSlave = FALSE;
volatile uint8_t UART3_SR_Buf = 0;
volatile uint8_t UART3Data = 0;
volatile uint8_t ReceptionError = 0;

/* Private function prototypes -----------------------------------------------*/

static uint8_t LINChecksum (uint8_t*, uint8_t);
static void StartLINReceptionTimeout(void);
static void StopLINReceptionTimeout(void);
static bool LINReceptionTimeoutElapsed(void);
static void LINError(void);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  UART3 configuration in LIN slave mode
  * @param  None
  * @retval None
  */
void LIN_SlaveConfig(void)
{
  /* Deinitializes the UART3 peripheral */
  UART3_DeInit();

  /* Configure the UART3 */
  UART3_Init((uint32_t)19200, UART3_WORDLENGTH_8D, UART3_STOPBITS_1, UART3_PARITY_NO,
             UART3_MODE_TXRX_ENABLE);

  UART3_LINBreakDetectionConfig(UART3_LINBREAKDETECTIONLENGTH_11BITS);

#ifdef AUTOMATIC_RESYNCHRO
  UART3_LINConfig(UART3_LIN_MODE_SLAVE, UART3_LIN_AUTOSYNC_ENABLE,
                  UART3_LIN_DIVUP_NEXTRXNE);
#else
  UART3_LINConfig(UART3_LIN_MODE_SLAVE, UART3_LIN_AUTOSYNC_DISABLE,
                  UART3_LIN_DIVUP_LBRR1);
#endif

  UART3_LINCmd(ENABLE); /* Enable LIN mode */

  /* Enable UART3 Receive interrupt */
  UART3_ITConfig(UART3_IT_RXNE_OR, ENABLE);
}

/**
  * @brief  LIN driver task
  * @param  None
  * @retval None
  */
void LIN_Task(void)
{


    /* ----------- */
    /* Slave mode  */
    /* ----------- */

    if (LINReceptionTimeoutElapsed())
    {
      StopLINReceptionTimeout();
      LIN_FSM = Idle;
    }

    switch ((LIN_FSM_state)LIN_FSM)
    {

        /* ------------- */
        /* STATE Idle :  */
        /* ------------- */
      case Idle:

        /* Set mute mode */

#ifdef MUTE_MODE
        UART3_ReceiverWakeUpCmd(ENABLE); /* set LINUART mute mode */
#endif
        LIN_FSM = Identifier;

        ResponseDataByteIndex = 0;

        break;

        /* ------------------------------------------ */
        /* STATE IDField : Waiting for ID Field       */
        /* ------------------------------------------ */
      case Identifier:

        if (HeaderReceived&!ReceptionError&!IdentifierParityError)
        {
          HeaderReceived = 0;

          /* Store ID for enhanced checksum calculation */
          LINChecksumBuffer[0] = UART3Data;
          ResponseDataByteIndex = 1; /* index for 1st data */
          StartLINReceptionTimeout();
          switch (UART3Data)
          {

            case MS0ID:
              LIN_FSM = DataReception;
              DLC = 8;
              break;

            case MS2ID:
              for (Index = 0;Index < 8;Index++)
              {
                DataToSend[Index] = DataBuffer[1][Index];
              }
              LIN_FSM = DataTransmission;
              DLC = 8;
              break;

            case SM1ID:
              LIN_FSM = DataReception;
              DLC = 4;
              break;

            case SM3ID:
              for (Index = 0;Index < 8;Index++)
              {
                DataToSend[Index] = DataBuffer[3][Index];
              }
              LIN_FSM = DataTransmission;
              DLC = 4;
              break;

            default: /* Discard response */
              LIN_FSM = Idle;
              break;

          } /* switch (UART3Data) */
        }

        else if (ReceptionError | IdentifierParityError)
        {
          ReceptionError = 0;
          IdentifierParityError = 0;
          LINError();
          LIN_FSM = Idle;
        }


        break;

        /* -------------------------------------*/
        /* STATE DataReception : wait for data  */
        /* ------------------------------------ */
      case DataReception:

        if (HeaderReceived&!ReceptionError)
        {
          LIN_FSM = Identifier;
        }
        else if (DataReceived&!ReceptionError)

        {
          DataReceived = 0;
          /* Data reception */
          if (ResponseDataByteIndex <= DLC)
          {
            /* Store Data */
            LINChecksumBuffer[ResponseDataByteIndex] = UART3Data;
#ifdef AUTOMATIC_RESYNCHRO
            if (ResponseDataByteIndex == DLC)
            {
              UART3->CR6 |=  UART3_CR6_LDUM; /* set LDUM bit */
            }
#endif
            ResponseDataByteIndex++;
          }
          /* End of frame */
          else
          {
            LINChecksumBuffer[ResponseDataByteIndex] = UART3Data;

            if (LINChecksum(LINChecksumBuffer, (DLC + 1)) == LINChecksumBuffer[ResponseDataByteIndex])
            {
              {
                uint8_t i;
                for (i = 0;i < DLC;i++)
                {
                  if (LINChecksumBuffer[0] == MS0ID)
                  {
                    DataBuffer[0][i] = LINChecksumBuffer[i+1]; // Store Response
                  }
                  else if (LINChecksumBuffer[0] == SM1ID)
                  {
                    DataBuffer[2][i] = LINChecksumBuffer[i+1]; // Store Response
                  }
                }
              }
            }
            else
            {
              LINError();
              ChecksumError = 1;
            }

            LIN_FSM = Idle;
          }

        }
        else if (ReceptionError)
        {
          DataReceived = 0;
          ReceptionError = 0;
          LINError();
          LIN_FSM = Idle;
        }

        break;

        /* -------------------------------------------- */
        /* STATE DataTransmission : send data       */
        /* -------------------------------------------- */
      case DataTransmission:

        if (HeaderReceived&!ReceptionError)
        {
          LIN_FSM = Identifier;
        }
        else if (ResponseDataByteIndex == 1)

        {
          UART3_SendData8(DataToSend[0]); /* Send 1st data */
          ResponseDataByteIndex++;
        }
        else
        {
          if (DataReceived&!ReceptionError)
          {
            DataReceived = 0;
            /* Data transmission */
            if (ResponseDataByteIndex < (DLC + 2))
            {
              if (UART3Data == DataToSend[ResponseDataByteIndex-2]) /* Check possible bit error */
              {
                LINChecksumBuffer[ResponseDataByteIndex-1] = UART3Data;
                if (ResponseDataByteIndex == (DLC + 1))
                {
                  DataToSend[ResponseDataByteIndex-1] = LINChecksum(LINChecksumBuffer, (DLC + 1));
#ifdef AUTOMATIC_RESYNCHRO
                  UART3->CR6 |=  UART3_CR6_LDUM; /* set LDUM bit */
#endif
                }
                UART3_SendData8(DataToSend[ResponseDataByteIndex-1]); /* Send data */
                ResponseDataByteIndex++;
              }
              else
              {
                LINError();
                LIN_FSM = Idle;
              }
            }

            /* End of frame */
            else
            {
              if (UART3Data != DataToSend[ResponseDataByteIndex-2])
              {
                LINError();
                ChecksumError = 1;
              }
              LIN_FSM = Idle;
            }
          }
          else if (ReceptionError)
          {
            DataReceived = 0;
            ReceptionError = 0;
            LINError();
            LIN_FSM = Idle;
          }
        }

        break;

    }
  
}



/**
  * @brief  LIN enhanced checksum calculation
  * @param  Checksum_Buffer Buffer of data bytes (including Identifier)
  * @param  Data_Number Number of databytes (including Identifier)
  * @retval None
  */
uint8_t LINChecksum (uint8_t* Checksum_Buffer, uint8_t Data_Number)
{
  uint8_t i = 0;
  uint16_t Sum = 0;
  uint16_t Sum1 = 0;

  for (i = 0;i < Data_Number;i++)
  {
    Sum = Sum + *(Checksum_Buffer + i);

    Sum1 = Sum >> 8;
    if ( Sum1 > 0 )
    {
      Sum++;
      Sum &= ~0x0100;
    }
  }

  return (uint8_t)(~Sum);
}

/**
  * @brief  returns value of a LIN signal
  * @param  FrameNumber
  * @param  BytePosition
  * @retval uint8_t signal value
  */
uint8_t LIN_ReadData(uint8_t FrameNumber, uint8_t BytePosition)
{

    return (DataBuffer[FrameNumber][BytePosition]);

}

/**
  * @brief  writes a value in a CAN signal
  * @param  FrameNumber
  * @param  BytePosition
  * @param  Value
  * @retval none
  */
void LIN_WriteData(uint8_t FrameNumber, uint8_t BytePosition, uint8_t Value)
{

    DataBuffer[FrameNumber][BytePosition] = Value;
}

/**
  * @brief  Starts LIN Reception Timeout
  * @param  None
  * @retval None
  */
void StartLINReceptionTimeout(void)
{
  LINReceptionTimeout = TRUE;
  LINReceptionTimeoutValue = 0;
}

/**
  * @brief  Stops LIN Reception Timeout
  * @param  None
  * @retval None
  */
void StopLINReceptionTimeout(void)
{
  LINReceptionTimeout = FALSE;
  LINReceptionTimeoutValue = 0;
}

/**
  * @brief  returns the LIN timeout status
  * @param  None
  * @retval bool returns TRUE is LIN timeout is elapsed, FALSE otherwise
  */
bool LINReceptionTimeoutElapsed(void)
{

	if (LINReceptionTimeoutValue > LIN_SLAVE_RECEPTION_TIMEOUT)
	{
		if (!ErrorState) LINError();
		return(TRUE);
	}
	else return (FALSE);
  
}

/**
  * @brief  Switch LD3 red LED on in case of LIN error
  * @param  None
  * @retval None
  */
void LINError(void)
{
  GPIO_WriteHigh(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3); /* LD3 red LED ON */
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/