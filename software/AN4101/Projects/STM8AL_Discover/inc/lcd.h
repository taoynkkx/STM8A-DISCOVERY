/**
  ******************************************************************************
  * @file    stm8l_discovery_lcd.h
  * @author  MCD Application Team
  * @version VX.Y.ZRCx
  * @date    DD-Month-YYYY
  * @brief   This file contains all the functions prototypes for the glass LCD
  *          firmware driver.
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
#ifndef __LCD_H
#define __LCD_H

/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"
   
/* Define for scrolling sentences*/
#define SCROLL_SPEED_H 	20
#define SCROLL_SPEED  	40
#define SCROLL_SPEED_L  80
#define SCROLL_NUM    	1

/* Define for character '.' */
#define  POINT_OFF FALSE
#define  POINT_ON TRUE

/* Define for caracter ":" */
#define  COLUMN_OFF FALSE
#define  COLUMN_ON TRUE

#define DOT 0x8000 /* for add decimal point in string */
#define DOUBLE_DOT 0x4000 /* for add decimal point in string */

/* Macros used for set/reset bar LCD bar */
#define BAR0_ON  t_bar[0] |= 0x80
#define BAR0_OFF t_bar[0] &= ~0x80
#define BAR1_ON  t_bar[1] |= 0x08
#define BAR1_OFF t_bar[1] &= ~0x08
#define BAR2_ON  t_bar[0] |= 0x20
#define BAR2_OFF t_bar[0] &= ~0x20
#define BAR3_ON t_bar[1] |= 0x02
#define BAR3_OFF t_bar[1] &= ~0x02

/* code for 'µ' character */
#define C_UMAP 0x6081

/* code for 'm' character */
#define C_mMap 0xb210

/* code for 'n' character */
#define C_nMap 0x2210

/* constant code for '*' character */
#define star 0xA0D7

/* constant code for '-' character */
#define C_minus 0xA000

void LCD_bar(void);
void LCD_GLASS_Init(void);
void LCD_GLASS_WriteChar(uint8_t* ch, bool point, bool column,uint8_t position);
void LCD_GLASS_DisplayString(uint8_t* ptr);
void LCD_GLASS_DisplayStrDeci(uint16_t* ptr);
void LCD_GLASS_ClearChar(uint8_t position);
void LCD_GLASS_Clear(void);
void LCD_GLASS_ScrollSentence(uint8_t* ptr, uint16_t nScroll, uint16_t ScrollSpeed);
void LCD_GLASS_WriteTime(char a, uint8_t posi, bool column);


#endif /* __LCD_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
