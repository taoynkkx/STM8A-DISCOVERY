/**
  ******************************************************************************
  * @file    appli.c
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
#include "stm8s.h"
#include "appli.h"
#include "main.h"

 /* External variables --------------------------------------------------------*/
extern bool TransmissionEnable;
extern bool CANMaster;
extern bool LINSlave;
extern bool ErrorState;

/* External functions --------------------------------------------------------*/
/* lin.c */
extern uint8_t LIN_ReadData(uint8_t, uint8_t);
extern void LIN_WriteData(uint8_t, uint8_t, uint8_t);
/* can.c */
extern uint8_t CAN_ReadData(uint8_t, uint8_t);
extern void CAN_WriteData(uint8_t, uint8_t, uint8_t);
/* adc.c */
extern void ADC_Config(void);
extern uint16_t GetADCData(void);

/* Private typedef -----------------------------------------------------------*/

/* Private defines -----------------------------------------------------------*/

#define CAN_MASTER_TEST_MODE 6
#define CAN_SLAVE_TEST_MODE 7
#define LIN_SLAVE_TEST_MODE 8

#define LD3_RED_LED_ON GPIO_WriteHigh(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3)
#define LD4_GREEN_LED_ON GPIO_WriteHigh(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_3)
#define LD5_GREEN_LED_ON GPIO_WriteHigh(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_0)
#define LD6_GREEN_LED_ON GPIO_WriteHigh(GPIOE, (GPIO_Pin_TypeDef)GPIO_PIN_3)
#define LD7_GREEN_LED_ON GPIO_WriteHigh(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_3)

#define LD3_RED_LED_OFF GPIO_WriteLow(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3)	
#define LD4_GREEN_LED_OFF GPIO_WriteLow(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_3)
#define LD5_GREEN_LED_OFF GPIO_WriteLow(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_0)
#define LD6_GREEN_LED_OFF GPIO_WriteLow(GPIOE, (GPIO_Pin_TypeDef)GPIO_PIN_3)
#define LD7_GREEN_LED_OFF GPIO_WriteLow(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_3)

/* if a STM8AL is slave */

#define READ_STM8AF_LD4_GREEN_LED LIN_ReadData(1,0)
#define READ_STM8AF_LD5_GREEN_LED LIN_ReadData(1,1)
#define READ_STM8AF_LD6_GREEN_LED LIN_ReadData(1,2)
#define READ_STM8AF_LD7_GREEN_LED LIN_ReadData(1,3)
#define READ_STM8AF_LD3_RED_LED LIN_ReadData(1,4)

#define READ_STM8AL_USER1_BUTTON LIN_ReadData(3,0)
#define READ_STM8AL_USER2_BUTTON LIN_ReadData(3,1)

#define WRITE_STM8AL_BAR0(a) LIN_WriteData(0,0,a)
#define WRITE_STM8AL_BAR1(a) LIN_WriteData(0,1,a)
#define WRITE_STM8AL_BAR2(a) LIN_WriteData(0,2,a)
#define WRITE_STM8AL_BAR3(a) LIN_WriteData(0,3,a)
#define WRITE_STM8AL_LD3_RED_LED(a) LIN_WriteData(0,4,a)
#define WRITE_STM8AL_LD4_GREEN_LED(a) LIN_WriteData(0,5,a)

#define WRITE_STM8AF_USER1_BUTTON(a) LIN_WriteData(2,0,a)
#define WRITE_STM8AF_USER2_BUTTON(a) LIN_WriteData(2,1,a)
#define WRITE_STM8AF_RV1_TRIMMER_MSB(a) LIN_WriteData(2,2,a)
#define WRITE_STM8AF_RV1_TRIMMER_LSB(a) LIN_WriteData(2,3,a)

/* if another STM8AF is slave */

#define READ_MASTER_LD4_GREEN_LED LIN_ReadData(1,0)
#define READ_MASTER_LD5_GREEN_LED LIN_ReadData(1,1)
#define READ_MASTER_LD6_GREEN_LED LIN_ReadData(1,2)
#define READ_MASTER_LD7_GREEN_LED LIN_ReadData(1,3)
#define READ_MASTER_LD3_RED_LED LIN_ReadData(1,4)

#define READ_SLAVE_USER1_BUTTON LIN_ReadData(3,0)
#define READ_SLAVE_USER2_BUTTON LIN_ReadData(3,1)
#define READ_SLAVE_RV1_TRIMMER_MSB LIN_ReadData(3,2)
#define READ_SLAVE_RV1_TRIMMER_LSB LIN_ReadData(3,3)

#define WRITE_SLAVE_LD4_GREEN_LED(a) LIN_WriteData(0,0,a)
#define WRITE_SLAVE_LD5_GREEN_LED(a) LIN_WriteData(0,1,a)
#define WRITE_SLAVE_LD6_GREEN_LED(a) LIN_WriteData(0,2,a)
#define WRITE_SLAVE_LD7_GREEN_LED(a) LIN_WriteData(0,3,a)
#define WRITE_SLAVE_LD3_RED_LED(a) LIN_WriteData(0,4,a)

#define WRITE_MASTER_USER1_BUTTON(a) LIN_WriteData(2,0,a)
#define WRITE_MASTER_USER2_BUTTON(a) LIN_WriteData(2,1,a)
#define WRITE_MASTER_RV1_TRIMMER_MSB(a) LIN_WriteData(2,2,a)
#define WRITE_MASTER_RV1_TRIMMER_LSB(a) LIN_WriteData(2,3,a)

/* LIN slave */

#define WRITE_MASTER_LD4_GREEN_LED(a) LIN_WriteData(1,0,a)
#define WRITE_MASTER_LD5_GREEN_LED(a) LIN_WriteData(1,1,a)
#define WRITE_MASTER_LD6_GREEN_LED(a) LIN_WriteData(1,2,a)
#define WRITE_MASTER_LD7_GREEN_LED(a) LIN_WriteData(1,3,a)
#define WRITE_MASTER_LD3_RED_LED(a) LIN_WriteData(1,4,a)

#define WRITE_SLAVE_USER1_BUTTON(a) LIN_WriteData(3,0,a)
#define WRITE_SLAVE_USER2_BUTTON(a) LIN_WriteData(3,1,a)
#define WRITE_SLAVE_RV1_TRIMMER_MSB(a) LIN_WriteData(3,2,a)
#define WRITE_SLAVE_RV1_TRIMMER_LSB(a) LIN_WriteData(3,3,a)

#define READ_SLAVE_LD4_GREEN_LED LIN_ReadData(0,0)
#define READ_SLAVE_LD5_GREEN_LED LIN_ReadData(0,1)
#define READ_SLAVE_LD6_GREEN_LED LIN_ReadData(0,2)
#define READ_SLAVE_LD7_GREEN_LED LIN_ReadData(0,3)
#define READ_SLAVE_LD3_RED_LED LIN_ReadData(0,4)

#define READ_MASTER_USER1_BUTTON LIN_ReadData(2,0)
#define READ_MASTER_USER2_BUTTON LIN_ReadData(2,1)
#define READ_MASTER_RV1_TRIMMER_MSB LIN_ReadData(2,2)
#define READ_MASTER_RV1_TRIMMER_LSB LIN_ReadData(2,3)


#define WRITE_CAN_MASTER_LD4_GREEN_LED(a) CAN_WriteData(1,0,a)
#define WRITE_CAN_MASTER_LD5_GREEN_LED(a) CAN_WriteData(1,1,a)
#define WRITE_CAN_MASTER_LD6_GREEN_LED(a) CAN_WriteData(1,2,a)
#define WRITE_CAN_MASTER_LD7_GREEN_LED(a) CAN_WriteData(1,3,a)
#define WRITE_CAN_MASTER_LD3_RED_LED(a) CAN_WriteData(1,4,a)

#define WRITE_CAN_SLAVE_USER1_BUTTON(a) CAN_WriteData(3,0,a)
#define WRITE_CAN_SLAVE_USER2_BUTTON(a) CAN_WriteData(3,1,a)
#define WRITE_CAN_SLAVE_RV1_TRIMMER_MSB(a) CAN_WriteData(3,2,a)
#define WRITE_CAN_SLAVE_RV1_TRIMMER_LSB(a) CAN_WriteData(3,3,a)

#define READ_CAN_SLAVE_LD4_GREEN_LED CAN_ReadData(0,0)
#define READ_CAN_SLAVE_LD5_GREEN_LED CAN_ReadData(0,1)
#define READ_CAN_SLAVE_LD6_GREEN_LED CAN_ReadData(0,2)
#define READ_CAN_SLAVE_LD7_GREEN_LED CAN_ReadData(0,3)
#define READ_CAN_SLAVE_LD3_RED_LED CAN_ReadData(0,4)

#define READ_CAN_MASTER_USER1_BUTTON CAN_ReadData(2,0)
#define READ_CAN_MASTER_USER2_BUTTON CAN_ReadData(2,1)
#define READ_CAN_MASTER_RV1_TRIMMER_MSB CAN_ReadData(2,2)
#define READ_CAN_MASTER_RV1_TRIMMER_LSB CAN_ReadData(2,3)


#define READ_CAN_MASTER_LD4_GREEN_LED CAN_ReadData(1,0)
#define READ_CAN_MASTER_LD5_GREEN_LED CAN_ReadData(1,1)
#define READ_CAN_MASTER_LD6_GREEN_LED CAN_ReadData(1,2)
#define READ_CAN_MASTER_LD7_GREEN_LED CAN_ReadData(1,3)
#define READ_CAN_MASTER_LD3_RED_LED CAN_ReadData(1,4)

#define READ_CAN_SLAVE_USER1_BUTTON CAN_ReadData(3,0)
#define READ_CAN_SLAVE_USER2_BUTTON CAN_ReadData(3,1)
#define READ_CAN_SLAVE_RV1_TRIMMER_MSB CAN_ReadData(3,2)
#define READ_CAN_SLAVE_RV1_TRIMMER_LSB CAN_ReadData(3,3)

#define WRITE_CAN_SLAVE_LD4_GREEN_LED(a) CAN_WriteData(0,0,a)
#define WRITE_CAN_SLAVE_LD5_GREEN_LED(a) CAN_WriteData(0,1,a)
#define WRITE_CAN_SLAVE_LD6_GREEN_LED(a) CAN_WriteData(0,2,a)
#define WRITE_CAN_SLAVE_LD7_GREEN_LED(a) CAN_WriteData(0,3,a)
#define WRITE_CAN_SLAVE_LD3_RED_LED(a) CAN_WriteData(0,4,a)

#define WRITE_CAN_MASTER_USER1_BUTTON(a) CAN_WriteData(2,0,a)
#define WRITE_CAN_MASTER_USER2_BUTTON(a) CAN_WriteData(2,1,a)
#define WRITE_CAN_MASTER_RV1_TRIMMER_MSB(a) CAN_WriteData(2,2,a)
#define WRITE_CAN_MASTER_RV1_TRIMMER_LSB(a) CAN_WriteData(2,3,a)

/* Private macros ------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/


static uint8_t Data0=0;
static uint8_t Data1=0;
static uint8_t BarStatus=0;
static bool AppliTimebaseTick = FALSE;

bool UserButton1;
bool UserButton2;
uint8_t StartupDisplay=0;
bool StartupCompleted=FALSE;

/* Private function prototypes -----------------------------------------------*/

static bool UserButton1Status(void);
static bool UserButton2Status(void);
static void IncrementStatus(void);
static void DecrementStatus(void);
static void UpdateBarStatus(void);
static void UpdateMasterLedStatus(void);
static void UpdateSlaveLedStatus(void);
static void ClearAppliTimebaseTick(void);
static bool TestAppliTimebaseTick(void);
static void LED_Display(uint8_t Ledstatus);

void SetAppliTimebaseTick(void);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief converts a number into char
  * @caller several callers for display values
  * @param Number digit to displays
  *  p_tab values in array in ASCII   
  * @retval None
  */ 
void Appli(void)
{

	if (TestAppliTimebaseTick())
	{
		ClearAppliTimebaseTick();
		
		SET_DEBUG_PIN_3;
		
		if (StartupDisplay<23)
		{
			StartupDisplay++;
			
			/* CAN "master" test mode */
			if ((CANMaster==TRUE)&&(TransmissionEnable==TRUE)) LED_Display(CAN_MASTER_TEST_MODE);
			
			/* CAN "slave" test mode */
			/*else if ((CANMaster==FALSE)&&(TransmissionEnable==TRUE)) LED_Display(CAN_SLAVE_TEST_MODE);*/ /* useless */
			
			/* LIN slave test mode */
			else if (LINSlave==TRUE) LED_Display(LIN_SLAVE_TEST_MODE);
			
			/* LIN master demo or test mode */
			else LED_Display(StartupDisplay>>2);
		}	
		else
		{
			StartupCompleted=TRUE;
			/*Start ADC Conversion */
			ADC2_StartConversion();
			
			/* read RV1 trimmer and update LIN signal */
			Data0 = (uint8_t) GetADCData();
			Data1 = (uint8_t) (GetADCData()>>8);
			
			/* CAN "Master" test mode */
			if ((TransmissionEnable==TRUE)&&(CANMaster==TRUE))
			{			
				WRITE_CAN_MASTER_RV1_TRIMMER_LSB(Data0);
				WRITE_CAN_MASTER_RV1_TRIMMER_MSB(Data1);
				
				/*Check if USER1 button was pushed, and update LIN signal */
				if (UserButton1Status()) 
				{			
					WRITE_CAN_MASTER_USER1_BUTTON(TRUE);
					IncrementStatus();			
				}
				else 
				{			
					WRITE_CAN_MASTER_USER1_BUTTON(FALSE);		
				}
				
				/*Check if USER2 button was pushed, and update LIN signal */		
				if (UserButton2Status())
				{			
					WRITE_CAN_MASTER_USER2_BUTTON(TRUE);
					DecrementStatus();
				}
				else
				{
					WRITE_CAN_MASTER_USER2_BUTTON(FALSE);			
				}
				if(!ErrorState)
				{
					/* Read LIN signals and update green LEDs state */
					if (READ_CAN_MASTER_LD4_GREEN_LED) LD4_GREEN_LED_ON; else LD4_GREEN_LED_OFF;
					if (READ_CAN_MASTER_LD5_GREEN_LED) LD5_GREEN_LED_ON; else LD5_GREEN_LED_OFF;
					if (READ_CAN_MASTER_LD6_GREEN_LED) LD6_GREEN_LED_ON; else LD6_GREEN_LED_OFF;
					if (READ_CAN_MASTER_LD7_GREEN_LED) LD7_GREEN_LED_ON; else LD7_GREEN_LED_OFF;
				}
			}
			
			/* CAN "slave" test mode */
			else if ((TransmissionEnable==TRUE)&&(CANMaster==FALSE))
			{			
				WRITE_CAN_SLAVE_RV1_TRIMMER_LSB(Data0);
				WRITE_CAN_SLAVE_RV1_TRIMMER_MSB(Data1);
				
				/*Check if USER1 button was pushed, and update LIN signal */
				if (UserButton1Status()) 
				{			
					WRITE_CAN_SLAVE_USER1_BUTTON(TRUE);
					IncrementStatus();			
				}
				else 
				{			
					WRITE_CAN_SLAVE_USER1_BUTTON(FALSE);		
				}
				
				/*Check if USER2 button was pushed, and update LIN signal */		
				if (UserButton2Status())
				{			
					WRITE_CAN_SLAVE_USER2_BUTTON(TRUE);
					DecrementStatus();
				}
				else
				{
					WRITE_CAN_SLAVE_USER2_BUTTON(FALSE);			
				}
				if(!ErrorState)
				{
					/* Read LIN signals and update green LEDs state */
					if (READ_CAN_SLAVE_LD4_GREEN_LED) LD4_GREEN_LED_ON; else LD4_GREEN_LED_OFF;
					if (READ_CAN_SLAVE_LD5_GREEN_LED) LD5_GREEN_LED_ON; else LD5_GREEN_LED_OFF;
					if (READ_CAN_SLAVE_LD6_GREEN_LED) LD6_GREEN_LED_ON; else LD6_GREEN_LED_OFF;
					if (READ_CAN_SLAVE_LD7_GREEN_LED) LD7_GREEN_LED_ON; else LD7_GREEN_LED_OFF;
				}
			}
			
			else /* LIN master or slave */
			{
				/* LIN Slave test mode */
				if (LINSlave==TRUE)
				{
				
					WRITE_SLAVE_RV1_TRIMMER_LSB(Data0);
					WRITE_SLAVE_RV1_TRIMMER_MSB(Data1);
					
					/*Check if USER1 button was pushed, and update LIN signal */
					if (UserButton1Status()) 
					{			
						WRITE_SLAVE_USER1_BUTTON(TRUE);
						IncrementStatus();			
					}
					else 
					{			
						WRITE_SLAVE_USER1_BUTTON(FALSE);		
					}
					
					/*Check if USER2 button was pushed, and update LIN signal */		
					if (UserButton2Status())
					{			
						WRITE_SLAVE_USER2_BUTTON(TRUE);
						DecrementStatus();
					}
					else
					{
						WRITE_SLAVE_USER2_BUTTON(FALSE);			
					}
					if(!ErrorState)
					{
						/* Read LIN signals and update green LEDs state */
						if (READ_SLAVE_LD4_GREEN_LED) LD4_GREEN_LED_ON; else LD4_GREEN_LED_OFF;
						if (READ_SLAVE_LD5_GREEN_LED) LD5_GREEN_LED_ON; else LD5_GREEN_LED_OFF;
						if (READ_SLAVE_LD6_GREEN_LED) LD6_GREEN_LED_ON; else LD6_GREEN_LED_OFF;
						if (READ_SLAVE_LD7_GREEN_LED) LD7_GREEN_LED_ON; else LD7_GREEN_LED_OFF;
					}
				}
				/* LIN Master demo and test mode */
				else
				{		
					WRITE_MASTER_RV1_TRIMMER_LSB(Data0);
					WRITE_MASTER_RV1_TRIMMER_MSB(Data1);
					
					/*Check if USER1 button was pushed, and update LIN signal */
					if (UserButton1Status()) 
					{			
						WRITE_MASTER_USER1_BUTTON(TRUE);
						IncrementStatus();			
					}
					else 
					{			
						WRITE_MASTER_USER1_BUTTON(FALSE);		
					}
					
					/*Check if USER2 button was pushed, and update LIN signal */		
					if (UserButton2Status())
					{			
						WRITE_MASTER_USER2_BUTTON(TRUE);
						DecrementStatus();
					}
					else
					{
						WRITE_MASTER_USER2_BUTTON(FALSE);			
					}
					if(!ErrorState)
					{
						/* Read LIN signals and update green LEDs state */
						if (READ_MASTER_LD4_GREEN_LED) LD4_GREEN_LED_ON; else LD4_GREEN_LED_OFF;
						if (READ_MASTER_LD5_GREEN_LED) LD5_GREEN_LED_ON; else LD5_GREEN_LED_OFF;
						if (READ_MASTER_LD6_GREEN_LED) LD6_GREEN_LED_ON; else LD6_GREEN_LED_OFF;
						if (READ_MASTER_LD7_GREEN_LED) LD7_GREEN_LED_ON; else LD7_GREEN_LED_OFF;
					}
				}
			}
			
		}
				
		CLEAR_DEBUG_PIN_3;
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
bool UserButton1Status(void)
{

	if (UserButton1==TRUE)
	{
		UserButton1=FALSE;
		return(TRUE);
	}
	else
	{
		return(FALSE);
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
bool UserButton2Status(void)
{

	if (UserButton2==TRUE)
	{
		UserButton2=FALSE;
		return(TRUE);
	}
	else
	{
		return(FALSE);
	}
}


/**
  * @brief converts a number into char
  * @caller several callers for display values
  * @param Number digit to displays
  *  p_tab values in array in ASCII   
  * @retval None
  */ 
void IncrementStatus(void)
{	
	if (BarStatus<4)
	{
		BarStatus++;
		if ((TransmissionEnable==TRUE)&&(CANMaster==TRUE)) UpdateSlaveLedStatus(); /* CAN "Master" test mode */
		else if ((TransmissionEnable==TRUE)&&(CANMaster==FALSE)) UpdateMasterLedStatus(); /* CAN "Slave" tes mode */
		else UpdateBarStatus(); /* LIN Master demo or test mode */

	}
}

/**
  * @brief converts a number into char
  * @caller several callers for display values
  * @param Number digit to displays
  *  p_tab values in array in ASCII   
  * @retval None
  */ 
void DecrementStatus(void)
{	
	if (BarStatus>0)
	{
		BarStatus--;
		if ((TransmissionEnable==TRUE)&&(CANMaster==TRUE)) UpdateSlaveLedStatus(); /* CAN "Master" test mode */
		else if ((TransmissionEnable==TRUE)&&(CANMaster==FALSE)) UpdateMasterLedStatus(); /* CAN "Slave" test mode */
		else UpdateBarStatus(); /* LIN Master demo or test mode */

	}
}


/**
  * @brief converts a number into char
  * @caller several callers for display values
  * @param Number digit to displays
  *  p_tab values in array in ASCII   
  * @retval None
  */ 
void UpdateBarStatus(void)
{
	
	/* LIN slave tes mode */
	if (LINSlave==TRUE)
	{
		switch (BarStatus)
		{
			case 0:
				WRITE_MASTER_LD4_GREEN_LED(0);
				WRITE_MASTER_LD5_GREEN_LED(0);
				WRITE_MASTER_LD6_GREEN_LED(0);
				WRITE_MASTER_LD7_GREEN_LED(0);
				break;
				
			case 1:
				WRITE_MASTER_LD4_GREEN_LED(1);
				WRITE_MASTER_LD5_GREEN_LED(0);
				WRITE_MASTER_LD6_GREEN_LED(0);
				WRITE_MASTER_LD7_GREEN_LED(0);
				break;
			
			case 2:
				WRITE_MASTER_LD4_GREEN_LED(1);
				WRITE_MASTER_LD5_GREEN_LED(1);
				WRITE_MASTER_LD6_GREEN_LED(0);
				WRITE_MASTER_LD7_GREEN_LED(0);
				break;
				
			case 3:
				WRITE_MASTER_LD4_GREEN_LED(1);
				WRITE_MASTER_LD5_GREEN_LED(1);
				WRITE_MASTER_LD6_GREEN_LED(1);
				WRITE_MASTER_LD7_GREEN_LED(0);
				break;		

			case 4:
				WRITE_MASTER_LD4_GREEN_LED(1);
				WRITE_MASTER_LD5_GREEN_LED(1);
				WRITE_MASTER_LD6_GREEN_LED(1);
				WRITE_MASTER_LD7_GREEN_LED(1);
				break;			
				
			default:
				WRITE_MASTER_LD4_GREEN_LED(0);
				WRITE_MASTER_LD5_GREEN_LED(0);
				WRITE_MASTER_LD6_GREEN_LED(0);
				WRITE_MASTER_LD7_GREEN_LED(0);
				break;
		}
	}
	
	/* LIN Master demo or test mode*/
	else	
	{
		switch (BarStatus)
		{
			case 0:
				WRITE_STM8AL_BAR0(0);
				WRITE_STM8AL_BAR1(0);
				WRITE_STM8AL_BAR2(0);
				WRITE_STM8AL_BAR3(0);
				break;
				
			case 1:
				WRITE_STM8AL_BAR0(1);
				WRITE_STM8AL_BAR1(0);
				WRITE_STM8AL_BAR2(0);
				WRITE_STM8AL_BAR3(0);
				break;
			
			case 2:
				WRITE_STM8AL_BAR0(1);
				WRITE_STM8AL_BAR1(1);
				WRITE_STM8AL_BAR2(0);
				WRITE_STM8AL_BAR3(0);
				break;
				
			case 3:
				WRITE_STM8AL_BAR0(1);
				WRITE_STM8AL_BAR1(1);
				WRITE_STM8AL_BAR2(1);
				WRITE_STM8AL_BAR3(0);
				break;		

			case 4:
				WRITE_STM8AL_BAR0(1);
				WRITE_STM8AL_BAR1(1);
				WRITE_STM8AL_BAR2(1);
				WRITE_STM8AL_BAR3(1);
				break;			
				
			default:
				WRITE_STM8AL_BAR0(0);
				WRITE_STM8AL_BAR1(0);
				WRITE_STM8AL_BAR2(0);
				WRITE_STM8AL_BAR3(0);
				break;
		}
	}
}


void UpdateMasterLedStatus(void)
{
	
	switch (BarStatus)
	{
		case 0:
			WRITE_CAN_MASTER_LD4_GREEN_LED(0);
			WRITE_CAN_MASTER_LD5_GREEN_LED(0);
			WRITE_CAN_MASTER_LD6_GREEN_LED(0);
			WRITE_CAN_MASTER_LD7_GREEN_LED(0);
			break;
			
		case 1:
			WRITE_CAN_MASTER_LD4_GREEN_LED(1);
			WRITE_CAN_MASTER_LD5_GREEN_LED(0);
			WRITE_CAN_MASTER_LD6_GREEN_LED(0);
			WRITE_CAN_MASTER_LD7_GREEN_LED(0);
			break;
		
		case 2:
			WRITE_CAN_MASTER_LD4_GREEN_LED(1);
			WRITE_CAN_MASTER_LD5_GREEN_LED(1);
			WRITE_CAN_MASTER_LD6_GREEN_LED(0);
			WRITE_CAN_MASTER_LD7_GREEN_LED(0);
			break;
			
		case 3:
			WRITE_CAN_MASTER_LD4_GREEN_LED(1);
			WRITE_CAN_MASTER_LD5_GREEN_LED(1);
			WRITE_CAN_MASTER_LD6_GREEN_LED(1);
			WRITE_CAN_MASTER_LD7_GREEN_LED(0);
			break;		

		case 4:
			WRITE_CAN_MASTER_LD4_GREEN_LED(1);
			WRITE_CAN_MASTER_LD5_GREEN_LED(1);
			WRITE_CAN_MASTER_LD6_GREEN_LED(1);
			WRITE_CAN_MASTER_LD7_GREEN_LED(1);
			break;			
			
		default:
			WRITE_CAN_MASTER_LD4_GREEN_LED(0);
			WRITE_CAN_MASTER_LD5_GREEN_LED(0);
			WRITE_CAN_MASTER_LD6_GREEN_LED(0);
			WRITE_CAN_MASTER_LD7_GREEN_LED(0);
			break;
	}
}

void UpdateSlaveLedStatus(void)
{
	
	switch (BarStatus)
	{
		case 0:
			WRITE_CAN_SLAVE_LD4_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD5_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD6_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD7_GREEN_LED(0);
			break;
			
		case 1:
			WRITE_CAN_SLAVE_LD4_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD5_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD6_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD7_GREEN_LED(0);
			break;
		
		case 2:
			WRITE_CAN_SLAVE_LD4_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD5_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD6_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD7_GREEN_LED(0);
			break;
			
		case 3:
			WRITE_CAN_SLAVE_LD4_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD5_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD6_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD7_GREEN_LED(0);
			break;		

		case 4:
			WRITE_CAN_SLAVE_LD4_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD5_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD6_GREEN_LED(1);
			WRITE_CAN_SLAVE_LD7_GREEN_LED(1);
			break;			
			
		default:
			WRITE_CAN_SLAVE_LD4_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD5_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD6_GREEN_LED(0);
			WRITE_CAN_SLAVE_LD7_GREEN_LED(0);
			break;
	}
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void SetAppliTimebaseTick(void)
{
	AppliTimebaseTick=TRUE;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void ClearAppliTimebaseTick(void)
{
	AppliTimebaseTick=FALSE;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
bool TestAppliTimebaseTick(void)
{
	if (AppliTimebaseTick) return TRUE;
	else return FALSE;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void LED_Display(uint8_t Ledstatus)
{

  switch((uint8_t)Ledstatus)
  {
	case 0: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;
		LD5_GREEN_LED_OFF;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_OFF;
		break;

	case 1: 
		LD3_RED_LED_ON;
		LD4_GREEN_LED_OFF;
		LD5_GREEN_LED_OFF;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_OFF;
		break;

	case 2: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_ON;
		LD5_GREEN_LED_OFF;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_OFF;
		break;

	case 3: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;
		LD5_GREEN_LED_ON;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_OFF;
		break;

	case 4: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;
		LD5_GREEN_LED_OFF;
		LD6_GREEN_LED_ON;
		LD7_GREEN_LED_OFF;
		break;

	case 5: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;
		LD5_GREEN_LED_OFF;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_ON;
		break;
		
	case 6: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_ON;
		LD5_GREEN_LED_ON;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_OFF;
		break;
		
	case 7: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;
		LD5_GREEN_LED_ON;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_ON;
		break;
		
	case 8: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_ON;
		LD5_GREEN_LED_ON;
		LD6_GREEN_LED_ON;
		LD7_GREEN_LED_ON;
		break;
	
	default: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;
		LD5_GREEN_LED_OFF;
		LD6_GREEN_LED_OFF;
		LD7_GREEN_LED_ON;
		break;
   }
}
 
  /************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/