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
#include "stm8l15x.h"
#include "L99PM62drv.h"
#include "lcd.h"
#include "stm8al-discovery.h"
#include "icc_measure.h"
#include "discover_functions.h"
#include "lowpower.h"

/* External variables --------------------------------------------------------*/
/* LCD bar graph: used for display active function */
extern uint8_t t_bar[2];
extern bool StartupCompleted;

/* External functions --------------------------------------------------------*/
/* lin.c */
extern void LIN_Task (void);
extern void LIN_SlaveConfig(void);
extern void InitScheduleTable(void);
/* from appli.c */
extern void Appli(void);
/* lowpower.c */
extern void LowPower(void);

/* Private typedef -----------------------------------------------------------*/
  
/* Private defines -----------------------------------------------------------*/
#define TIM4_PERIOD 124
#define L99PM62WdgTriggerRefreshValue10 10

/* Private macros ------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/
static __IO uint32_t TimingDelay = 0;
static uint32_t WdgTrigger = 0;
static uint32_t WdgTriggerReload = 0;

/* Private function prototypes -----------------------------------------------*/
static void TIM4_Config(void);
void TimingDelay_Decrement(void);
static void L99PM62drv_WdgAutoTrigger(u32 WdgAutoTriggerValue);
static void CLK_Config(void);
static void GPIO_Config(void);
static void Delay(u32 nTime);
static void GPIO_ResetState(void);

/* Private functions ---------------------------------------------------------*/
/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */  

void main(void)
{
  /* Private variables */
  L99PM62drv_RegType reg;
	
	/* Initializes the LCD glass */
  LCD_GLASS_Init();
  
	  /* GPIO Configuration ---------------------------------------*/
  GPIO_Config();
	
	/* Check if Bias measurement invoked */
  while ((GPIOE->IDR & USER2_GPIO_PIN) == 0x0)
  {
	GPIO_SetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_7);
	/* USER2 key pressed, launching Bias Current Measurement */
    Record_Bias_measurement();
	/* waiting until user cuts Discovery board power supply */
	while (1);
  }	
	
  /* Check if test manufacturing invoked */
  while ((GPIOE->IDR & USER1_GPIO_PIN) == 0x0)
  {
	GPIO_SetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_7);
	/* USER1 key pressed, launching Test Mode manufacturing */
	LowPower();
	GPIO_ResetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_7);
	disableInterrupts();
	/* Reconfiguring GPIOs as in the reset state */
	GPIO_ResetState();
	GPIO_Config();		
  }	
		
  /* Clock configuration --------------------------------------*/
  CLK_Config();
  
  /* SPI Init (enable communication with L99PM62) */
  SPI_DeInit(SPI1);
  SPI_Init(SPI1, SPI_FirstBit_MSB, SPI_BaudRatePrescaler_64, SPI_Mode_Master, SPI_CPOL_Low,
           SPI_CPHA_1Edge, SPI_Direction_2Lines_FullDuplex, SPI_NSS_Soft,(uint8_t)0x07);
   
  /* Init Bar on LCD all are OFF --> first function VDD displays */
  BAR0_OFF;
  BAR1_OFF;
  BAR2_OFF;
  BAR3_OFF;	
  /* Refresh LCD  bar */
  LCD_bar();
    
  /* TIM4 configuration -----------------------------------------*/
  TIM4_Config();  
    
  /* Enable SPI */
  SPI_Cmd(SPI1, ENABLE); 
	
  /* Enable TIM4 */
  TIM4_Cmd(ENABLE);
  
  /* USART Enable */
  USART_Cmd(USART1, ENABLE);
    
  /* LIN configuration ----------------------------------------*/
  LIN_SlaveConfig();
	
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
		LIN_Task();
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
  /* High speed internal clock prescaler: 1 */
  CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_1);

  /* Select HSE as system clock source */
  CLK_SYSCLKSourceSwitchCmd(ENABLE);
  CLK_SYSCLKSourceConfig(CLK_SYSCLKSource_HSE);
  while (CLK_GetSYSCLKSource() != CLK_SYSCLKSource_HSE)
  {}

  /* Enable TIM4 CLK */
  CLK_PeripheralClockConfig(CLK_Peripheral_TIM4, ENABLE);
    /* Enable SPI clock */
  CLK_PeripheralClockConfig(CLK_Peripheral_SPI1, ENABLE);
    /* Enable USART clock */
  CLK_PeripheralClockConfig(CLK_Peripheral_USART1, ENABLE);
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
	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)(GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_5|GPIO_Pin_6), GPIO_Mode_Out_PP_Low_Fast);
	#endif
	
	/* Init SPI peripheral pins */
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)(GPIO_Pin_5|GPIO_Pin_6), GPIO_Mode_Out_PP_Low_Fast); /* MOSI + CLK */
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef) GPIO_Pin_7, GPIO_Mode_In_PU_No_IT); /* MISO */
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)(GPIO_Pin_4), GPIO_Mode_Out_PP_High_Fast); /* CSN */
	
	/* Init USART1vpins */
	GPIO_ExternalPullUpConfig(GPIOC, (GPIO_Pin_TypeDef) GPIO_Pin_3, ENABLE); /* TX */
	GPIO_ExternalPullUpConfig(GPIOC, (GPIO_Pin_TypeDef) GPIO_Pin_2, ENABLE); /* RX */
	
	/* Green led init: GPIO set in output */
	GPIO_Init( LED_RED_PORT, LED_RED_PIN, GPIO_Mode_Out_PP_Low_Fast);
	
	/* Blue led init: GPIO set in output */
	GPIO_Init( LED_GREEN_PORT, LED_GREEN_PIN, GPIO_Mode_Out_PP_Low_Fast);
	
	/* USER1 button init: GPIO set in input interrupt active mode */
	GPIO_Init( BUTTON1_GPIO_PORT, USER1_GPIO_PIN, GPIO_Mode_In_FL_IT);

	/* USER2 button init: GPIO set in input interrupt active mode */
	GPIO_Init( BUTTON2_GPIO_PORT, USER2_GPIO_PIN, GPIO_Mode_In_FL_IT);
		
	EXTI_DeInit();

	EXTI_SetPinSensitivity(EXTI_Pin_1, EXTI_Trigger_Falling);
	EXTI_SetPinSensitivity(EXTI_Pin_2, EXTI_Trigger_Falling);
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
  TIM4_TimeBaseInit(TIM4_Prescaler_128, TIM4_PERIOD);
  /* Clear TIM4 update flag */
  TIM4_ClearFlag(TIM4_FLAG_Update);
  /* Enable update interrupt */
  TIM4_ITConfig(TIM4_IT_Update, ENABLE);
  
}

void L99PM62drv_WdgAutoTrigger( u32 WdgAutoTriggerValue)
{
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

/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */
void GPIO_ResetState(void)
{
	GPIO_DeInit(GPIOA);
	GPIO_DeInit(GPIOB);
	GPIO_DeInit(GPIOC);
	GPIO_DeInit(GPIOD);
	GPIO_DeInit(GPIOE);
	GPIO_DeInit(GPIOF);
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
