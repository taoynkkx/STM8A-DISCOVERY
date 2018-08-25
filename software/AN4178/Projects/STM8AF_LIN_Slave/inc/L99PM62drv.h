/**
  ******************************************************************************
  * @file    L99PM62drv.h
  * @author  Automotive Business Unit Europe / MCD Application Team
  * @version V1.0.0
  * @date    12-Sept-2012
  * @brief   STM8AF demo / Header for L99PM62drv.c module
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

#ifndef L99PM62DRV_H
#define L99PM62DRV_H

/*
  File version information
*/
#define L99PM62DRV_H_MAJOR_VERSION  2
#define L99PM62DRV_H_MINOR_VERSION  0
#define L99PM62DRV_H_PATCH_VERSION  0

/* Error codes sent back from Global status register */
#define L99PM62_NoError 0x20
#define L99PM62_CommError 0xC0
#define L99PM62_VsOverVUnderV 0xA2
#define L99PM62_VsOverVUnderVFS 0xA3
#define L99PM62_WD_SPI_Error 0xA1
#define L99PM62_TSD1 0xA8
#define L99PM62_TSD2 0xB9

#include "L99PM62drv_Cfg.h"
#include "stm8s.h"


#if L99PM62DRV_H_MAJOR_VERSION != L99PM62DRV_CFG_H_MAJOR_VERSION
#error "Wrong version of L99PM62drv_cfg.H"
#endif

/*******************************************************************************
*****************************   Function listing   *****************************
********************************************************************************
bool L99PM62drv_ReportError (u8 ServiceId, u8 ErrorId);
void L99PM62drv_Init (void);
void L99PM62drv_WdgTrigger (void);
void L99PM62drv_SetStandbyMode (L99PM62drv_StandbyModeType mode);
void L99PM62drv_SetOut1Mode (L99PM62drv_Out1ModeType mode);
void L99PM62drv_SetOut2Mode (L99PM62drv_Out2ModeType mode) ;
void L99PM62drv_SetOut3Mode (L99PM62drv_Out3ModeType mode);
void L99PM62drv_SetOut4Mode (L99PM62drv_Out4ModeType mode);
void L99PM62drv_SetOutHSMode (L99PM62drv_OutHSModeType mode);
void L99PM62drv_SetOutHSAutorecovery (L99PM62drv_EnableType autorecoveryMode) ;
void L99PM62drv_SetRelayOutput (L99PM62drv_RelayOutputType value) ;
void L99PM62drv_SetVoltageReg2Mode (L99PM62drv_VoltageReg2ModeType mode);
void L99PM62drv_SetTimer1 (L99PM62drv_Timer1PeriodType period, L99PM62drv_Timer1ONTimeType ontime) ;
void L99PM62drv_SetTimer2 (L99PM62drv_Timer2PeriodType period,L99PM62drv_Timer2ONTimeType ontime) ;
void L99PM62drv_SetWUInputMode (u8 mask, L99PM62drv_WUInputModeType mode) ;
void L99PM62drv_EnableWakeupSource (u8 mask, u8 bitpattern) ;
void L99PM62drv_SetResetThresholdLevel (L99PM62drv_ResetThresholdLevelType level);
void L99PM62drv_SetInputFilterMode (u8 mask, L99PM62drv_InputFilterModeType mode);
void L99PM62drv_LinSetup (L99PM62drv_EnableType pullUpMode, L99PM62drv_EnableType TxDToutMode);
void L99PM62drv_SetVsLockoutMode (L99PM62drv_EnableType VsLockoutMode) ;
void L99PM62drv_SetRelayShutdownMode (L99PM62drv_EnableType relayShutdownMode) ;
void L99PM62drv_SetVReg1CurrentMonitorMode (L99PM62drv_EnableType IcmpMode);
void L99PM62drv_SetPWMFrequ (L99PM62drv_PWMFrequType value );
void L99PM62drv_SetPWMDutyCycle (u8 mask, u8 dutyCycle);
void L99PM62drv_SetWDTiming (L99PM62drv_WDTimingType value );
void L99PM62drv_SetCyclicWakeUp (L99PM62drv_EnableType cyclicWakeMode, L99PM62drv_CyclicWakeUpTimerType timer);
void L99PM62drv_EnableBusWakeUp (L99PM62drv_EnableType LINWakeUp, L99PM62drv_EnableType CANWakeUp) ;
u8 L99PM62drv_GetGlobalStatusRegister (void);
void L99PM62drv_ReadStatus (L99PM62drv_RegType *DataPtr,  L99PM62drv_RegIDType regID ) ;
void L99PM62drv_ReadClearStatus (L99PM62drv_RegType *DataPtr,  L99PM62drv_RegIDType regID );
void L99PM62drv_ReadControl (L99PM62drv_RegType *DataPtr,  L99PM62drv_RegIDType regID );
void L99PM62drv_ClearStatusRegisters (void) ;
void L99PM62drv_SetCanStandbyMode (L99PM62drv_EnableType CanSleep);

*******************************************************************************/


/*******************************************************************************
******************* macros for generating debugging messages *******************
*******************************************************************************/

/*******************************************************************************
************************** Public Constants and Variables **********************
*******************************************************************************/

/*! @def ST-SPI Command byte - operation modes
  logical OR with address of register stored in
  L99PM62drv_RegIDType*/
#define L99PM62DRV_ST_SPI_READ   0x40U
#define L99PM62DRV_ST_SPI_WRITE   0x00U
#define L99PM62DRV_ST_SPI_READ_CLEAR 0x80U


/*! @def L99PM62DRV_MASK_WU1
    Defines mask for wakeup input WU1 of L99PM62. */
/*! @def L99PM62DRV_MASK_WU2
    Defines mask for wakeup input WU2 of L99PM62. */
/*! @def L99PM62DRV_MASK_WU3
    Defines mask for wakeup input WU3 of L99PM62. */
#define L99PM62DRV_MASK_WU1   0x01U
#define L99PM62DRV_MASK_WU2   0x02U
#define L99PM62DRV_MASK_WU3   0x04U

/*! @def L99PM62DRV_MASK_PWM1
    Defines mask for PWM1 chanel of L99PM62. */
/*! @def L99PM62DRV_MASK_PWM2
    Defines mask for PWM2 chanel of L99PM62. */
/*! @def L99PM62DRV_MASK_PWM3
    Defines mask for PWM3 chanel of L99PM62. */
/*! @def L99PM62DRV_MASK_PWM4
    Defines mask for PWM4 chanel of L99PM62. */
#define L99PM62DRV_MASK_PWM1   0x01U
#define L99PM62DRV_MASK_PWM2   0x02U
#define L99PM62DRV_MASK_PWM3   0x04U
#define L99PM62DRV_MASK_PWM4   0x08U


#ifdef L99PM62DRV_DEV_ERROR_DETECT
/*******************************************************************************
******************** Service ID constants for all functions ********************
*******************************************************************************/
/*! @def SID_L99PM62drv_Init
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_WdgTrigger
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetStandbyMode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetOut1Mode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetOut2Mode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetOut3Mode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetOut4Mode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetOutHSMode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetOutHSAutorecovery
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetRelayOutput
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetVoltageReg2Mode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetTimer1
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetTimer2
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetWUInputMode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_EnableWakeupSource
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetResetThresholdLevel
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetInputFilterMode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_LinSetup
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetVsLockoutMode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetRelayShutdownMode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SedVReg1CurrentMonitorMode
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetPWMFrequ
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetPWMDutyCycle
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetWDTiming
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_SetCyclicWakeUp
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_EnableBusWakeUp
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_GetGlobalStatusRegister
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_ReadStatus
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_ReadClearStatus
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_ReadControl
    Defines Service ID of relevant function for Error detectiong purpose.*/
/*! @def SID_L99PM62drv_ClearStatusRegisters
    Defines Service ID of relevant function for Error detectiong purpose.*/

#define SID_L99PM62drv_Init 0U
#define SID_L99PM62drv_WdgTrigger 1U
#define SID_L99PM62drv_SetStandbyMode 2U
#define SID_L99PM62drv_SetOut1Mode 3U
#define SID_L99PM62drv_SetOut2Mode 4U
#define SID_L99PM62drv_SetOut3Mode 5U
#define SID_L99PM62drv_SetOut4Mode 6U
#define SID_L99PM62drv_SetOutHSMode 7U
#define SID_L99PM62drv_SetOutHSAutorecovery 8U
#define SID_L99PM62drv_SetRelayOutput 9U
#define SID_L99PM62drv_SetVoltageReg2Mode 10U
#define SID_L99PM62drv_SetTimer1 11U
#define SID_L99PM62drv_SetTimer2 12U
#define SID_L99PM62drv_SetWUInputMode 13U
#define SID_L99PM62drv_EnableWakeupSource 14U
#define SID_L99PM62drv_SetResetThresholdLevel 15U
#define SID_L99PM62drv_SetInputFilterMode 16U
#define SID_L99PM62drv_LinSetup 17U
#define SID_L99PM62drv_SetVsLockoutMode 18U
#define SID_L99PM62drv_SetRelayShutdownMode 19U
#define SID_L99PM62drv_SetVReg1CurrentMonitorMode 20U
#define SID_L99PM62drv_SetPWMFrequ 21U
#define SID_L99PM62drv_SetPWMDutyCycle 22U
#define SID_L99PM62drv_SetWDTiming 23U
#define SID_L99PM62drv_SetCyclicWakeUp 24U
#define SID_L99PM62drv_EnableBusWakeUp 25U
#define SID_L99PM62drv_GetGlobalStatusRegister 26U
#define SID_L99PM62drv_ReadStatus 27U
#define SID_L99PM62drv_ReadClearStatus 28U
#define SID_L99PM62drv_ReadControl 29U
#define SID_L99PM62drv_ClearStatusRegisters 30U
#define SID_L99PM62drv_GetControl 31U
#define SID_L99PM62drv_SetCanStandbyMode 32U
/** out of driver, for debug purpose only **/
#define SID_L99PM62drv_WriteControl 64U



/*******************************************************************************
****************** Error ID constants common for all functions *****************
*******************************************************************************/
/*! @def L99PM62DRV_EID_OK
    Defines Error ID for Error detectiong purpose - OK no error */
/*! @def L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE
    Defines Error ID for Error detectiong purpose - Wrong parameter 1 */
/*! @def L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE
    Defines Error ID for Error detectiong purpose - Wrong parameter 2 */
/*! @def L99PM62DRV_EID_UNINIT
    Defines Error ID for Error detectiong purpose - Driver not initialized */

#define L99PM62DRV_EID_OK 00U
#define L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE 11U
#define L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE 12U
#define L99PM62DRV_EID_UNINIT 20U

#endif
/*******************************************************************************
***************************** New type definition ******************************
*******************************************************************************/


/*! Defines Stand by modes of L99PM62. */
typedef enum {
  L99PM62DRV_STANDBYMODE_V1,    /*!< Switch L99PM62 to V1 stand by mode. */
  L99PM62DRV_STANDBYMODE_VBAT   /*!< Switch L99PM62 to Vbat stand by mode. */
}L99PM62drv_StandbyModeType;


/*! Defines output mode of HS output OUT1. */
typedef enum {
  L99PM62DRV_OUT1_MODE_PWM1,     /*!< Driver is controlled by the PWM1 signal.*/
  L99PM62DRV_OUT1_MODE_TIMER1   /*!< Driver is cyclic ON with the timing of
                                      Timer1 in active mode and stand by modes.*/
} L99PM62drv_Out1ModeType;


/*! Defines output mode of HS output OUT2. */
typedef enum {
  L99PM62DRV_OUT2_MODE_PWM2,     /*!< Driver is controlled by the PWM2 signal.*/
  L99PM62DRV_OUT2_MODE_TIMER2   /*!< Driver is cyclic ON with the timing of
                                      Timer2 in active mode and stand by modes.*/
} L99PM62drv_Out2ModeType;

/*! Defines output mode of HS output OUT3. */
typedef enum {
  L99PM62DRV_OUT3_MODE_FSO,     /*!< output is used as a Fail Safe output.*/
  L99PM62DRV_OUT3_MODE_PWM3    /*!< Driver is controlled by the PWM1 input.*/
} L99PM62drv_Out3ModeType;


/*! Defines output mode of HS output OUT4. */
typedef enum {
  L99PM62DRV_OUT4_MODE_OFF,      /*!< Driver is OFF in all modes.*/
  L99PM62DRV_OUT4_MODE_ON,       /*!< Driver is ON in active mode, OFF in standby mode.*/
  L99PM62DRV_OUT4_MODE_PWM4,      /*!< Driver is controlled by the PWM4 signal.*/
  L99PM62DRV_OUT4_MODE_TIMER2   /*!< Driver is cyclic ON with the timing of Timer2 in active mode and stand by modes.*/
} L99PM62drv_Out4ModeType;

/*! Defines output mode of HS output OUT_HS. */
typedef enum {
  L99PM62DRV_OUTHS_MODE_OFF,      /*!< Driver is OFF in all modes.*/
  L99PM62DRV_OUTHS_MODE_TIMER1,   /*!< Driver is cyclic ON with the timing of
                                      Timer1 in active mode and stand by modes.*/
  L99PM62DRV_OUTHS_MODE_PWM4,     /*!< Driver is controlled by the PWM4 signal.*/
  L99PM62DRV_OUTHS_MODE_TIMER2,   /*!< Driver is cyclic ON with the timing of
                                      Timer2 in active mode and stand by modes.*/
  L99PM62DRV_OUTHS_MODE_PWM3,     /*!< Driver is controlled by the PWM3 signal.*/
  L99PM62DRV_OUTHS_MODE_ON      /*!< Driver is ON in all modes.*/
} L99PM62drv_OutHSModeType;


/*! Defines states for relay outputs controlling.*/
typedef enum {
  RELAYOUTPUT_OFF_OFF,    /*!< Switch both relays off.*/
  RELAYOUTPUT_ON_OFF,     /*!< Switch relay REL1 on and REL2 off.*/
  RELAYOUTPUT_OFF_ON,     /*!< Switch relay REL1 off and REL2 on.*/
  RELAYOUTPUT_ON_ON,      /*!< Switch both relays on.*/
  RELAYOUTPUT_OFF_X,      /*!< Switch relay REL1 off and refresh previous
                                  state of REL2 (don’t change).*/
  RELAYOUTPUT_ON_X,       /*!< Switch relay REL1 on and refresh previous
                                  stateof REL2 (don’t change).*/
  RELAYOUTPUT_X_OFF,      /*!< Switch relay REL2 off and refresh previous
                                  state of REL1 (don’t change).*/
  RELAYOUTPUT_X_ON        /*!< Switch relay REL2 on and refresh previous
                                  state of REL1 (don’t change).*/
} L99PM62drv_RelayOutputType;


/*! Defines modes of L99PM62 voltage regulator 2.*/
typedef enum {
  L99PM62DRV_VOLTAGE_REG2_OFF,          /*!< Switch voltage regulator 2 always
                                              off.*/
  L99PM62DRV_VOLTAGE_REG2_ON_ACTIVE,    /*!< Switch voltage regulator 2 on only
                                              when L99PM62 is in active mode.*/
  L99PM62DRV_VOLTAGE_REG2_ON_V1,        /*!< Switch voltage regulator 2 on only
                                              when L99PM62 is in active mode or V1
                                              standby mode.*/
  L99PM62DRV_VOLTAGE_REG2_ON            /*!< Switch voltage regulator 2 always
                                              on.*/
} L99PM62drv_VoltageReg2ModeType;


/*! Defines period of L99PM62 timer 1.*/
typedef enum {
  L99PM62DRV_TIMER1PERIOD_1,     /*!< Set timer 1 period to 1s.*/
  L99PM62DRV_TIMER1PERIOD_2,     /*!< Set timer 1 period to 2s.*/
  L99PM62DRV_TIMER1PERIOD_3,     /*!< Set timer 1 period to 3s.*/
  L99PM62DRV_TIMER1PERIOD_4      /*!< Set timer 1 period to 4s.*/
} L99PM62drv_Timer1PeriodType;


/*! Defines ON Time parameter of L99PM62 timer 1.*/
typedef enum {
  L99PM62DRV_TIMER1ONTIME_10,       /*!< Defines ON time value 10ms.*/
  L99PM62DRV_TIMER1ONTIME_20        /*!< Defines ON time value 20ms.*/
} L99PM62drv_Timer1ONTimeType;


/*! Defines period of L99PM62 timer 2.*/
typedef enum {
  L99PM62DRV_TIMER2PERIOD_10,     /*!< Set timer 2 period to 10ms.*/
  L99PM62DRV_TIMER2PERIOD_20,     /*!< Set timer 2 period to 20ms.*/
  L99PM62DRV_TIMER2PERIOD_50,     /*!< Set timer 2 period to 50ms.*/
  L99PM62DRV_TIMER2PERIOD_200      /*!< Set timer 2 period to 200ms.*/
} L99PM62drv_Timer2PeriodType;

/*! Defines ON Time parameter value for timer 2 of L99PM62.*/
typedef enum {
  L99PM62DRV_TIMER2ONTIME_01,       /*!< Defines ON time value 100us.*/
  L99PM62DRV_TIMER2ONTIME_1         /*!< Defines ON time value 1ms.*/
} L99PM62drv_Timer2ONTimeType;


/*! Defines pull up/down mode for WU related inputs.*/
typedef enum {
  L99PM62DRV_WU_INPUT_MODE_CUR_SINK,     /*!< Defines current sink(pull down) mode for related
                                              WU input.*/
  L99PM62DRV_WU_INPUT_MODE_CUR_SOURCE    /*!< Defines current source (pull up) mode for related
                                              WU input.*/
} L99PM62drv_WUInputModeType;


/*! Defines input filter configuration for related WU inputs.*/
typedef enum {
  L99PM62DRV_IN_FILTER_64,         /*!< Defines input filter time value
                                             to 64us unsynchronized.*/
  L99PM62DRV_IN_FILTER_80_TIMER2,  /*!< Defines input filter time value
                                              to 80us synchronized with timer 2.*/
  L99PM62DRV_IN_FILTER_800_TIMER2, /*!< Defines input filter time value
                                             to 800us synchronized with timer 2.*/
  L99PM62DRV_IN_FILTER_800_TIMER1  /*!< Defines input filter time value
                                             to 800us synchronized with timer 1.*/
} L99PM62drv_InputFilterModeType;


/*! Defines reset threshold level value.*/
typedef enum {
  L99PM62DRV_RESET_THRESHOLD_4600,    /*!< Defines reset threshold level
                                                  4,6V.*/
  L99PM62DRV_RESET_THRESHOLD_4350,    /*!< Defines reset threshold level
                                                  4,35V.*/
  L99PM62DRV_RESET_THRESHOLD_4100,    /*!< Defines reset threshold level
                                                  4,1V.*/
  L99PM62DRV_RESET_THRESHOLD_3800       /*!< Defines reset threshold level
                                                  3.8V.*/
} L99PM62drv_ResetThresholdLevelType;


/*!    */
typedef enum {
  L99PM62DRV_DISABLE,     /*!<   */
  L99PM62DRV_ENABLE       /*!<   */
} L99PM62drv_EnableType;



/*! L99PM62drv_StatusRegType defines global data type for access to complete local
copy of L99PM62 Status registers 0 and 1. Access to internal structure and
particular bit variables of each status register is provided by set of mask
related to each bit variable inside the status register.*/
typedef u16 L99PM62drv_RegType;


/*! .*/
typedef enum {
  L99PM62DRV_CR1 = 1,    /*!<    */
  L99PM62DRV_CR2 = 2,    /*!<    */
  L99PM62DRV_CR3 = 3,    /*!<    */
  L99PM62DRV_CR4 = 4,    /*!<    */
  L99PM62DRV_CR5 = 5,    /*!<    */
  L99PM62DRV_CR6 = 6,    /*!<    */
  L99PM62DRV_SR1 = 0x11,    /*!<    */
  L99PM62DRV_SR2 = 0x12,    /*!<    */
  L99PM62DRV_SR3 = 0x13,    /*!<    */
  L99PM62DRV_CFR = 0x3F
} L99PM62drv_RegIDType;


/*! Defines of PWM frequency values.*/
typedef enum {
  L99PM62DRV_PWMFREQU_100HZ,    /*!< PWM frequency of all pwm channels set to 100Hz  */
  L99PM62DRV_PWMFREQU_200HZ    /*!< PWM frequency of all pwm channels set to 200Hz   */
} L99PM62drv_PWMFrequType;


/*! Defines timer used for cyclic wakeup.*/
typedef enum {
  L99PM62DRV_CYCLIC_WAKEUP_TIMER2,     /*!<  */
  L99PM62DRV_CYCLIC_WAKEUP_TIMER1    /*!< */
} L99PM62drv_CyclicWakeUpTimerType;


/*! Defines timer used for cyclic wakeup.*/
typedef enum {
  L99PM62DRV_WDC_TRIG_10,    /*!< */
  L99PM62DRV_WDC_TRIG_50,    /*!< */
  L99PM62DRV_WDC_TRIG_100,   /*!< */
  L99PM62DRV_WDC_TRIG_200   /*!< */
}L99PM62drv_WDTimingType;


/*******************************************************************************
********************************** Functions ***********************************
*******************************************************************************/


/******************************************************************************/
/*! @fn         bool L99PM62drv_ReportError (u8 ServiceId, u8 ErrorId)
    @param[in]  ServiceId defines ID of failing function (service)
    @param[in]  ErrorId defines ID of Error
    @return         TRUE  .. to continue in interrupted function anyway
                            like in run mode without L99PM62DRV_DEV_ERROR_DETECT,
                    FALSE .. to stop execution of interrupted function by return
                             and to avoid any communication with L99PM62 device
    @brief
Service for reporting of errors especially during development phase.
This function is originally implemented as dummy function. It allows the user to
implement his required functionality for instance error logging, settings of
some user global error variables for detailed error localization etc.
*/
/******************************************************************************/

bool L99PM62drv_ReportError (u8 ServiceId, u8 ErrorId);

/******************************************************************************/
/*! @fn         void L99PM62drv_Init (void)
    @brief
This module shall initialize the whole L99PM62 driver (internal data structure
etc). It does not care about L99PM62 SPI adaptation layer nor SPI interface nor
L99PM62 device itself. The SPI needs to be initialized earlier.
Caveats: L99PM62drv can control just one L99PM62 device.
This service should not be called during a running operation.
*/
/******************************************************************************/

void L99PM62drv_Init (void);


/******************************************************************************/
/*! @fn             void L99PM62drv_WdgTrigger (void)
    @brief
Function triggers the watchdog hardware. It has to be called cyclically by upper
layer function (usually the watchdog manager) in order to prevent the watchdog
hardware from expiring. Right timing is essential. For more detail see L99PM62
datasheet. Affected register: CR1.0
Note: Function writes internal copy of Control Register 1 to L99PM62 device via SPI.
Function protects the user from taking care about special conditions related to
WD handling after wake up from stand by modes.
*/
/******************************************************************************/

void L99PM62drv_WdgTrigger (void);


/******************************************************************************/
/*! @fn         void L99PM62drv_SetStandbyMode(L99PM62drv_StandbyModeType mode)
    @param[in]  mode    defines type of stand by mode to be set
    @brief
This function sets selected Stand by mode of the L99PM62 device.
Affected register: CR0.20..21, CR2.20 (by L99PM62drv_SetVReg1CurrentMonitorOn)
Note: Function L99PM62drv_SetVReg1CurrentMonitorOn() is called before Control
Register 0 is modified to go to Stand by mode. Reason is security. Function
updates SW driver internal copy of Control Register 0 and the register is
immediately sent to L99PM62 via SPI. Function refreshes SW driver internal copy
of Status0 register from L99PM62 via SPI.
Caveats: It is necessary to decrease power consumption from L99PM62 V1 voltage
regulator after set Stand by mode V1. Most often it means to set immediately
Halt mode of the MCU. It is necessary to take care also about Watchdog
triggering. The best time for the function calling is just after the calling of
L99PM62drv_WdgTrigger(); function in its regular watch dog time window. Function
waits until both Control registers are transferred completely to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetStandbyMode (L99PM62drv_StandbyModeType mode);

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut1Mode (L99PM62PM62drv_Out1ModeType mode)
  @param[in] mode defines  mode for HS output 1
    @brief
Function controls HS output1 of L99PM62. Affected register: CR1.8
Note: Function updates SW driver internal copy of Control Register 1 and the
register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetOut1Mode (L99PM62drv_Out1ModeType mode);

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut2Mode (L99PM62PM62drv_Out2ModeType mode)
  @param[in] mode defines  mode for HS output 2
    @brief
Function controls HS output2 of L99PM62. Affected register: CR1.9
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOut2Mode (L99PM62drv_Out2ModeType mode) ;

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut3Mode (L99PM62PM62drv_Out3ModeType mode)
  @param[in] mode defines  mode for HS output 3
    @brief
Function controls HS output3 of L99PM62. Affected register: CR1.10
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOut3Mode (L99PM62drv_Out3ModeType mode);
/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut4Mode (L99PM62PM62drv_Out4ModeType mode)
  @param[in] mode defines  mode for HS output 4
    @brief
Function controls HS output4 of L99PM62. Affected register: CR1.12..13
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOut4Mode (L99PM62drv_Out4ModeType mode);

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOutHSMode (L99PM62PM62drv_OutHSModeType mode)
  @param[in] mode defines  mode for HS output HS
    @brief
Function controls HS outputHS of L99PM62. Affected register: CR1.14..15
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOutHSMode (L99PM62drv_OutHSModeType mode);


/******************************************************************************/
/*! @fn             void L99PM62drv_SetOutHSAutorecovery (L99PM62drv_EnableType autorecoveryMode)
    @param[in]      autorecoveryMode  sets autorecovery functionality for OUT HS output
    @brief
Function enables/disables autorecovery functionality for OUT HS output of L99PM62.
Affected register: CR4.13
Note: Function updates SW driver internal copy of Control Register 4 and the
register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetOutHSAutorecovery (L99PM62drv_EnableType autorecoveryMode) ;


/******************************************************************************/
/*! @fn             void L99PM62drv_SetRelayOutput (L99PM62drv_RelayOutputType value)
    @param[in]      value describes which relay will be set to which state
                    (or not changed)
    @brief
Function controls LS relay outputs of L99PM62. Affected register: CR1.6..7
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.

*/
/******************************************************************************/
void L99PM62drv_SetRelayOutput (L99PM62drv_RelayOutputType value) ;


/******************************************************************************/
/*! @fn             void L99PM62drv_SetVoltageReg2Mode (L99PM62drv_VoltageReg2ModeType mode)
    @param[in]      mode defines mode of Voltage regulator 2 to be set
    @brief
Function controls Voltage regulator 2 mode of L99PM62. Affected register: CR1.4..5
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetVoltageReg2Mode (L99PM62drv_VoltageReg2ModeType mode);


/******************************************************************************/
/*! @fn             void L99PM62drv_SetTimer1 ( L99PM62drv_Timer1PeriodType period,
                L99PM62drv_Timer1ONTimeType ontime)
    @param[in]      period defines period of L99PM62 Timer 1
    @param[in]      ontime defines the part of period where the L99PM62 Timer 1
                    output is set to 1.
    @brief
Function controls Timer1 of L99PM62. Affected register: CR3.12..14
Note: Function updates SW driver internal copy of Control Register 3
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetTimer1 (L99PM62drv_Timer1PeriodType period, L99PM62drv_Timer1ONTimeType ontime) ;

/******************************************************************************/
/*! @fn             void L99PM62drv_SetTimer2 ( L99PM62drv_Timer2PeriodType period,
                L99PM62drv_Timer2ONTimeType ontime)
    @param[in]      period defines period of L99PM62 Timer 2
    @param[in]      ontime defines the part of period where the L99PM62 Timer 2
                    output is set to 1.
    @brief
Function controls timer2 of L99PM62. Affected register: CR3.8..10
Note: Function updates SW driver internal copy of Control Register 3
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetTimer2 (L99PM62drv_Timer2PeriodType period, L99PM62drv_Timer2ONTimeType ontime) ;

/******************************************************************************/
/*! @fn             void L99PM62drv_SetWUInputMode (u8 mask, L99PM62drv_WUInputModeType mode)
    @param[in]      mask sets WU input mode to be changed.
                    Range: 0x00..0x0F
                        Bit 0:  1 = Mask is active for WU1,
                                0 = Mask is not active for WU1.
                        Bit 1:  1 = Mask is active for WU2,
                                0 = Mask is not active for WU2.
                        Bit 2:  1 = Mask is active for WU3,
                                0 = Mask is not active for WU3.
                    Following constants are defined in L99PM62drv.h file:
                    L99PM62DRV_MASK_WU1, L99PM62DRV_MASK_WU2, L99PM62DRV_MASK_WU3,
                    L99PM62DRV_MASK_WU4.
                    Example: L99PM62DRV_MASK_WU2 | L99PM62DRV_MASK_WU3
                    … mask is active for WU2 and WU3.
    @param[in]      mode describes mode (pull up/pull down) for dig. WU Inputs.
    @brief
Function sets mode (current source / current sink) for digital wake up inputs
WU1, WU2, and WU3 of L99PM62. Affected register: CR2.4..6
Note: Function updates SW driver internal copy of Control Register 2
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetWUInputMode (u8 mask, L99PM62drv_WUInputModeType mode) ;


/******************************************************************************/
/*! @fn             void L99PM62drv_EnableWakeupSource (u8 mask, u8 bitpattern)
   @param[in]      mask sets wakeup source to be changed.
     Range: 0x00..0xFF
     Bit 0: 1 = Mask is active for WU1,0 = Mask is not active for WU1.
     Bit 1: 1 = Mask is active for WU2,0 = Mask is not active for WU2.
     Bit 2: 1 = Mask is active for WU3,0 = Mask is not active for WU3.
     Following constants are defined in L99PM62drv.h file:
     L99PM62DRV_MASK_WU1, L99PM62DRV_MASK_WU2,L99PM62DRV_MASK_WU3
 @param[in]  Disables / enables wakeup functionality separately for each
 wake up source. Particular bits are related to relevant wakeup sources in
 the same order as are defined by masks (see above). Each bit = 1 (default)
 enables related wakeup source and each bit = 0 disables related wakeup source
    @brief
Function enables / disables wakeup functionality separately for each wake up
source defined by mask. Affected register: CR2.0..3
Note: Function updates SW driver internal copy of Control Register 2
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_EnableWakeupSource (u8 mask, u8 bitpattern) ;

/******************************************************************************/
/*! @fn             void L99PM62drv_SetResetThresholdLevel (L99PM62drv_ResetThresholdLevelType level)
    @param[in]      level defines reset threshold level value
    @brief
Function sets reset threshold level of L99PM62. Affected register: CR4.8..9
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetResetThresholdLevel (L99PM62drv_ResetThresholdLevelType level);


/******************************************************************************/
/*! @fn             void L99PM62drv_SetInputFilterMode (u8 mask, L99PM62drv_InputFilterModeType mode)
    @param[in]      mask sets which WU input filter settings will be changed.
                    Range: 0x00 .. 0x0F
                    Bit 0:  1 = Mask is active for WU1,
                            0 = Mask is not active for WU1.
                    Bit 1:  1 = Mask is active for WU2,
                            0 = Mask is not active for WU2.
                    Bit 2:  1 = Mask is active for WU3,
                            0 = Mask is not active for WU3.
                    Following constants are defined in L99PM62drv.h file:
                    L99PM62DRV_MASK_WU1, L99PM62DRV_MASK_WU2, L99PM62DRV_MASK_WU3
                    Example: L99PM62DRV_MASK_WU1 | L99PM62DRV_MASK_WU3 …
                    mask is active for WU1 and WU3.
    @param[in]      mode sets filter timing for related WU inputs.
    @brief
Function controls filter for digital wake up inputs WU1, WU2 and WU3 of L99PM62.
Affected register: CR2.8..13
Note: Function updates SW driver internal copy of Control Register 2
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetInputFilterMode (u8 mask, L99PM62drv_InputFilterModeType mode);


/******************************************************************************/
/*!@fn             void L99PM62drv_LinSetup (L99PM62drv_EnableType pullUpMode,
                L99PM62drv_EnableType TxDToutMode) {
 @param[in]     pullUpMode enables pullup in the LIN bus
 @param[in]   TxDToutMode enables LIN dominant TxD timeout
   @brief
Function sets LIN configuration. Affected register: CR4.5, 4.7
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_LinSetup (L99PM62drv_EnableType pullUpMode, L99PM62drv_EnableType TxDToutMode);

/******************************************************************************/
/*! @fn             void L99PM62drv_SetVsLockoutMode (L99PM62drv_VsLockoutModeType mode)
    @param[in]      mode selects L99PM62 behavior after Vs recovery
    @brief
Function enables automatic recovery of outputs after Vs over/under-voltage recovery
of L99PM62. If VsLockoutMode set to Enable, the outputs remains off after
VS  Over-/Undervoltage recovery until the Vs Over-/Undervoltage Status Bits) are
cleared. Affected register: CR4.12
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetVsLockoutMode (L99PM62drv_EnableType VsLockoutMode) ;


/******************************************************************************/
/*! @fn             void L99PM62drv_SetRelayShutdownMode(L99PM62drv_RelayShutdownModeType mode)
    @param[in]      mode selects L99PM62 behavior of relay output during
                    under/over-voltage
    @brief
Function enables automatic shutdown of relay outputs during Vs over/under-voltage
of L99PM62. i.e. REL1,2 turned Off in case of Vs Over-/Undervoltage.
Affected register: CR4.10
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetRelayShutdownMode (L99PM62drv_EnableType relayShutdownMode) ;


/******************************************************************************/
/*! @fn           void L99PM62drv_SedVReg1CurrentMonitorMode (L99PM62drv_EnableType IcmpMode)
  @param[in]    IcmpMode    enables / disables Voltage regulator 1 current monitoring
    @brief
Function enables / disables Voltage regulator 1 current monitoring mode
of L99PM62 in V1 stand by mode. Affected register: CR4.14
Note: Function updates SW driver internal copy of Control Register 4 and the
register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetVReg1CurrentMonitorMode (L99PM62drv_EnableType IcmpMode);


/******************************************************************************/
/*! @fn             void L99PM62drv_SetPWMFrequ (L99PM62drv_PWMFrequType value )
    @param[in]      value  modified PWM frequency for all PWM channels
    @brief
Function sets PWM frequency for all channels. Affected register: CR5.7
Note: Function updates SW driver internal copy of Control Register 5
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetPWMFrequ (L99PM62drv_PWMFrequType value );

/******************************************************************************/
/*! @fn           void L99PM62drv_SetPWMDutyCycle (u8 mask, u8 dutyCycle)
    @param[in]    Mask: mask sets PWMChannel to be changed.
       Range: 0x00 .. 0x0F
 Bit 0: 1 = Mask is active for PWM1, 0 = Mask is not active for PWM1
 Bit 1: 1 = Mask is active for PWM2, 0 = Mask is not active for PWM2
 Bit 2: 1 = Mask is active for PWM3, 0 = Mask is not active for PWM3
   Bit 3: 1 = Mask is active for PWM4, 0 = Mask is not active for PWM4
 Following constants are defined in L99PM62drv.h file:
  #define L99PM62DRV_MASK_PWM1   0x01
  #define L99PM62DRV_MASK_PWM2   0x02
  #define L99PM62DRV_MASK_PWM3   0x04
      #define L99PM62DRV_MASK_PWM4   0x08
    @param[in]      dutyCycle for selected PWM channel by mask range 0..7F
    @brief
Function sets PWM frequency for all channels
Affected register: CR5.0..6, 8..14, and/or CR6.0..6, 8..14
Note: Function updates SW driver internal copy of Control Register 5 and/or 6
and the register is immediately sent to L99PM62 via SPI. Function sets CR5 in
case of setting PWM 1 or PWM2 duty cycle. In case of PWM3 or PWM4 duty cycle
settings the content  of CR6 is modified. In case of the mask contains any
combination of PWM channels controlled by different registers, both control
register are send via SPI.
caveats:
Function waits until the data are transferred completely to L99PM62 via SPI.
First is transferred CR5 and than CR6 in case two register transfer.
Global status register value in this case is get from CR6 transfer and the C
ommunication error flag reflect directly the CR5 transmission.
*/
/******************************************************************************/

void L99PM62drv_SetPWMDutyCycle (u8 mask, u8 dutyCycle);


/******************************************************************************/
/*! @fn             void L99PM62drv_SetWDTiming (L99PM62drv_WDTimingType value )
    @param[in]      value defines WD Trigger Timing
    @brief
Function sets WD Trigger Timing interval
Affected register: CR3.4..5
Note: Function updates SW driver internal copy of Control Register 3
and the register is immediately sent to L99PM62 via SPI.*/
/******************************************************************************/

void L99PM62drv_SetWDTiming (L99PM62drv_WDTimingType value, L99PM62drv_WDTimingType* oldValue );

/******************************************************************************/
/*! @fn             void L99PM62drv_SetCyclicWakeUp ( L99PM62drv_EnableType cyclicWakeMode,
                L99PM62drv_CyclicWakeUpTimerType Timer)
    @param[in]      cyclicWakeMode enables cyclic wake-up mode by selected timer
        (Timer interrupt mode). If enabled, on the LIN RxD is looped
        the periodical signal by selected timer as well the signal
        in case of wakeup and start of watchdog. If Disabled  only the
        signal in case of wakeup and start of watchdog is looped to LIN RxD.
    @param[in]      Timer selects timer used for cyclic wake-up
    @brief
Function configures cyclic wake up by timer. It Timer interrupt mode enable, the
impulse on LIN RxD pin is generated in case of wake-up from standby, start of
watchdog and periodical impulse by selected timer for uC cyclic wakeup.
Affected register: CR3.0..1
Note: Function updates SW driver internal copy of Control Register 3
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetCyclicWakeUp (L99PM62drv_EnableType cyclicWakeMode, L99PM62drv_CyclicWakeUpTimerType timer);


/******************************************************************************/
/*! @fn             void L99PM62drv_EnableBusWakeUp ( L99PM62drv_EnableType LINWakeUp,
                L99PM62drv_EnableType  CANWakeUp)
    @param[in]      LINWakeUp enables / disables wake up by LIN
    @param[in]      CANWakeUp enables / disables wake up by CAN
    @brief
Function enables / disables wake up by LIN and/or CAN
Affected register: CR3.2..3
Note: Function updates SW driver internal copy of Control Register 3
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_EnableBusWakeUp (L99PM62drv_EnableType LINWakeUp, L99PM62drv_EnableType CANWakeUp) ;


/******************************************************************************/
/*! @fn             void L99PM62drv_SetCanStandbyMode (L99PM62drv_EnableType CanSleep)
    @param[in]      Enables/disables the CAN cell
    @brief
Function enables the CAN peripherial. If CanSleep == false the CAN is swithed to
sleep mode.
Affected register: CR4..4
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetCanStandbyMode (L99PM62drv_EnableType CanSleep);



/******************************************************************************/
/*! @fn             bool L99PM62drv_GetGlobalStatusRegister (void)
    @return         global Status Register value
    @brief
Function gets value of the global status register i.e. first read byte of the SPI frame.
Function don’t send any data via spi, just return last stored global status
register value from internal mirror.
Caveats: Value of the global status register is extracted from data received by
the last SPI  operation, but  some  bits (e.g. communication error) correspond
to previous SPI operation before the SPI communication when this global status
byte was read.out.
*/
/******************************************************************************/

u8 L99PM62drv_GetGlobalStatusRegister (void);

/******************************************************************************/
/*! @fn             void L99PM62drv_ReadStatus (L99PM62drv_RegType *dataPtr, L99PM62drv_RegIDType regID)
    @param[out]     *dataPtr points to variable which will be filled with StatusRegister data
  @param[in]      regID select the status register for this SPI operation
    @brief
Function reads selected status register from L99PM62 via SPI and than files data
structure with received data.
Caveats: Function waits until the data are transferred completely to L99PM62
via SPI.
*/
/******************************************************************************/

void L99PM62drv_ReadStatus (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr   ) ;

/******************************************************************************/
/*! @fn             void L99PM62drv_ReadClearStatus (L99PM62drv_RegType *dataPtr, L99PM62drv_RegIDType regID)
    @param[out]     *dataPtr points to variable which will be filled with StatusRegister data
  @param[in]      regID select the status register for this SPI operation
    @brief
Function reads selected status register from L99PM62 via SPI and than files data
structure with received data. Read register is cleared in the L99PM62 memory at
the end of SPI communication
Caveats: Function waits until the data are transferred completely to L99PM62
via SPI.
*/
/******************************************************************************/

void L99PM62drv_ReadClearStatus (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr);


/******************************************************************************/
/*! @fn             void L99PM62drv_ReadControl (L99PM62drv_RegType *dataPtr, L99PM62drv_RegIDType regID)
    @param[out]     *dataPtr points to variable which will be filled with StatusRegister data
  @param[in]      regID select the status register for this SPI operation
    @brief
Function reads selected control register from L99PM62 via SPI and than files
data structure with received data. This function has no sense to use if driver
should protect user to access directly to control register
Caveats: Function waits until the data are transferred completely to L99PM62
via SPI.
*/
/******************************************************************************/

void L99PM62drv_ReadControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr );


/******************************************************************************/
/*! @fn             void L99PM62drv_GetControl (L99PM62drv_RegType *dataPtr, L99PM62drv_RegIDType regID)
    @param[out]     *dataPtr points to variable which will be filled with StatusRegister data
  @param[in]      regID select the status register for this SPI operation
    @brief
Function returns the las CR value readed bach during CR write operation. This
function don't access directly to silicon vias SPI.
Caveats: returned value is related to last I/O operation with selected Control
register
*/
/******************************************************************************/

void L99PM62drv_GetControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr);



/** out of driver function **/
void L99PM62drv_WriteControl ( L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr);

/******************************************************************************/
/*! @fn             void L99PM62drv_ClearStatusRegisters (void)
    @brief
Function clears content of all status registers and GSR directly in L99PM62.
Function processes Read and Clear command on the Configuration Register
at ST-SPI RAM address 0x3F(for details see ST SPI Spec 3.0)
*/
/******************************************************************************/

void L99PM62drv_ClearStatusRegisters (void) ;

/******************************************************************************/
/*! @fn             bool L99PM62DRV_AL_SPI_WR( u8  commandByte,  u8*  dataIn,
      u8*  globalStatus,  u8*  dataOut)
    @brief
Function sends and receives data from L99PM62. Send and receive 3 bytes.
Manage CSN pin of L99PM62 which is connected to STM8AF PE5 port as a chip select.

*/
/******************************************************************************/
void ST_SPI_Send_16( u8  commandByte,  u8*  dataIn,
                     u8*  globalStatus,  u8*  dataOut);

/******************************************************************************/
/*! @fn             void L99PM62drv_SetCanLoopBackMode (L99PM62drv_EnableType CanLoop)
    @param[in]      Enable CAN cell in Loop Back Mode
    @brief
Function enables the CAN peripheral in Loop Back Mode
Affected register: CR4..4
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetCanLoopBackMode (L99PM62drv_EnableType CanLoop);


/******************************************************************************/
/*! @fn             void L99PM62drv_SetCanPatternWakeUp (L99PM62drv_EnableType CanPattern)
    @param[in]      Enable CAN cell in Loop Back Mode
    @brief
Function enables or disables the CAN peripheral Pattern WakeUp
Affected register: CR4..4
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetCanPatternWakeUp (L99PM62drv_EnableType CanPattern);

#endif

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/