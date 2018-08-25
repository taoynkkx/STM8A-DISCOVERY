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
#include "stm8l15x.h"
#include "appli.h"
#include "main.h"
#include "lcd.h"

/* External variables --------------------------------------------------------*/
extern bool ErrorState;
/* LCD bar graph: used for display active function */
extern uint8_t t_bar[2];
extern bool LINCommunicationStopped;

/* External functions --------------------------------------------------------*/
extern uint8_t LIN_ReadData(uint8_t, uint8_t);
extern void LIN_WriteData(uint8_t, uint8_t, uint8_t);
extern void convert_into_char(uint16_t number, uint16_t *p_tab);

/* Private typedef -----------------------------------------------------------*/

/* Private defines -----------------------------------------------------------*/

#define WRITE_STM8AF_LD4_GREEN_LED(a) LIN_WriteData(1,0,a)
#define WRITE_STM8AF_LD5_GREEN_LED(a) LIN_WriteData(1,1,a)
#define WRITE_STM8AF_LD6_GREEN_LED(a) LIN_WriteData(1,2,a)
#define WRITE_STM8AF_LD7_GREEN_LED(a) LIN_WriteData(1,3,a)
#define WRITE_STM8AF_LD3_RED_LED(a) LIN_WriteData(1,4,a)

#define WRITE_STM8AL_USER1_BUTTON(a) LIN_WriteData(3,0,a)
#define WRITE_STM8AL_USER2_BUTTON(a) LIN_WriteData(3,1,a)

#define READ_STM8AL_BAR0 LIN_ReadData(0,0)
#define READ_STM8AL_BAR1 LIN_ReadData(0,1)
#define READ_STM8AL_BAR2 LIN_ReadData(0,2)
#define READ_STM8AL_BAR3 LIN_ReadData(0,3)
#define READ_STM8AL_LD3_RED_LED LIN_ReadData(0,4)
#define READ_STM8AL_LD4_GREEN_LED LIN_ReadData(0,5)

#define READ_STM8AF_USER1_BUTTON LIN_ReadData(2,0)
#define READ_STM8AF_USER2_BUTTON LIN_ReadData(2,1)
#define READ_STM8AF_RV1_TRIMMER_MSB LIN_ReadData(2,2)
#define READ_STM8AF_RV1_TRIMMER_LSB LIN_ReadData(2,3)

#define LD3_RED_LED_ON GPIO_SetBits(GPIOE, (GPIO_Pin_TypeDef)GPIO_Pin_7)
#define LD4_GREEN_LED_ON GPIO_SetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_7)

#define LD3_RED_LED_OFF GPIO_ResetBits(GPIOE, (GPIO_Pin_TypeDef)GPIO_Pin_7)	
#define LD4_GREEN_LED_OFF GPIO_ResetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_7)

/* Private macros ------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/


static uint8_t Data0=0;
static uint8_t Data1=0;
static uint8_t LedStatus=0;
static bool AppliTimebaseTick = FALSE;

bool UserButton1;
bool UserButton2;
uint8_t StartupDisplay=0;
bool StartupCompleted=FALSE;

/* Private function prototypes -----------------------------------------------*/

static bool UserButton1Status(void);
static bool UserButton2Status(void);
static void IncrementLedStatus(void);
static void DecrementLedStatus(void);
static void UpdateLedStatus(void);
static void ClearAppliTimebaseTick(void);
static uint8_t TestAppliTimebaseTick(void);
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
	uint16_t Tabconv[6]={0x20,0x20,0x20,0x20,0x20,0x20};
	uint8_t Index1;	
	uint8_t Index2;
	uint8_t Conversion;


	if (TestAppliTimebaseTick())
	{
		ClearAppliTimebaseTick();
		
		SET_DEBUG_PIN_3;
		
		if (StartupDisplay<23)
		{
			StartupDisplay++;
			LED_Display(StartupDisplay>>2);
		}	
		else
		{
			StartupCompleted=TRUE;
		
			if(!ErrorState&!LINCommunicationStopped)
			{

				/*Check if USER1 button was pushed, and update LIN signal */
				if (UserButton1Status()) 
				{			
					WRITE_STM8AL_USER1_BUTTON(TRUE);
					IncrementLedStatus();
				}
				else 
				{			
					WRITE_STM8AL_USER1_BUTTON(FALSE);		
				}
				
				/*Check if USER2 button was pushed, and update LIN signal */		
				if (UserButton2Status())
				{			
					WRITE_STM8AL_USER2_BUTTON(TRUE);
					DecrementLedStatus();
				}
				else
				{
					WRITE_STM8AL_USER2_BUTTON(FALSE);			
				}
				
				/* Read LIN signals and update green LEDs state */
				if (READ_STM8AL_LD4_GREEN_LED) LD4_GREEN_LED_ON; else LD4_GREEN_LED_OFF;		
				
				/* Read LIN signals and update BARs state */
				if (READ_STM8AL_BAR0) BAR0_ON; else BAR0_OFF;
				if (READ_STM8AL_BAR1) BAR1_ON; else BAR1_OFF;
				if (READ_STM8AL_BAR2) BAR2_ON; else BAR2_OFF;
				if (READ_STM8AL_BAR3) BAR3_ON; else BAR3_OFF;		
				/* Refresh LCD  bar */
				LCD_bar();

				Data0 = READ_STM8AF_RV1_TRIMMER_LSB;
				Data1 = READ_STM8AF_RV1_TRIMMER_MSB;
				/* Keep only 8 left MSB bits */
				Conversion = (Data1 << 6) | (Data0 >> 2);
				
				convert_into_char(Conversion/2.55, Tabconv);
				for(Index1=0;Index1<2;Index1++)
				{
					for(Index2=0;Index2<5;Index2++)
					{
						Tabconv[Index2]=Tabconv[Index2+1];
					}
				}
				LCD_GLASS_DisplayStrDeci(Tabconv);
		
			}
			else if (!ErrorState&LINCommunicationStopped)
			{
				BAR0_OFF;
				BAR1_OFF;
				BAR2_OFF;
				BAR3_OFF;
				LCD_bar();
				LCD_GLASS_DisplayString("ERR2");
				GPIO_SetBits(GPIOE, (GPIO_Pin_TypeDef)GPIO_Pin_7); /* red led */
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
void IncrementLedStatus(void)
{	
	if (LedStatus<4)
	{
		LedStatus++;
		UpdateLedStatus();
	}
}

/**
  * @brief converts a number into char
  * @caller several callers for display values
  * @param Number digit to displays
  *  p_tab values in array in ASCII   
  * @retval None
  */ 
void DecrementLedStatus(void)
{
	if (LedStatus>0)
	{
		LedStatus--;
		UpdateLedStatus();
	}
}

/**
  * @brief converts a number into char
  * @caller several callers for display values
  * @param Number digit to displays
  *  p_tab values in array in ASCII   
  * @retval None
  */ 
void UpdateLedStatus(void)
{
	
	switch (LedStatus)
	{
		case 0:
			WRITE_STM8AF_LD4_GREEN_LED(0);
			WRITE_STM8AF_LD5_GREEN_LED(0);
			WRITE_STM8AF_LD6_GREEN_LED(0);
			WRITE_STM8AF_LD7_GREEN_LED(0);
			break;
			
		case 1:
			WRITE_STM8AF_LD4_GREEN_LED(1);
			WRITE_STM8AF_LD5_GREEN_LED(0);
			WRITE_STM8AF_LD6_GREEN_LED(0);
			WRITE_STM8AF_LD7_GREEN_LED(0);
			break;
		
		case 2:
			WRITE_STM8AF_LD4_GREEN_LED(1);
			WRITE_STM8AF_LD5_GREEN_LED(1);
			WRITE_STM8AF_LD6_GREEN_LED(0);
			WRITE_STM8AF_LD7_GREEN_LED(0);
			break;
			
		case 3:
			WRITE_STM8AF_LD4_GREEN_LED(1);
			WRITE_STM8AF_LD5_GREEN_LED(1);
			WRITE_STM8AF_LD6_GREEN_LED(1);
			WRITE_STM8AF_LD7_GREEN_LED(0);
			break;		

		case 4:
			WRITE_STM8AF_LD4_GREEN_LED(1);
			WRITE_STM8AF_LD5_GREEN_LED(1);
			WRITE_STM8AF_LD6_GREEN_LED(1);
			WRITE_STM8AF_LD7_GREEN_LED(1);
			break;			
			
		default:
			WRITE_STM8AF_LD4_GREEN_LED(0);
			WRITE_STM8AF_LD5_GREEN_LED(0);
			WRITE_STM8AF_LD6_GREEN_LED(0);
			WRITE_STM8AF_LD7_GREEN_LED(0);
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
	AppliTimebaseTick=1;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void ClearAppliTimebaseTick(void)
{
	AppliTimebaseTick=0;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
uint8_t TestAppliTimebaseTick(void)
{
	if (AppliTimebaseTick) return 1;
	else return 0;
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
	case 3: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;		
		break;

	case 1:
	case 4:
		LD3_RED_LED_ON;
		LD4_GREEN_LED_OFF;
		break;

	case 2:
	case 5:
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_ON;
		break;
	
	default: 
		LD3_RED_LED_OFF;
		LD4_GREEN_LED_OFF;
		break;
   }
}


  
  /************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/