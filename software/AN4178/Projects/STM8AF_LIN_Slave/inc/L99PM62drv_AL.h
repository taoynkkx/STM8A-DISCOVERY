/**
  ******************************************************************************
  * @file    L99PM62drv_AL.h
  * @author  Automotive Business Unit Europe / MCD Application Team
  * @version V1.0.0
  * @date    12-Sept-2012
  * @brief   STM8AF demo / Adaptation layer for L99PM62 driver
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

#ifndef L99PM62DRV_AL_H
#define L99PM62DRV_AL_H

/*
  File version information
*/
#define L99PM62DRV_AL_H_MAJOR_VERSION  2
#define L99PM62DRV_AL_H_MINOR_VERSION  0
#define L99PM62DRV_AL_H_PATCH_VERSION  0


/*
This file is originally dummy. It is prepared for implementation of adaptation
layer for arbitrary user SPI interface.
*/


#include "stm8s.h"
#include "stm8s_spi.h"
/******************************************************************************/
/*! @fn         void SPI_Send (uint8 *DataTX, uint8 *DataRX)
    @param[in]  DataTX  defines pointer to 3 byte data to be transmitted via SPI
    @param[out] DataRX  defines pointer to 3 byte data to be received via SPI
    @brief
Generally the function should be included from some low level SPI driver.
If such direct compatible function does not exist, the function should be
created in L9952drv_AL.c file.
Number of transmitted data via SPI: 3 bytes (24bit).
Data order for transmitting: First is send the first byte, than the second and
than the third one. MSB is always transmitted as the first bit from the byte
via SPI. Data order for received data is the same as for transmitted.
This function is originally implemented as dummy function in L9952drv_AL.c file.
*/
/******************************************************************************/

/*extern bool ST_SPI_Send( uint8  commandByte,  uint8*  dataIn,
      uint8*  globalStatus,  uint8*  dataOut);
*/

/*! @def L9952DRV_AL_SPI_WR
Assigns function which replaces general function name L9952DRV_AL_SPI_WR
to real function which would do SPI transfer to L9952 device itself. Here is
assumed that exists function SPI_Send() to provide this SPI communication.
Generally function SPI_Send() should be included from some low level SPI
driver. If such direct compatible function does not exist, the SPI_Send()
function should be created in L9952drv_AL.c file. */

#define L99PM62DRV_AL_SPI_WR   ST_SPI_Send_16


#endif

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
