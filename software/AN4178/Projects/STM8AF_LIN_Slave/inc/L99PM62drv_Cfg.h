/**
  ******************************************************************************
  * @file    L99PM62drv_Cfg.h
  * @author  Automotive Business Unit Europe / MCD Application Team
  * @version V1.0.0
  * @date    12-Sept-2012
  * @brief   STM8AF demo / Configuration file for L99PM62 driver
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

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
