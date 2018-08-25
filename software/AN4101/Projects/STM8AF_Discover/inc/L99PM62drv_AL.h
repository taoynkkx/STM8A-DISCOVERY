/******************************************************************************/
/*! Project Name:   L9952 driver
    @file           L9952drv_AL.h
    @version        $Rev: 1431 $
    @date           $Date: 2009/05/28 14:38:12 $
    @author         David Trojek
    @author         Vaclav Dvorak
    @brief          SW driver for ST L9952 device - Adaptation Layer.

    Company:        STMicroelectronics
                    Pobrezni 3
                    186 00 Praha 8, Czech Republic

    Processor:      any (ST7)
    
    Compiler:       any (Cosmic)

    Copyright (c) 2005 STMicroelectronics.

    THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
    EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTY
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK
    AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE
    PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
    REPAIR OR CORRECTION.

*******************************************************************************/

/****************************** Revision History *******************************

    Date        Name            Description
    05.02.2007  David Trojek    Original Issue

*******************************************************************************/

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

/*extern bool ST_SPI_Send(	uint8 	commandByte, 	uint8* 	dataIn, 
						uint8* 	globalStatus, 	uint8* 	dataOut);
*/

/*! @def L9952DRV_AL_SPI_WR
Assigns function which replaces general function name L9952DRV_AL_SPI_WR
to real function which would do SPI transfer to L9952 device itself. Here is
assumed that exists function SPI_Send() to provide this SPI communication. 
Generally function SPI_Send() should be included from some low level SPI
driver. If such direct compatible function does not exist, the SPI_Send()
function should be created in L9952drv_AL.c file. */

#define L99PM62DRV_AL_SPI_WR 		ST_SPI_Send_16


#endif
