/**
  ******************************************************************************
  * @file    lin.c
  * @author  MCD Application Team
  * @version VX.Y.ZRCx
  * @date    DD-Month-2012
  * @brief   LIN functions
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
#include "stm8l15x.h"
#include "lin.h"
#include "main.h"
#include "lcd.h"

/* External variables --------------------------------------------------------*/

/* Private typedef -----------------------------------------------------------*/

typedef enum
{
  Idle,
  Break,
  SynchField,
  Identifier,
  DataTransmission,
  DataReception    
} LIN_FSM_state;

/* LIN Frame type */
typedef struct {
  uint8_t LINFrameIdentifier;
  uint8_t LINFrameDirection;
  uint8_t LINFrameDataLength;  
  uint8_t LINFrameBuffer[9];  
} LINFrame_Type;

LIN_FSM_state LIN_FSM;

/* Private defines -----------------------------------------------------------*/

#define DELAY_10MS 10
#define DELAY_20MS 20

#define RECEIVE 0
#define TRANSMIT 1

#define LIN_RECEPTION_TIMEOUT 100

#define MS0ID 0xC1 /* Master to slave frame 0, ID=0x01 with parity */
#define MS2ID 0x03 /* Master to slave frame 2, ID=0x03 with parity */
#define SM1ID 0x42 /* Slave to master frame 1, ID=0x02 with parity */ 
#define SM3ID 0xC4 /* Slave to master frame 3, ID=0x04 with parity */

/* Private macros ------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/

volatile uint8_t USART1_SR_Buf=0;
volatile uint8_t USART1Data=0;
volatile uint8_t ReceptionError=0;
static uint8_t DataToSend[9]={0,0,0,0,0,0,0,0,0}; /* Data to be sent */
static uint8_t DataBuffer[4][8]={0}; /* Reception data buffer for Frames*/
static uint8_t LINChecksumBuffer[10]={0}; /* Buffer for checksum calculation */
static uint8_t ResponseDataByteIndex =0;
static uint8_t DLC; /* Response length */
static uint8_t ChecksumError=0;
static uint8_t Index=0;

uint8_t DataReceived=0; /* Flag to indicate data reception on RX pin (RXNE) */
uint8_t BreakReceived=0; /* Flag to indicate Break reception on RX pin (LBDF) */
uint8_t LINReceptionTimeoutValue=0;
bool LINReceptionTimeout=FALSE;
bool LINCommunicationStopped=TRUE;

/* Private function prototypes -----------------------------------------------*/

static uint8_t LINChecksum (uint8_t*, uint8_t);
static void StartLINReceptionTimeout(void);
static void StopLINReceptionTimeout(void);
static bool LINReceptionTimeoutElapsed(void);
static void LINError(void);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void LIN_SlaveConfig(void)
{
  /* Deinitializes the USART1 peripheral */
    USART_DeInit(USART1);

    /* Configure the USART1 */
 	USART_Init(USART1, (uint32_t)19200, USART_WordLength_8b, USART_StopBits_1, USART_Parity_No,
                (USART_Mode_TypeDef)(USART_Mode_Rx|USART_Mode_Tx));
																
    /* Enable USART2 Receive interrupt */
    USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);
	    
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void LIN_Task(void)
{
		
  /* ----------- */
  /* Slave mode */
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
	
			LIN_FSM = Break;	
			ResponseDataByteIndex=0;
			break;
		
		/* ------------------------------------- */
		/* STATE Break : Waiting for Synch Break */
		/* ------------------------------------- */
		case Break:
		
			if (BreakReceived)
			{
				BreakReceived=0;
				StartLINReceptionTimeout();										
				LIN_FSM = SynchField;
			}	
			else if (DataReceived)
			{
				DataReceived=0;
			}			
			break;
			
		/* ------------------------------------------ */
		/* STATE SynchField : Waiting for Synch Field */
		/* ------------------------------------------ */
		case SynchField:
		
			if (DataReceived&!ReceptionError)
			{
				DataReceived=0;
				if (USART1Data==0x55)
				{
					LIN_FSM = Identifier;						
				}
				else
				{
					LIN_FSM = Idle;
				}
			}
			else if (ReceptionError)
			{
				ReceptionError=0;	
				LINError();
				LIN_FSM = Idle;
			}				
			break;
			
		/* ------------------------------------------ */
		/* STATE IDField : Waiting for ID Field 			*/
		/* ------------------------------------------ */
		case Identifier:
		
			if (DataReceived&!ReceptionError)
			{
				DataReceived=0;
				/* Store ID for enhanced checksum calculation */
				LINChecksumBuffer[0]=USART1Data;		
				ResponseDataByteIndex=1; /* index for 1st data */
				StartLINReceptionTimeout();
				switch (USART1Data)
				{	
					case MS0ID:
						LIN_FSM = DataReception;													
						DLC=8;
						break;
					
					case MS2ID:
						for (Index=0;Index<8;Index++)
						{
							DataToSend[Index]=DataBuffer[1][Index];					
						}
						LIN_FSM = DataTransmission;				
						DLC=8;
						break;
						
					case SM1ID:
						LIN_FSM = DataReception;											
						DLC=4;
						break;
						
					case SM3ID:
						for (Index=0;Index<8;Index++)
						{
							DataToSend[Index]=DataBuffer[3][Index];					
						}							
						LIN_FSM = DataTransmission;						
						DLC=4;
						break;
												
					default: /* Discard response */				
						LIN_FSM = Idle;									
						break;
					
				}	/* switch (USART1Data) */
			}	

			else if (ReceptionError)
			{
				ReceptionError=0;
				LINError();
				LIN_FSM = Idle;
			}

			break;
			
		/* -------------------------------------*/
		/* STATE DataReception : wait for data  */
		/* ------------------------------------ */
		case DataReception:			
		
			if (DataReceived&!ReceptionError)
			{
				DataReceived=0;
				/* Data reception */
				if (ResponseDataByteIndex<=DLC)
				{
					/* Store Data */
					LINChecksumBuffer[ResponseDataByteIndex]=USART1Data;						
					ResponseDataByteIndex++;
				}					
				/* End of frame */
				else
				{
					LINChecksumBuffer[ResponseDataByteIndex]=USART1Data;
											
					if (LINChecksum(LINChecksumBuffer,(DLC+1))==LINChecksumBuffer[ResponseDataByteIndex])						
					{
						{
							uint8_t i;
							for (i=0;i<DLC;i++)
							{
								if (LINChecksumBuffer[0]==MS0ID)
								{
									DataBuffer[0][i]=LINChecksumBuffer[i+1]; // Store Response
								}
								else if (LINChecksumBuffer[0]==SM1ID)
								{
									DataBuffer[2][i]=LINChecksumBuffer[i+1]; // Store Response
								}
							}
						}
					}
					else
					{
						LINError();
						ChecksumError=1;
					}	
					
					LIN_FSM = Idle;
				}	
					
			}
			else if (ReceptionError)
			{
				DataReceived=0;
				ReceptionError=0;
				LINError();
				LIN_FSM = Idle;
			}
			break;
			
		/* -------------------------------------------- */
		/* STATE DataTransmission : send data					  */
		/* --------------------------------------------	*/
		case DataTransmission:				
				
			if (ResponseDataByteIndex==1)			
			{	
				USART_SendData8(USART1, DataToSend[0]); /* Send 1st data */
				ResponseDataByteIndex++;
			}
			else
			{	
				if (DataReceived&!ReceptionError)
				{
					DataReceived=0;
					/* Data transmission */
					if (ResponseDataByteIndex<(DLC+2))
					{
						if (USART1Data==DataToSend[ResponseDataByteIndex-2]) /* Check possible bit error */
						{
							LINChecksumBuffer[ResponseDataByteIndex-1]=USART1Data;
							if (ResponseDataByteIndex==(DLC+1))
							{
								DataToSend[ResponseDataByteIndex-1]=LINChecksum(LINChecksumBuffer,(DLC+1));																
							}
							USART_SendData8(USART1, DataToSend[ResponseDataByteIndex-1]); /* Send data */
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
						if (USART1Data!=DataToSend[ResponseDataByteIndex-2])
						{
							LINError();
							ChecksumError=1;
						}							
						LIN_FSM = Idle;
					}	
				}
				else if (ReceptionError)
				{
					DataReceived=0;
					ReceptionError=0;
					LINError();
					LIN_FSM = Idle;						
				}
			}			
			break;
	}
}

		
/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  Param1     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @param  Param2     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @retval returntype < Add here the description of the returned value >
  */
uint8_t LINChecksum (uint8_t* Checksum_Buffer, uint8_t Data_Number)
{
	uint8_t i=0;
	uint16_t Sum=0;
	uint16_t Sum1=0;
	
	for(i=0;i<Data_Number;i++)
	{
		Sum = Sum + *(Checksum_Buffer+i);
		
		Sum1 = Sum>>8;
		if( Sum1 > 0 )
		{
			Sum++;
			Sum &= ~0x0100;
		}
	}
	return (uint8_t)(~Sum);	
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  Param1     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @param  Param2     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @retval returntype < Add here the description of the returned value >
  */
uint8_t LIN_ReadData(uint8_t FrameNumber, uint8_t BytePosition)
{
	return (DataBuffer[FrameNumber][BytePosition]);
}
	
/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  Param1     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @param  Param2     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @retval returntype < Add here the description of the returned value >
  */
void LIN_WriteData(uint8_t FrameNumber, uint8_t BytePosition, uint8_t Value)
{
	DataBuffer[FrameNumber][BytePosition]=Value;
}


/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void StartLINReceptionTimeout(void)
{
	LINReceptionTimeout=TRUE;	
	LINReceptionTimeoutValue=0;
	GPIO_ResetBits(GPIOE, (GPIO_Pin_TypeDef)GPIO_Pin_7); /* LD3 red LED OFF */
	LINCommunicationStopped=FALSE;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void StopLINReceptionTimeout(void)
{
	LINReceptionTimeout=FALSE;	
	LINReceptionTimeoutValue=0;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  Param1     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @param  Param2     < Add here the parameter description > 
  * @note   < OPTIONAL: add here specific note for this parameter >
  * @retval returntype < Add here the description of the returned value >
  */
	
bool LINReceptionTimeoutElapsed(void)
{
	if (LINReceptionTimeoutValue>LIN_RECEPTION_TIMEOUT)
	{
		LINError();
		return(TRUE);
	}
	else return (FALSE);
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void LINError(void)
{		
		LINCommunicationStopped=TRUE;
}

  
  /************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/