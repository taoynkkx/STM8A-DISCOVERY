/**
  ******************************************************************************
  * @file    appli.c
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    12-Sept-2012
  * @brief   STM8AF demo / Application functions
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
extern bool ErrorState;

/* External functions --------------------------------------------------------*/
/* lin.c */
extern uint8_t LIN_ReadData(uint8_t, uint8_t);
extern void LIN_WriteData(uint8_t, uint8_t, uint8_t);

/* Private typedef -----------------------------------------------------------*/

/* Private defines -----------------------------------------------------------*/

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

/* if another STM8AF board is the LIN slave */

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

#define WRITE_STM8AL_BAR0(a) LIN_WriteData(0,0,a)
#define WRITE_STM8AL_BAR1(a) LIN_WriteData(0,1,a)
#define WRITE_STM8AL_BAR2(a) LIN_WriteData(0,2,a)
#define WRITE_STM8AL_BAR3(a) LIN_WriteData(0,3,a)

/* Private macros ------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/

static uint8_t Data0 = 0;
static uint8_t Data1 = 0;
static uint8_t BarStatus = 0;
static bool AppliTimebaseTick = FALSE;

bool UserButton1;
bool UserButton2;
uint8_t StartupDisplay = 0;
bool StartupCompleted = FALSE;

/* Private function prototypes -----------------------------------------------*/

static bool UserButton1Status(void);
static bool UserButton2Status(void);
static void IncrementStatus(void);
static void DecrementStatus(void);
static void UpdateBarStatus(void);
static void ClearAppliTimebaseTick(void);
static bool TestAppliTimebaseTick(void);
static void LED_Display(uint8_t Ledstatus);

void SetAppliTimebaseTick(void);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief This function reads/writes CAN/LIN signals, read buttons/trimmer
  * and updates LEDs status
  * @caller main
  * @param None
  * @retval None
  */
void Appli(void)
{

  if (TestAppliTimebaseTick())
  {
    ClearAppliTimebaseTick();

    SET_DEBUG_PIN_3;

    if (StartupDisplay < 23)
    {
      StartupDisplay++;

      /* LIN master demo  */
      LED_Display(StartupDisplay >> 2);
    }
    else
    {
      StartupCompleted = TRUE;

			/* LIN Master demo */
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
			if (!ErrorState)
			{
				/* Read LIN signals and update green LEDs state */
				if (READ_MASTER_LD4_GREEN_LED) LD4_GREEN_LED_ON;
				else LD4_GREEN_LED_OFF;
				if (READ_MASTER_LD5_GREEN_LED) LD5_GREEN_LED_ON;
				else LD5_GREEN_LED_OFF;
				if (READ_MASTER_LD6_GREEN_LED) LD6_GREEN_LED_ON;
				else LD6_GREEN_LED_OFF;
				if (READ_MASTER_LD7_GREEN_LED) LD7_GREEN_LED_ON;
				else LD7_GREEN_LED_OFF;

			}
    }

    CLEAR_DEBUG_PIN_3;
  }
}

/**
  * @brief  returns User1 button status
  * @param  None
  * @retval bool User1 button status
  */
bool UserButton1Status(void)
{

  if (UserButton1 == TRUE)
  {
    UserButton1 = FALSE;
    return(TRUE);
  }
  else
  {
    return(FALSE);
  }
}

/**
  * @brief  returns User2 button status
  * @param  None
  * @retval bool User2 button status
  */
bool UserButton2Status(void)
{

  if (UserButton2 == TRUE)
  {
    UserButton2 = FALSE;
    return(TRUE);
  }
  else
  {
    return(FALSE);
  }
}


/**
  * @brief  increment LEDs status
  * @param  None
  * @retval None
  */
void IncrementStatus(void)
{
  if (BarStatus < 4)
  {
    BarStatus++;
		UpdateBarStatus(); /* LIN Master demo  */
  }
}

/**
  * @brief  decrement LEDs status
  * @param  None
  * @retval None
  */
void DecrementStatus(void)
{
  if (BarStatus > 0)
  {
    BarStatus--;
    UpdateBarStatus(); /* LIN Master demo */
  }
}


/**
  * @brief  update LCD bars status
  * @param  None
  * @retval None
  */
void UpdateBarStatus(void)
{

  /* LIN Master demo */
 
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

/**
  * @brief set appli timebase tick
  * @param  None
  * @retval None
  */
void SetAppliTimebaseTick(void)
{
  AppliTimebaseTick = TRUE;
}

/**
  * @brief clear appli timebase tick
  * @param  None
  * @retval None
  */
void ClearAppliTimebaseTick(void)
{
  AppliTimebaseTick = FALSE;
}

/**
  * @brief test appli timebase tick
  * @param  None
  * @retval None
  */
bool TestAppliTimebaseTick(void)
{
  if (AppliTimebaseTick) return TRUE;
  else return FALSE;
}

/**
  * @brief update LEDs according to LEDs status
  * @param  Ledstatus status to be displayed with LEDs
  * @retval None
  */
void LED_Display(uint8_t Ledstatus)
{
  switch ((uint8_t)Ledstatus)
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