	/**
  ******************************************************************************
  * @file    CAN_Networking\main.h
  * @brief   This file contains the external declaration of main.c file.
  * @author  MCD Application Team
  * @version V2.0.0
  * @date    25-February-2011
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H__
#define __MAIN_H__

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Private variables ---------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

#define LINUART /* for STM8AF UART3 only!*/
#define AUTOMATIC_RESYNCHRO /* for STM8AF UART3 only!*/
#define MUTE_MODE /* for STM8AF UART3 only!*/

#undef DEBUG /* define this constant to enable usage of PB0, PB1, PB2, PB3, PB4 for debug */

#ifdef DEBUG
#define SET_DEBUG_PIN_0 GPIO_WriteHigh(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0);
#define CLEAR_DEBUG_PIN_0 GPIO_WriteLow(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0);
#define SET_DEBUG_PIN_1 GPIO_WriteHigh(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1);
#define CLEAR_DEBUG_PIN_1 GPIO_WriteLow(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1)
#define SET_DEBUG_PIN_2 GPIO_WriteHigh(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_2);
#define CLEAR_DEBUG_PIN_2 GPIO_WriteLow(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_2)
#define SET_DEBUG_PIN_3 GPIO_WriteHigh(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_3);
#define CLEAR_DEBUG_PIN_3 GPIO_WriteLow(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_3)
#define SET_DEBUG_PIN_4 GPIO_WriteHigh(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_4);
#define CLEAR_DEBUG_PIN_4 GPIO_WriteLow(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_4)
#else
#define SET_DEBUG_PIN_0
#define CLEAR_DEBUG_PIN_0
#define SET_DEBUG_PIN_1
#define CLEAR_DEBUG_PIN_1
#define SET_DEBUG_PIN_2
#define CLEAR_DEBUG_PIN_2
#define SET_DEBUG_PIN_3
#define CLEAR_DEBUG_PIN_3
#define SET_DEBUG_PIN_4
#define CLEAR_DEBUG_PIN_4
#endif

/* Public function prototypes -----------------------------------------------*/


#endif /* __MAIN_H__ */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/	