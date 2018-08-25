    /**
  ******************************************************************************
  * @file    discover_board.h
  * @author  MCD Application Team
  * @version VX.Y.ZRCx
  * @date    DD-Month-YYYY
  * @brief   Input/Output defines
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

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef __DISCOVER_BOARD_H
#define __DISCOVER_BOARD_H


/* MACROs for SET, RESET or TOGGLE Output port */

#define GPIO_HIGH(a,b) 		a->ODR|=b
#define GPIO_LOW(a,b)		a->ODR&=~b
#define GPIO_TOGGLE(a,b) 	a->ODR^=b

#define BUTTON1_GPIO_PORT	GPIOE
#define USER1_GPIO_PIN		GPIO_Pin_1

#define BUTTON2_GPIO_PORT	GPIOE
#define USER2_GPIO_PIN		GPIO_Pin_2

#define LED_RED_PORT	GPIOE
#define LED_RED_PIN		GPIO_Pin_7
  
#define LED_GREEN_PORT		GPIOC
#define LED_GREEN_PIN    GPIO_Pin_7

#define CTN_GPIO_PORT           GPIOC
#define CTN_CNTEN_GPIO_PIN      GPIO_Pin_4
#define WAKEUP_GPIO_PORT        GPIOE
#define ICC_WAKEUP_GPIO_PIN     GPIO_Pin_6
#define ICC_WAKEUP_EXTI_PIN     EXTI_Pin_3

#endif /* __DISCOVER_BOARD_H */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
