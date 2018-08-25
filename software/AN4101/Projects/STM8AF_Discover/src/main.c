/**
  ******************************************************************************
  * @file    main.c
  * @author  MCD Application Team
  * @version VX.Y.ZRCx
  * @date    DD-Month-YYYY
  * @brief   <Add here what does this driver do>
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT YYYY STMicroelectronics</center></h2>
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
#include "main.h"
#include "stm8s.h"
#include "L99PM62drv.h"

/* External variables --------------------------------------------------------*/
extern bool TransmissionEnable;
extern bool CANMaster;
extern bool LINSlave;
extern bool StartupCompleted;

/* External functions --------------------------------------------------------*/
/* lin.c */
extern void LIN_Task (void);
extern void LIN_MasterConfig(void);
extern void LIN_SlaveConfig(void);
extern void InitScheduleTable(void);
/* appli.c */
extern void Appli(void);
/* can.c */
extern void CAN_Task(void);
extern void CAN_Config(void);
/* adc.c */
extern void ADC_Config(void);

/* Private typedef -----------------------------------------------------------*/
  
/* Private defines -----------------------------------------------------------*/
#define TIM4_PERIOD 124
#define L99PM62WdgTriggerRefreshValue10 10

/* Private macros ------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/

static __IO uint32_t TimingDelay = 0;
static uint32_t WdgTrigger = 0;
static uint32_t WdgTriggerReload = 0;

bool ReceptionEnable=FALSE;

/* Private function prototypes -----------------------------------------------*/
static void TIM4_Config(void);
static void Delay(u32 nTime);
void TimingDelay_Decrement(void);
static void L99PM62drv_WdgAutoTrigger(u32 WdgAutoTriggerValue);
static void CLK_Config(void);
static void GPIO_Config(void);

/* Private functions ---------------------------------------------------------*/
/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */  

void main(void)
{
  
  L99PM62drv_RegType reg;
	 
  /* GPIO Configuration ---------------------------------------*/
  GPIO_Config();  
  
  /* ADC configuration -------------------------------------------*/
    ADC_Config();    
	
  /* User Button 1 + trimmer turned clockwised: enter CAN test mode */
  if ((GPIOE->IDR & GPIO_PIN_2) == 0x0)
  {
	TransmissionEnable=TRUE;
	CANMaster=TRUE;
  }	
  
  /* User Button 2 : enter LIN slave test mode */
  else if ((GPIOE->IDR & GPIO_PIN_1) == 0x0)
  {
	LINSlave=TRUE;
  }
	
  /* Clock configuration --------------------------------------*/
  CLK_Config();
    
  // SPI Init (enable communication with L99PM62)
  SPI_DeInit();
  SPI_Init(SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_64, SPI_MODE_MASTER, SPI_CLOCKPOLARITY_LOW,
           SPI_CLOCKPHASE_1EDGE, SPI_DATADIRECTION_2LINES_FULLDUPLEX, SPI_NSS_SOFT,(uint8_t)0x07);
	
  /* ADC configuration -------------------------------------------*/
  ADC_Config();    
  ADC2_ITConfig(ENABLE);
  
  /* TIM4 configuration -----------------------------------------*/
  TIM4_Config();  
    
  /* Enable SPI */
  SPI_Cmd(ENABLE); 
	
  /* Enable TIM4 */
  TIM4_Cmd(ENABLE);
    
  /* LIN configuration ----------------------------------------*/

  /* LIN slave test mode */
  if (LINSlave==TRUE)
  {
	LIN_SlaveConfig();
  }
  /* LIN master mode (demo and test mode */
  else
  {
	LIN_MasterConfig();
	InitScheduleTable();
  }

  /* CAN configuration ----------------------------------------*/	
  CAN_Config();
	
  /* Enable Interrupts*/
  enableInterrupts();
  
  // Set 40ms delay before starting communication during L99PM62 long open window
  Delay(40);
  /* Initialization of L99PM62 CAN/LIN transceiver */ 
  L99PM62drv_Init();
  // Set Auto Trigger by TIM4 timer tRefresh=10ms
  L99PM62drv_WdgAutoTrigger(L99PM62WdgTriggerRefreshValue10);

  /* Infinite loop*/
  while(1)
  {
		Appli();
		
		if (StartupCompleted==TRUE) /* To allow leds display at startup */
		{		
			/* CAN test mode */
			if ((CANMaster==TRUE)||(ReceptionEnable==TRUE)) CAN_Task();		
			/* LIN demo or test mode */
			else if (ReceptionEnable==FALSE) LIN_Task();
		}
  }
  
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void CLK_Config(void)
{
	ErrorStatus status = ERROR;
	
	/* Initialization of the clock */
	/* Clock divider to HSI/1 */
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  
	/* Enable HSE to run on XTAL... */ 
	/* ...except in LIN slave test mode if LINUART automatic resynchro is enabled */	
	if (LINSlave==TRUE)
	{
		#ifndef AUTOMATIC_RESYNCHRO
		status = CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
		#endif
	}
	else
	{
		status = CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
	}
}


/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void GPIO_Config(void)
{

	#ifdef DEBUG
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_ALL, GPIO_MODE_OUT_PP_LOW_FAST);
	#endif
	
	/* CAN */
	GPIO_Init(GPIOG, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOG, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);	
		
	/* Init SPI peripheral pins */
	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)(GPIO_PIN_5|GPIO_PIN_6), GPIO_MODE_OUT_PP_LOW_FAST); /* MOSI + CLK */
	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT); /* MISO */
	GPIO_Init(GPIOE, (GPIO_Pin_TypeDef)(GPIO_PIN_5), GPIO_MODE_OUT_PP_HIGH_FAST); /* CSN */
	
	/* Initialize LEDs I/Os in Output Mode */
	GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOE, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	
	/* USER1 button init: GPIO set in input interrupt active mode */
	GPIO_Init( GPIOE, GPIO_PIN_2, GPIO_MODE_IN_FL_IT);

	/* USER2 button init: GPIO set in input interrupt active mode */
	GPIO_Init( GPIOE, GPIO_PIN_1, GPIO_MODE_IN_FL_IT);
	    
	//User Button 1 & 2
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOE, EXTI_SENSITIVITY_FALL_ONLY);    	
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
static void TIM4_Config(void)
{
  /* TIM4 configuration:
   - TIM4CLK is set to 16 MHz, the TIM4 Prescaler is equal to 128 so the TIM1 counter
   clock used is 16 MHz / 128 = 125 000 Hz
  - With 125 000 Hz we can generate time base:
      max time base is 2.048 ms if TIM4_PERIOD = 255 --> (255 + 1) / 125000 = 2.048 ms
      min time base is 0.016 ms if TIM4_PERIOD = 1   --> (  1 + 1) / 125000 = 0.016 ms
  - In this example we need to generate a time base equal to 1 ms
   so TIM4_PERIOD = (0.001 * 125000 - 1) = 124 */

  /* Time base configuration */
  TIM4_TimeBaseInit(TIM4_PRESCALER_128, TIM4_PERIOD);
  /* Clear TIM4 update flag */
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  /* Enable update interrupt */
  TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void L99PM62drv_WdgAutoTrigger( u32 WdgAutoTriggerValue){
	
	WdgTrigger = WdgAutoTriggerValue;
	WdgTriggerReload = WdgAutoTriggerValue;
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void WdgAutoDecrement(void)
{
	  if(WdgTriggerReload != 0x00)
		{
			WdgTrigger--;
			if(WdgTrigger == 0x00)
			{
				L99PM62drv_WdgTrigger();
				WdgTrigger = WdgTriggerReload;
				/* Try to reset L99PM62 errors flags every WD refresh sequence */
				L99PM62drv_ClearStatusRegisters();
			}
		}
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void TimingDelay_Decrement(void)
{
  if (TimingDelay != 0x00)
  {
    TimingDelay--;
  }
}

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void Delay(u32 nTime)
{
  TimingDelay = nTime;

  while (TimingDelay != 0);
}



#ifdef USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
