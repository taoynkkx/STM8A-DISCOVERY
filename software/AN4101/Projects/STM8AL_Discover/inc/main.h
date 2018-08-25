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
#include "stm8l15x.h"

/* Private variables ---------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

#undef DEBUG /* define this constant to enable usage of PC0, PC1, PC5, PC6 for debug */

#ifdef DEBUG
#define SET_DEBUG_PIN_0 GPIO_SetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_0);
#define CLEAR_DEBUG_PIN_0 GPIO_ResetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_0);
#define SET_DEBUG_PIN_1 GPIO_SetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_1);
#define CLEAR_DEBUG_PIN_1 GPIO_ResetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_1)
#define SET_DEBUG_PIN_2 GPIO_SetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_5);
#define CLEAR_DEBUG_PIN_2 GPIO_ResetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_5)
#define SET_DEBUG_PIN_3 GPIO_SetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_6);
#define CLEAR_DEBUG_PIN_3 GPIO_ResetBits(GPIOC, (GPIO_Pin_TypeDef)GPIO_Pin_6)
#else
#define SET_DEBUG_PIN_0
#define CLEAR_DEBUG_PIN_0
#define SET_DEBUG_PIN_1
#define CLEAR_DEBUG_PIN_1
#define SET_DEBUG_PIN_2
#define CLEAR_DEBUG_PIN_2
#define SET_DEBUG_PIN_3
#define CLEAR_DEBUG_PIN_3
#endif

/* Public function prototypes -----------------------------------------------*/

#endif /* __MAIN_H__ */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/	