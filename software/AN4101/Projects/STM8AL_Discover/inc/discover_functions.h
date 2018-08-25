/**
  ******************************************************************************
  * @file    discover_functions.h
  * @author  MCD Application Team
  * @version VX.Y.ZRCx
  * @date    DD-Month-YYYY
  * @brief   This file contains constant for measurement
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
#ifndef __DISCOVER_FUNCTIONS_H
#define __DISCOVER_FUNCTIONS_H

/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"

#define STR_VERSION     tab[0] = 'V';tab[1] = '1'|DOT; tab[2] = '2'|DOT; tab[3] = '4'

/* Theorically BandGAP 1.224volt */
#define VREF 		1.224L


/* UNCOMMENT the line below for use the VREFINT_Factory_CONV value*/ 
/* else we use the typical value defined in the datasheet (see Vdd_appli function in the file discover_functions.c) */
// #define VREFINT_FACTORY_CONV 1

/*
	ADC Converter 
	LSBIdeal = VREF/4096 or VDA/4096
*/
#define ADC_CONV 	4096

/*
 VDD Factory for VREFINT measurement 
*/
#define VDD_FACTORY 3.0L

/* The VREFINT_Factory_CONV byte represents the LSB of the VREFINT 12-bit ADC conversion result. The MSB have a fixed value: 0x6 */

#define VREFINT_Factory_CONV_ADDRESS ((uint8_t*)0x4910)

/* 
	* The Typical value is 1.224 
	* Min value 1.202
	* Max value	1.242
	* The value VREF is 0x668 to 0x69f 
	*
*/
#define VREFINT_Factory_CONV_MSB 0x600 /* Le value MSB always 0x600 */
#define VREFINT_Factory_CONV_MIN 0x60 /* Low byte min */
#define VREFINT_Factory_CONV_MAX 0xA0 /* Low byte max */

#define MAX_CURRENT 	9999

/* AUTO TEST VALUE */

#define VCC_MIN 	3215 /* nominal Vcc/Vdd is 3.30V, allow 2.5% lower - Vref can be ~2% lower than 1.225 */
#define VCC_MAX 	3385
#define ICC_RUN_MIN 	900
#define ICC_RUN_MAX 	1600 /* typical ICC_RUN is ~1.4mA, allow ~15% bigger */
#define ICC_HALT_MIN 	300
#define ICC_HALT_MAX 	800 /* typical ICC_HALT is 0.35uA, allow 800 nA instead 1000  this low value is for select the best circuits*/
#define ICC_LP_MIN 	2500
#define ICC_LP_MAX 	4060 /* typical ICC_LP is ~2.9uA, allow ~40% bigger */
#define LSE_DELAY 	2000

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
int _fctcpy(char name);
void convert_into_char(uint16_t number, uint16_t *p_tab);
void LPR_init(void);
void Halt_Init(void);
uint16_t Vref_measure(void);
void Icc_measure(void);
float Icc_measure_RUN(void);
float Icc_measure_HALT(void);
float Icc_measure_LPR(void);
void Icc_measure_LPR_LCD(void);	
void auto_test(void);
void Bias_measurement(void);
void test_vdd(void);
void test_icc_Run(void);
void test_icc_LP(void);
void test_icc_HALT(void);
void display_MuAmp (uint16_t);
void FLASH_ProgramBias(uint8_t) ;
float Vdd_appli(void);
	
#endif /* __DISCOVER_FUNCTIONS_H*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
