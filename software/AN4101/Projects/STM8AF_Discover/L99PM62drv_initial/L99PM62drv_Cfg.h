/******************************************************************************/
/*! Project Name:   L9952 driver
    @file           L9952drv_Cfg.h
    @version        $Revision: 1.1.2.2 $
    @date           $Date: 2009/05/28 14:38:12 $
    @author         Vaclav Dvorak
    @brief          SW driver for ST L9952 device - Configuration file

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
*******************************************************************************/

#ifndef L99PM62DRV_CFG_H
#define L99PM62DRV_CFG_H

/* 
  File version information
*/
#define L99PM62DRV_CFG_H_MAJOR_VERSION  2
#define L99PM62DRV_CFG_H_MINOR_VERSION  0
#define L99PM62DRV_CFG_H_PATCH_VERSION  0


/*******************************************************************************
******************* macros for generating debugging messages *******************
*******************************************************************************/

/*! @def L9952DRV_DEV_ERROR_DETECT
    Preprocessor switch L9952DRV_DEV_ERROR_DETECT allows input parameters
    detection. When the switch is defined, L9952 driver functions checks their
    input parameters and in case any error detection L9952_ErrorDet function is
    called. Otherwise no input parameter check is performed. */

#define L99PM62DRV_DEV_ERROR_DETECT


/*! @def L9952DRV_DEV_ERROR_DETECT_EXEC_CONTINUE
    Preprocessor switch to define permission to continue in execution of
    function which was interrupted by calling of L9952drv_ReportError().
    (It means interrupted function was called with wrong paramater.)
    When the switch is defined, interrupted function will continue after return 
    from L9952drv_ReportError() anyway like in run mode without defined 
    L9952DRV_DEV_ERROR_DETECT.
    When the switch is NOT defined, interrupted function will be terminated
    by return after return from L9952drv_ReportError() to avoid any 
    communication with L9952 device itself via SPI. */
 
/*
#define L99PM62DRV_DEV_ERROR_DETECT_EXEC_CONTINUE 
*/

#endif
