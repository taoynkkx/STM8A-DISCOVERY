/**
  ******************************************************************************
  * @file    icc_measure.h
  * @author  MCD Application Team
  * @version VX.Y.ZRCx
  * @date    DD-Month-YYYY
  * @brief   define for current measurement
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
#ifndef __ICC_MEASURE_H
#define __ICC_MEASURE_H

/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"
#include "stm8l15x_adc.h"

/* Private define ------------------------------------------------------------*/
#define MCU_RUN		0
#define MCU_LPR		1
#define MCU_HALT	3
#define MCU_LPR_LCD	4

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
u16 ADC_Supply(void);
void ADC_Icc_Init(void);
u16 ADC_Icc_Test(u8 Mcu_State);
void GPIO_LowPower_Config(void);
void delay_ms(u16 n_ms);
void delay_10us(u16 n_10us);

#endif /* __ICC_MEASURE_H*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
