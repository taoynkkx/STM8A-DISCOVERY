/**
  ******************************************************************************
  * @file    main.h
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    12-Sept-2012
  * @brief   STM8AF demo / Header for main.c module
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H__
#define __MAIN_H__

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Private variables ---------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

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

/******************* (C) COPYRIGHT STMicroelectronics *****END OF FILE****/