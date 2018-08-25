/**
  ******************************************************************************
  * @file    lowpower.c
  * @author  Microcontroller Division
  * @version V1.2.0
  * @date    07/2012
  * @brief   Low power functions
  ******************************************************************************
  * @copy
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2010 STMicroelectronics</center></h2>
  */

/* Includes ------------------------------------------------------------------*/

#include "stm8l15x_clk.h"
#include "lcd.h"
#include "stm8al-discovery.h" 
#include "icc_measure.h"
#include "discover_functions.h"
#include "lcd.h"
#include "lowpower.h"


/* LCD bar graph: used for display active function */
extern uint8_t t_bar[2];
/* Set in interrupt handler for indicate that user button is pressed */ 
/**
  * @brief  Low Power test STM8AL-Discovery
  * @caller auto_test
  * @param  
  * @retval None
  */
void LowPower(void)
{
	LCD_GLASS_ScrollSentence("    ** TEST **",1,SCROLL_SPEED_H);
	/* Counter enable: GPIO set in output for enable the counter */
  GPIO_Init( CTN_GPIO_PORT, CTN_CNTEN_GPIO_PIN, GPIO_Mode_Out_OD_HiZ_Slow);
	/* Wake up counter: for detect end of counter GPIO set in input interupt active mode */
  GPIO_Init( WAKEUP_GPIO_PORT, ICC_WAKEUP_GPIO_PIN, GPIO_Mode_In_FL_IT);
	/* Enable Rising edge port PE6 for wake up conter */
  //EXTI->CR2 = 0x10; 
  EXTI_SetPinSensitivity(EXTI_Pin_6, EXTI_Trigger_Rising);
	//EXTI->CR1 = 0x08;  
	EXTI_SetPinSensitivity(EXTI_Pin_1, EXTI_Trigger_Falling);
/* Enable ADC clock */
  CLK_PeripheralClockConfig(CLK_Peripheral_ADC1, ENABLE);

/* Initializes ADC */
  ADC_Icc_Init();
/* Init the VREF value */
  Vref_measure();
	 
/* Switch off the leds at start */
  GPIO_LOW(LED_RED_PORT,LED_RED_PIN);	
  GPIO_LOW(LED_GREEN_PORT,LED_GREEN_PIN);	
	/* Allow interrruts used in device wakeup sequences */ 
	enableInterrupts();
  
  /* Init Bar on LCD all are OFF --> first function VDD displays */
  BAR0_OFF;
  BAR1_OFF;
  BAR2_OFF;
  BAR3_OFF;
	// Launch Auto test
  auto_test();
	// TIM4 replaced in initial reset state 
  TIM4_DeInit();  
 
}

void Record_Bias_measurement(void)
{
	/* Counter enable: GPIO set in output for enable the counter */
  GPIO_Init( CTN_GPIO_PORT, CTN_CNTEN_GPIO_PIN, GPIO_Mode_Out_OD_HiZ_Slow);
	/* Wake up counter: for detect end of counter GPIO set in input interupt active mode */
  GPIO_Init( WAKEUP_GPIO_PORT, ICC_WAKEUP_GPIO_PIN, GPIO_Mode_In_FL_IT);
	/* Enable Rising edge port PE6 for wake up conter */
  EXTI_SetPinSensitivity(EXTI_Pin_6, EXTI_Trigger_Rising);
	/* Enable ADC clock */
  CLK_PeripheralClockConfig(CLK_Peripheral_ADC1, ENABLE);
	/* Initializes ADC */
  ADC_Icc_Init();
	/* Perform Bias measurement and record value */
	Bias_measurement();
	
}

/******************* (C) COPYRIGHT 2010 STMicroelectronics *****END OF FILE****/
