/**
  ******************************************************************************
  * @file    can.c
  * @author  MCD Application Team
  * @version VX.Y.ZRCx
  * @date    DD-Month-2012
  * @brief   CAN functions
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
#include "can.h"
#include "main.h"

/* External variables --------------------------------------------------------*/
extern bool ErrorState;

/* Private typedef -----------------------------------------------------------*/
/* Private defines -----------------------------------------------------------*/
#define MS0ID 0x100 /* Master to slave frame 0, ID=0x100 */
#define MS2ID 0x300 /* Master to slave frame 2, ID=0x200 */
#define SM1ID 0x200 /* Slave to master frame 1, ID=0x300 */ 
#define SM3ID 0x400 /* Slave to master frame 3, ID=0x400 */
/* Private macros ------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/
static CAN_TxStatus_TypeDef status = CAN_TxStatus_Failed;
static CAN_Id_TypeDef Tx_IDE = CAN_Id_Standard;
static CAN_RTR_TypeDef Tx_RTR = CAN_RTR_Data;
static uint8_t Tx_DLC = 0;
static uint8_t Tx_Data[8] = {0};
static uint32_t Tx_Id = 0;
static uint8_t SendCANFrame=0;
static uint8_t CAN_DataBuffer[4][8];
static uint8_t FrameNumber=0;

uint8_t FrameReceived=0; /* Flag to indicate CAN frame reception */
bool TransmissionEnable=FALSE;
bool CANMaster=FALSE;

static bool CANTimebaseTick = FALSE;

/* Private function prototypes -----------------------------------------------*/
void SetCANTimebaseTick(void);
static void ClearCANTimebaseTick(void);
static uint8_t TestCANTimebaseTick(void);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void CAN_Config(void)
{
  CAN_InitStatus_TypeDef status = CAN_InitStatus_Failed;
  
  /* Filter Parameters */
  CAN_FilterNumber_TypeDef CAN_FilterNumber;
  FunctionalState CAN_FilterActivation;
  CAN_FilterMode_TypeDef CAN_FilterMode;
  CAN_FilterScale_TypeDef CAN_FilterScale;
  uint8_t CAN_FilterID1;
  uint8_t CAN_FilterID2;
  uint8_t CAN_FilterID3;
  uint8_t CAN_FilterID4;
  uint8_t CAN_FilterIDMask1;
  uint8_t CAN_FilterIDMask2;
  uint8_t CAN_FilterIDMask3;
  uint8_t CAN_FilterIDMask4; 
  
  /* Init Parameters*/
  CAN_MasterCtrl_TypeDef CAN_MasterCtrl;
  CAN_Mode_TypeDef CAN_Mode;
  CAN_SynJumpWidth_TypeDef CAN_SynJumpWidth;
  CAN_BitSeg1_TypeDef CAN_BitSeg1;
  CAN_BitSeg2_TypeDef CAN_BitSeg2;
  uint8_t CAN_Prescaler;  
  
  /* CAN register init */
  CAN_DeInit();
    
  /* CAN  init */
  CAN_MasterCtrl=CAN_MasterCtrl_AllDisabled;
	//CAN Loop Back Mode JNa
  //CAN_Mode = CAN_Mode_LoopBack;
	CAN_Mode = CAN_Mode_Normal;
    
  /*CAN_SynJumpWidth = CAN_SynJumpWidth_1TimeQuantum;
  CAN_BitSeg1 = CAN_BitSeg1_5TimeQuantum;
  CAN_BitSeg2 = CAN_BitSeg2_2TimeQuantum;
  CAN_Prescaler = 4;*/
  
  CAN_SynJumpWidth = CAN_SynJumpWidth_1TimeQuantum;
  CAN_BitSeg1 = CAN_BitSeg1_8TimeQuantum;
  CAN_BitSeg2 = CAN_BitSeg2_7TimeQuantum;
  CAN_Prescaler = 2; /* 500kbit/s */
  
  status = CAN_Init(CAN_MasterCtrl, CAN_Mode, CAN_SynJumpWidth, CAN_BitSeg1, \
                    CAN_BitSeg2, CAN_Prescaler);

  /* CAN filter init */
  CAN_FilterNumber = CAN_FilterNumber_0;
  CAN_FilterActivation = ENABLE;
  CAN_FilterMode = CAN_FilterMode_IdMask;
  CAN_FilterScale = CAN_FilterScale_32Bit;
  CAN_FilterID1=0;  
  CAN_FilterID2=0;
  CAN_FilterID3=0;
  CAN_FilterID4=0;
  CAN_FilterIDMask1=0;
  CAN_FilterIDMask2=0;
  CAN_FilterIDMask3=0;
  CAN_FilterIDMask4=0;  
  CAN_FilterInit(CAN_FilterNumber, CAN_FilterActivation, CAN_FilterMode, 
                 CAN_FilterScale,CAN_FilterID1, CAN_FilterID2, CAN_FilterID3,
                 CAN_FilterID4,CAN_FilterIDMask1, CAN_FilterIDMask2, 
                 CAN_FilterIDMask3, CAN_FilterIDMask4);
        
  /* Enable Fifo message pending interrupt*/
  /* Message reception is done by CAN_RX ISR*/
  CAN_ITConfig(CAN_IT_FMP, ENABLE);
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void CAN_Task(void)
{
	
	uint8_t Index=0;
	
	if(TestCANTimebaseTick())
	{		
		ClearCANTimebaseTick();
		
		/* CAN Reception */
		
		if (FrameReceived)
		{
			FrameReceived=0;
						
			if ((uint16_t)CAN_GetReceivedId()==SM1ID)
			{				
				for (Index=0;Index<8;Index++)
				{
					CAN_DataBuffer[1][Index]=CAN_GetReceivedData(Index);
				}				
			}
			if ((uint16_t)CAN_GetReceivedId()==SM3ID)
			{
				for (Index=0;Index<4;Index++)
				{
					CAN_DataBuffer[3][Index]=CAN_GetReceivedData(Index);
				}
				
			}
			
			if ((uint16_t)CAN_GetReceivedId()==MS0ID)
			{
				CANMaster = FALSE;
				TransmissionEnable=TRUE;
				if (!ErrorState) GPIO_WriteLow(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3); /* LD3 red LED OFF */
				for (Index=0;Index<8;Index++)
				{
					CAN_DataBuffer[0][Index]=CAN_GetReceivedData(Index);
				}					
			}
			if ((uint16_t)CAN_GetReceivedId()==MS2ID)
			{
				CANMaster = FALSE;
				TransmissionEnable=TRUE;
				if (!ErrorState) GPIO_WriteLow(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3); /* LD3 red LED OFF */
				for (Index=0;Index<4;Index++)
				{
					CAN_DataBuffer[2][Index]=CAN_GetReceivedData(Index);
				}				
			}
			
		}
		
		/* CAN Transmission */
		
		SendCANFrame++;
		if ((TransmissionEnable==TRUE)&&(SendCANFrame>20))
		{
			
			SET_DEBUG_PIN_4;
			SendCANFrame=0;
			FrameNumber++;
			if (FrameNumber>3) FrameNumber=0;
			
			switch (FrameNumber)
			{	
				case 0:		
					if (CANMaster==TRUE)
					{
						/* Transmit Parameters*/
						Tx_Id = MS0ID;
						Tx_DLC = 8;
						{	
							uint8_t Index;
							for (Index=0;Index<8;Index++)
							{
								Tx_Data[Index]=CAN_DataBuffer[0][Index];
							}
						}
						/* Sender send Frame */
						status = CAN_Transmit(Tx_Id,Tx_IDE,Tx_RTR,Tx_DLC,Tx_Data);
					}
					break;
					
				case 1:	
					if (CANMaster==FALSE)
					{				
						/* Transmit Parameters*/
						Tx_Id = SM1ID;
						Tx_IDE = CAN_Id_Standard;
						Tx_RTR = CAN_RTR_Data;
						Tx_DLC = 8;
						{	
							uint8_t Index;
							for (Index=0;Index<8;Index++)
							{
								Tx_Data[Index]=CAN_DataBuffer[1][Index];
							}
						}
						/* Sender send Frame */
						status = CAN_Transmit(Tx_Id,Tx_IDE,Tx_RTR,Tx_DLC,Tx_Data);
					}
					break;;
					
				case 2:		
					if (CANMaster==TRUE)
					{
						/* Transmit Parameters*/
						Tx_Id = MS2ID;
						Tx_DLC = 4;
						{	
							uint8_t Index;
							for (Index=0;Index<4;Index++)
							{
								Tx_Data[Index]=CAN_DataBuffer[2][Index];
							}
						}     
						/* Sender send Frame */
						status = CAN_Transmit(Tx_Id,Tx_IDE,Tx_RTR,Tx_DLC,Tx_Data);
					}
					break;
					
				case 3:		
					if (CANMaster==FALSE)
					{				
						/* Transmit Parameters*/
						Tx_Id = SM3ID;
						Tx_DLC = 4;
						{	
							uint8_t Index;
							for (Index=0;Index<4;Index++)
							{
								Tx_Data[Index]=CAN_DataBuffer[3][Index];
							}
						}     
						/* Sender send Frame */
						status = CAN_Transmit(Tx_Id,Tx_IDE,Tx_RTR,Tx_DLC,Tx_Data);
					}
					break;					
					
				default:
					break;
			}
			CLEAR_DEBUG_PIN_4;
		}
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
uint8_t CAN_ReadData(uint8_t FrameNumber, uint8_t BytePosition)
{
	
	return (CAN_DataBuffer[FrameNumber][BytePosition]);
	
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
void CAN_WriteData(uint8_t FrameNumber, uint8_t BytePosition, uint8_t Value)
{
	CAN_DataBuffer[FrameNumber][BytePosition]=Value;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void SetCANTimebaseTick(void)
{
	CANTimebaseTick=1;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void ClearCANTimebaseTick(void)
{
	CANTimebaseTick=0;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
uint8_t TestCANTimebaseTick(void)
{
	if (CANTimebaseTick) return 1;
	else return 0;
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/