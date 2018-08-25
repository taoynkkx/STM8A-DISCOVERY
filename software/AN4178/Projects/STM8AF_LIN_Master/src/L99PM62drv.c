/**
  ******************************************************************************
  * @file    L99PM62drv.c
  * @author  Automotive Business Unit Europe / MCD Application Team
  * @version V1.0.0
  * @date    12-Sept-2012
  * @brief   STM8AF demo / L99PM62 driver (from rev 1.1.2.5 dated 2009/05/28)
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

#define L99PM62DRV_C_MAJOR_VERSION  2
#define L99PM62DRV_C_MINOR_VERSION  0
#define L99PM62DRV_C_PATCH_VERSION  0

#define GPIO_TOGGLE(a,b)  a->ODR^=b
#define GPIO_LOW(a,b)  a->ODR&=~b
#define GPIO_HIGH(a,b)   a->ODR|=b

#include "L99PM62drv.h"
#include "L99PM62drv_AL.h"

#if L99PM62DRV_C_MAJOR_VERSION != L99PM62DRV_H_MAJOR_VERSION
#error "Wrong version of L99PM62drv.H"
#endif

#if L99PM62DRV_C_MAJOR_VERSION != L99PM62DRV_AL_H_MAJOR_VERSION
#error "Wrong version of L99PM62drv_AL.h"
#endif

/*******************************************************************************
******************* macros for generating debugging messages *******************
*******************************************************************************/


/*******************************************************************************
************************* Internal Constants and Variables *********************
*******************************************************************************/


/*******************************************************************************
********************************** Variables **********************************
*******************************************************************************/

static u8  CtrlReg1[2], CtrlReg1_old[2], /*!< Internal copy of L99PM62 control registers 1.
         Bit order:  x[1]:15..8, x[0]:7..0 */
CtrlReg2[2], CtrlReg2_old[2], /*!< Internal copy of L99PM62 control registers 2.
         Bit order:  x[1]:15..8, x[0]:7..0 */
CtrlReg3[2], CtrlReg3_old[2], /*!< Internal copy of L99PM62 control registers 3.
         Bit order:  x[1]:15..8, x[0]:7..0 */
CtrlReg4[2], CtrlReg4_old[2], /*!< Internal copy of L99PM62 control registers 4.
         Bit order:  x[1]:15..8, x[0]:7..0 */
CtrlReg5[2], CtrlReg5_old[2], /*!< Internal copy of L99PM62 control registers 5.
         Bit order:  x[1]:15..8, x[0]:7..0 */
CtrlReg6[2], CtrlReg6_old[2], /*!< Internal copy of L99PM62 control registers 6.
         Bit order:  x[1]:15..8, x[0]:7..0 */
StatReg1[2], /*!< Internal copy of L99PM62 status registers 1.
         Bit order:  x[1]:15..8, x[0]:7..0 */
StatReg2[2], /*!< Internal copy of L99PM62 status registers 2.
         Bit order:  x[1]:15..8, x[0]:7..0 */
StatReg3[2], /*!< Internal copy of L99PM62 status registers 3.
         Bit order:  x[1]:15..8, x[0]:7..0 */
ConfigReg[2], ConfigReg_old[2];

static u8   GlobalStatusRegister;


#ifdef  L99PM62DRV_DEV_ERROR_DETECT
static u8    InitFlag = 0U;  /*!< Flag to notice if L99PM62drv_Init() was
                                already called. 0..not called.*/
#endif

uint8_t count = 0;
bool ErrorState;

extern bool StartupCompleted;

/*******************************************************************************
********************************** Functions ***********************************
*******************************************************************************/


#ifdef  L99PM62DRV_DEV_ERROR_DETECT
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

bool L99PM62drv_ReportError (u8 ServiceId, u8 ErrorId)
{
  ServiceId = ServiceId;  /* to avoid error message parameter not used */
  ErrorId   = ErrorId;    /* to avoid error message parameter not used */

#ifdef L99PM62DRV_DEV_ERROR_DETECT_EXEC_CONTINUE
  return TRUE;    /*  to continue in interrupted function anyway */
  /*    like in run mode without L99PM62DRV_DEV_ERROR_DETECT */
#else
  return FALSE;   /*  to stop execution of interrupted function by return; */
  /*    and to avoid any communication with L99PM62 device */
#endif
}

#endif
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

void L99PM62drv_Init (void)
{
  u8 i;

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  InitFlag = 1U;  /* Flag to notice that L99PM62drv_Init()was already called*/
#endif

  for (i = 0U; i < 2U; i++)
  {
    CtrlReg1[i] = 0U;
    CtrlReg2[i] = 0U;
    CtrlReg3[i] = 0U;
    CtrlReg4[i] = 0U;
    CtrlReg5[i] = 0U;
    CtrlReg6[i] = 0U;
    CtrlReg1_old[i] = 0U;
    CtrlReg2_old[i] = 0U;
    CtrlReg3_old[i] = 0U;
    CtrlReg4_old[i] = 0U;
    CtrlReg5[i] = 0U;
    CtrlReg5_old[i] = 0U;
    CtrlReg6[i] = 0U;
    CtrlReg6_old[i] = 0U;
    StatReg1[i] = 0U;
    StatReg2[i] = 0U;
    StatReg3[i] = 0U;
    ConfigReg[i] = 0U;
    ConfigReg_old[i] = 0U;
  }
  CtrlReg2[0] |= 0x03U; /* sets the default power on values*/
  CtrlReg3[0] |= 0x0CU;
  CtrlReg4[1] |= 0x14U;
  CtrlReg4[0] |= 0xF6U;
  CtrlReg5[1] |= 0x7fU;
  CtrlReg6[1] |= 0x7fU;
}


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

void L99PM62drv_WdgTrigger (void)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_WdgTrigger, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  CtrlReg1[0] ^= 0x01U;           /* refresh WD */
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);
}


/******************************************************************************/
/*! @fn         void L99PM62drv_SetStandbyMode(L99PM62drv_StandbyModeType mode)
    @param[in]  mode    defines type of stand by mode to be set
    @brief
This function sets selected Stand by mode of the L99PM62 device.
Affected register: CR0.20..21, CR2.20 (by L99PM62drv_SetVReg1CurrentMonitorOn)
Function updates SW driver internal copy of Control Register 1 and the register is
immediately sent to L99PM62 via SPI.
Caveats: It is necessary to decrease power consumption from L99PM62 V1 voltage
regulator after set Stand by mode V1. Most often it means to set immediately
Halt mode of the MCU. It is necessary to take care also about Watchdog
triggering. The best time for the function calling is just after the calling of
L99PM62drv_WdgTrigger(); function in its regular watch dog time window. Function
waits until both Control registers are transferred completely to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetStandbyMode (L99PM62drv_StandbyModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetStandbyMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  switch (mode)
  {
    case L99PM62DRV_STANDBYMODE_V1:
      CtrlReg1[0] |= 0x06U;
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                            CtrlReg1,
                            &GlobalStatusRegister,
                            CtrlReg1_old);
      CtrlReg1[0] &= (u8)~0x02U;
      break;
    case L99PM62DRV_STANDBYMODE_VBAT:
      CtrlReg1[0] &= ~0x04U;
      CtrlReg1[0] |= 0x02U;
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                            CtrlReg1,
                            &GlobalStatusRegister,
                            CtrlReg1_old);  /* should cause power off */
      CtrlReg1[0] &= (u8)~0x012;            /* line should not be reached */
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetStandbyMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;
  }
}

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut1Mode (L99PM6252drv_Out1ModeType mode)
  @param[in] mode defines  mode for HS output 1
    @brief
Function controls HS output1 of L99PM62. Affected register: CR1.8
Note: Function updates SW driver internal copy of Control Register 1 and the
register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetOut1Mode (L99PM62drv_Out1ModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut1Mode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if ((mode != L99PM62DRV_OUT1_MODE_PWM1) && (mode != L99PM62DRV_OUT1_MODE_TIMER1))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut1Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif
  CtrlReg1[1] &= (u8)~0x01U;
  CtrlReg1[1] |= (u8)mode & 0x01U;
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);
}


/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut2Mode (L99PM6252drv_Out2ModeType mode)
  @param[in] mode defines  mode for HS output 2
    @brief
Function controls HS output2 of L99PM62. Affected register: CR1.9
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOut2Mode (L99PM62drv_Out2ModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut2Mode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }

  if ((mode != L99PM62DRV_OUT2_MODE_PWM2) && (mode != L99PM62DRV_OUT2_MODE_TIMER2))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut2Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif
  CtrlReg1[1] &= (u8)~0x02U;
  CtrlReg1[1] |= ((u8)mode & 0x01U) << 1;
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);
}

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut3Mode (L99PM6252drv_Out3ModeType mode)
  @param[in] mode defines  mode for HS output 3
    @brief
Function controls HS output3 of L99PM62. Affected register: CR1.10
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOut3Mode (L99PM62drv_Out3ModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut3Mode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if ((mode != L99PM62DRV_OUT3_MODE_FSO) && (mode != L99PM62DRV_OUT3_MODE_PWM3))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut3Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif
  CtrlReg1[1] &= (u8)~0x04U;
  CtrlReg1[1] |= ((u8)mode & 0x01U) << 2;
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);
}

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOut4Mode (L99PM6252drv_Out4ModeType mode)
  @param[in] mode defines  mode for HS output 4
    @brief
Function controls HS output4 of L99PM62. Affected register: CR1.12..13
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOut4Mode (L99PM62drv_Out4ModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  s8 tmp;

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut4Mode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  tmp = (s8)mode;
  if ((tmp < (s8)L99PM62DRV_OUT4_MODE_OFF) || (tmp > (s8)L99PM62DRV_OUT4_MODE_TIMER2))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOut4Mode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif
  CtrlReg1[1] &= (u8)~0x30U;
  CtrlReg1[1] |= ((u8)mode & 0x03U) << 4;
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);
}

/******************************************************************************/
/*! @fn        void L99PM62drv_SetOutHSMode (L99PM6252drv_OutHSModeType mode)
  @param[in] mode defines  mode for HS output HS
    @brief
Function controls HS outputHS of L99PM62. Affected register: CR1.14..15,11
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/
void L99PM62drv_SetOutHSMode (L99PM62drv_OutHSModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  s8 tmp;

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  tmp = (s8)mode;
  if ((tmp < (s8)L99PM62DRV_OUTHS_MODE_OFF) || (tmp > (s8)L99PM62DRV_OUTHS_MODE_ON))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSMode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif
  switch (mode)
  {
    case L99PM62DRV_OUTHS_MODE_OFF:
    case L99PM62DRV_OUTHS_MODE_TIMER1:
    case L99PM62DRV_OUTHS_MODE_PWM4:
    case L99PM62DRV_OUTHS_MODE_TIMER2:
      CtrlReg1[1] &= (u8)~0xC8U;
      CtrlReg1[1] |= ((u8)mode & 0x03U) << 6;
      break;
    case L99PM62DRV_OUTHS_MODE_PWM3:
      CtrlReg1[1] &= (u8)~0xC8U;
      CtrlReg1[1] |= 0x08;
      break;
    case L99PM62DRV_OUTHS_MODE_ON:
      CtrlReg1[1] &= (u8)~0xC8U;
      CtrlReg1[1] |= 0x48;
      break;
    default :
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSAutorecovery, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;                 /* parameter value out of range */

  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);
}


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

void L99PM62drv_SetOutHSAutorecovery (L99PM62drv_EnableType autorecoveryMode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSAutorecovery, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  switch (autorecoveryMode)
  {
    case L99PM62DRV_DISABLE:
      CtrlReg4[1] &= (u8)~0x20U;
      break;
    case L99PM62DRV_ENABLE:
      CtrlReg4[1] |= 0x20U;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetOutHSAutorecovery, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;                 /* parameter value out of range */
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);
}


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
/*! @def REL1_ON
For internal purpose of L99PM62drv_SetRelayOutput() only */
/*! @def REL1_OFF
For internal purpose of L99PM62drv_SetRelayOutput() only */
/*! @def REL2_ON
For internal purpose of L99PM62drv_SetRelayOutput() only */
/*! @def REL2_OFF
For internal purpose of L99PM62drv_SetRelayOutput() only */

#define REL1_ON     (CtrlReg1[0] |= 0x40U)
#define REL1_OFF    (CtrlReg1[0] &= (u8)~0x40U)
#define REL2_ON     (CtrlReg1[0] |= 0x80U)
#define REL2_OFF    (CtrlReg1[0] &= (u8)~0x80U)

void L99PM62drv_SetRelayOutput (L99PM62drv_RelayOutputType value)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetRelayOutput, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  switch (value)
  {
    case RELAYOUTPUT_OFF_OFF:   /* Switch both relays off. */
      REL1_OFF;
      REL2_OFF;
      break;
    case RELAYOUTPUT_ON_OFF:    /* Switch relay REL1 on and REL2 off.*/
      REL1_ON;
      REL2_OFF;
      break;
    case RELAYOUTPUT_OFF_ON:    /* Switch relay REL1 off and REL2 on.*/
      REL1_OFF;
      REL2_ON;
      break;
    case RELAYOUTPUT_ON_ON:     /* Switch both relays on.*/
      REL1_ON;
      REL2_ON;
      break;
    case RELAYOUTPUT_OFF_X:     /* Switch relay REL1 off and refresh
                                              previous state of REL2 (don’t change).*/
      REL1_OFF;
      break;
    case RELAYOUTPUT_ON_X:      /* Switch relay REL1 on and refresh
                                              previous stateof REL2 (don’t change).*/
      REL1_ON;
      break;
    case RELAYOUTPUT_X_OFF:     /* Switch relay REL2 off and refresh
                                              previous state of REL1 (don’t change).*/
      REL2_OFF;
      break;
    case RELAYOUTPUT_X_ON:      /* Switch relay REL2 on and refresh
                                              previous state of REL1 (don’t change).*/
      REL2_ON;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetRelayOutput, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;                 /* parameter value out of range */
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);

}


/******************************************************************************/
/*! @fn             void L99PM62drv_SetVoltageReg2Mode (L99PM62drv_VoltageReg2ModeType mode)
    @param[in]      mode defines mode of Voltage regulator 2 to be set
    @brief
Function controls Voltage regulator 2 mode of L99PM62. Affected register: CR1.4..5
Note: Function updates SW driver internal copy of Control Register 1
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetVoltageReg2Mode (L99PM62drv_VoltageReg2ModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  s8 tmp;

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVoltageReg2Mode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  tmp = (s8)mode;
  if ((tmp < (s8)L99PM62DRV_VOLTAGE_REG2_OFF) || (tmp > (s8)L99PM62DRV_VOLTAGE_REG2_ON))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVoltageReg2Mode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif

  CtrlReg1[0] &= (u8)~0x30U;
  CtrlReg1[0] |= (u8)((mode & 0x03) << 4);
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                        CtrlReg1,
                        &GlobalStatusRegister,
                        CtrlReg1_old);
}


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

void L99PM62drv_SetTimer1 (L99PM62drv_Timer1PeriodType period, L99PM62drv_Timer1ONTimeType ontime)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  s8 tmp;

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  tmp = (s8)period;
  if ((tmp < (s8)L99PM62DRV_TIMER1PERIOD_1) || (tmp > (s8)L99PM62DRV_TIMER1PERIOD_4))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  if ((ontime != L99PM62DRV_TIMER1ONTIME_10) && (ontime != L99PM62DRV_TIMER1ONTIME_20))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif

  CtrlReg3[1] &= (u8)~0x70U;
  CtrlReg3[1] |= (u8)((u8)ontime << 6) & 0x40U;
  CtrlReg3[1] |= (u8)((u8)period << 4) & 0x30U;
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
                        CtrlReg3,
                        &GlobalStatusRegister,
                        CtrlReg3_old);
}


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

void L99PM62drv_SetTimer2 (L99PM62drv_Timer2PeriodType period, L99PM62drv_Timer2ONTimeType ontime)
{
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  s8 tmp;

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer2, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  tmp = (s8)period;
  if ((tmp < (s8)L99PM62DRV_TIMER2PERIOD_10) || (tmp > (s8)L99PM62DRV_TIMER2PERIOD_200))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer2, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  if ((ontime != L99PM62DRV_TIMER2ONTIME_01) && (ontime != L99PM62DRV_TIMER2ONTIME_1))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer2, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif
  CtrlReg3[1] &= (u8)~0x07U;
  CtrlReg3[1] |= (u8)((u8)ontime << 2) & 0x04U;
  CtrlReg3[1] |= (u8)((u8)period ) & 0x03U;
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
                        CtrlReg3,
                        &GlobalStatusRegister,
                        CtrlReg3_old);
}



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

void L99PM62drv_SetWUInputMode (u8 mask, L99PM62drv_WUInputModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWUInputMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if (mask & (u8)~0x0FU)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWUInputMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  if ((mode != L99PM62DRV_WU_INPUT_MODE_CUR_SINK) && (mode != L99PM62DRV_WU_INPUT_MODE_CUR_SOURCE))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWUInputMode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif

  if (mask & L99PM62DRV_MASK_WU1)
  {
    if (mode == L99PM62DRV_WU_INPUT_MODE_CUR_SINK)
    {
      CtrlReg2[0] &= (u8)~0x10U;
    }
    else
    {
      CtrlReg2[0] |= 0x10U;
    }
  }
  if (mask & L99PM62DRV_MASK_WU2)
  {
    if (mode == L99PM62DRV_WU_INPUT_MODE_CUR_SINK)
    {
      CtrlReg2[0] &= (u8)~0x20U;
    }
    else
    {
      CtrlReg2[0] |= 0x20U;
    }
  }
  if (mask & L99PM62DRV_MASK_WU3)
  {
    if (mode == L99PM62DRV_WU_INPUT_MODE_CUR_SINK)
    {
      CtrlReg2[0] &= (u8)~0x40U;
    }
    else
    {
      CtrlReg2[0] |= 0x40U;
    }
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
                        CtrlReg2,
                        &GlobalStatusRegister,
                        CtrlReg2_old);
}


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

void L99PM62drv_EnableWakeupSource (u8 mask, u8 bitpattern)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableWakeupSource, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  CtrlReg2[0] &= (u8)~(mask & 0x07U);
  CtrlReg2[0] |= (bitpattern & mask) & 0x07U;
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
                        CtrlReg2,
                        &GlobalStatusRegister,
                        CtrlReg2_old);
}


/******************************************************************************/
/*! @fn             void L99PM62drv_SetResetThresholdLevel (L99PM62drv_ResetThresholdLevelType level)
    @param[in]      level defines reset threshold level value
    @brief
Function sets reset threshold level of L99PM62. Affected register: CR4.8..9
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetResetThresholdLevel (L99PM62drv_ResetThresholdLevelType level)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetResetThresholdLevel, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  switch (level)
  {
    case  L99PM62DRV_RESET_THRESHOLD_3800:
      CtrlReg4[1] |= (u8)0x03U;
      break;
    case  L99PM62DRV_RESET_THRESHOLD_4100:
      CtrlReg4[1] &= (u8)~0x03U;
      CtrlReg4[1] |= 0x02U;
      break;
    case  L99PM62DRV_RESET_THRESHOLD_4350:
      CtrlReg4[1] &= (u8)~0x03U;
      CtrlReg4[1] |= 0x01U;
      break;
    case  L99PM62DRV_RESET_THRESHOLD_4600:
      CtrlReg4[1] &= (u8)~0x03U;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetResetThresholdLevel, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);
}


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

void L99PM62drv_SetInputFilterMode (u8 mask, L99PM62drv_InputFilterModeType mode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  s8 tmp;

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetInputFilterMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if (mask & (u8)~0x0FU)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetInputFilterMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  tmp = (s8)mode;
  if ((tmp < (s8)L99PM62DRV_IN_FILTER_64) || (tmp > (s8)L99PM62DRV_IN_FILTER_800_TIMER1))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetInputFilterMode, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif

  if (mask & L99PM62DRV_MASK_WU1)
  {
    CtrlReg2[1] &= (u8)~0x03U;
    CtrlReg2[1] |= (u8)((u8)mode) & 0x03U;
  }
  if (mask & L99PM62DRV_MASK_WU2)
  {
    CtrlReg2[1] &= (u8)~0x0CU;
    CtrlReg2[1] |= (u8)((u8)mode << 2) & 0x0CU;
  }
  if (mask & L99PM62DRV_MASK_WU3)
  {
    CtrlReg2[1] &= (u8)~0x30U;
    CtrlReg2[1] |= (u8)((u8)mode << 4) & 0x30U;
  }

  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
                        CtrlReg2,
                        &GlobalStatusRegister,
                        CtrlReg2_old);
}



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

void L99PM62drv_LinSetup (L99PM62drv_EnableType pullUpMode, L99PM62drv_EnableType TxDToutMode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_LinSetup, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if (pullUpMode != L99PM62DRV_DISABLE && pullUpMode != L99PM62DRV_ENABLE )
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_LinSetup, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  if (TxDToutMode != L99PM62DRV_DISABLE && TxDToutMode != L99PM62DRV_ENABLE )
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_LinSetup, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif

  if (pullUpMode == L99PM62DRV_DISABLE)
  {
    CtrlReg4[0] &= (u8)~0x80U;
  }
  else if (pullUpMode == L99PM62DRV_ENABLE)
  {
    CtrlReg4[0] |= 0x80U;
  }

  if (TxDToutMode == L99PM62DRV_DISABLE)
  {
    CtrlReg4[0] &= (u8)~0x20U;
  }
  else if (TxDToutMode == L99PM62DRV_ENABLE)
  {
    CtrlReg4[0] |= 0x20U;
  }

  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);
}

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
void L99PM62drv_SetVsLockoutMode (L99PM62drv_EnableType VsLockoutMode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVsLockoutMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  switch (VsLockoutMode)
  {
    case L99PM62DRV_DISABLE:
      CtrlReg4[1] &= (u8)~0x10U;
      break;
    case L99PM62DRV_ENABLE:
      CtrlReg4[1] |= 0x10U;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetVsLockoutMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);
}


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

void L99PM62drv_SetRelayShutdownMode (L99PM62drv_EnableType relayShutdownMode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetRelayShutdownMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (relayShutdownMode)
  {
    case L99PM62DRV_DISABLE:
      CtrlReg4[1] &= (u8)~0x04U;
      break;
    case L99PM62DRV_ENABLE:
      CtrlReg4[1] |= 0x04U;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetRelayShutdownMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);
}


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

void L99PM62drv_SetVReg1CurrentMonitorMode (L99PM62drv_EnableType IcmpMode)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetVReg1CurrentMonitorMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (IcmpMode)
  {
    case L99PM62DRV_ENABLE:
      CtrlReg4[1] &= (u8)~0x40U;
      break;
    case L99PM62DRV_DISABLE:
      CtrlReg4[1] |= 0x40U;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetVReg1CurrentMonitorMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);
}


/******************************************************************************/
/*! @fn             void L99PM62drv_SetPWMFrequ (L99PM62drv_PWMFrequType value )
    @param[in]      value  modified PWM frequency for all PWM channels
    @brief
Function sets PWM frequency for all channels. Affected register: CR5.7
Note: Function updates SW driver internal copy of Control Register 5
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetPWMFrequ (L99PM62drv_PWMFrequType value )
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMFrequ, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  switch (value)
  {
    case L99PM62DRV_PWMFREQU_100HZ:
      CtrlReg5[0] &= (u8)~0x80U;
      break;
    case L99PM62DRV_PWMFREQU_200HZ:
      CtrlReg5[0] |= 0x80U;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetPWMFrequ, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR5,
                        CtrlReg5,
                        &GlobalStatusRegister,
                        CtrlReg5_old);
}


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

void L99PM62drv_SetPWMDutyCycle (u8 mask, u8 dutyCycle)
{
  bool  send5, send6;

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMDutyCycle, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if (mask & (u8)~0x0FU)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMDutyCycle, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  if (dutyCycle & (u8)0x80)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetPWMDutyCycle, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif
  send5 = FALSE;
  send6 = FALSE;
  if (mask & L99PM62DRV_MASK_PWM1)
  {
    CtrlReg5[0] &= 0x80U;
    CtrlReg5[0] |= dutyCycle & 0x7FU;
    send5 = TRUE;
  }
  if (mask & L99PM62DRV_MASK_PWM2)
  {
    CtrlReg5[1] = ((u8)~dutyCycle) & 0x7FU;
    send5 = TRUE;
  }
  if (mask & L99PM62DRV_MASK_PWM3)
  {
    CtrlReg6[0] = dutyCycle & 0x7fU;
    send6 = TRUE;
  }
  if (mask & L99PM62DRV_MASK_PWM4)
  {
    CtrlReg6[1] = ((u8)~dutyCycle) & 0x7FU;
    send6 = TRUE;
  }
  if (send5)
  {
    L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR5,
                          CtrlReg5,
                          &GlobalStatusRegister,
                          CtrlReg5_old);
  }
  if (send6)
  {
    L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR6,
                          CtrlReg6,
                          &GlobalStatusRegister,
                          CtrlReg6_old);
  }
}


/******************************************************************************/
/*! @fn             void L99PM62drv_SetWDTiming (L99PM62drv_WDTimingType value )
    @param[in]      value defines WD Trigger Timing
  @param[in]      oldValue  pointer to olda value of WD Trigger Timing
    @brief
Function sets WD Trigger Timing interval
Affected register: CR3.4..5
Note: Function updates SW driver internal copy of Control Register 3
and the register is immediately sent to L99PM62 via SPI.*/
/******************************************************************************/

void L99PM62drv_SetWDTiming (L99PM62drv_WDTimingType value, L99PM62drv_WDTimingType* oldValue  )
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetWDTiming, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (value)
  {
    case L99PM62DRV_WDC_TRIG_10:
      CtrlReg3[0] &= (u8)~0x30U;
      break;
    case L99PM62DRV_WDC_TRIG_50:
      CtrlReg3[0] &= (u8)~0x20U;
      CtrlReg3[0] |= 0x10U;
      break;
    case L99PM62DRV_WDC_TRIG_100:
      CtrlReg3[0] &= (u8)~0x10U;
      CtrlReg3[0] |= 0x20U;
      break;
    case L99PM62DRV_WDC_TRIG_200:
      CtrlReg3[0] |= 0x30U;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_SetWDTiming, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE);
#endif
      return;
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
                        CtrlReg3,
                        &GlobalStatusRegister,
                        CtrlReg3_old);
  trap();
  switch ((u8)CtrlReg3_old[0] & 0x30U)
  {
    case 0x00U:
      *oldValue = L99PM62DRV_WDC_TRIG_10;
      break;
    case 0x10U:
      *oldValue = L99PM62DRV_WDC_TRIG_50;
      break;
    case 0x20U:
      *oldValue = L99PM62DRV_WDC_TRIG_100;
      break;
    case 0x30U:
      *oldValue = L99PM62DRV_WDC_TRIG_200;
      break;
  }
}

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

void L99PM62drv_SetCyclicWakeUp (L99PM62drv_EnableType cyclicWakeMode, L99PM62drv_CyclicWakeUpTimerType timer)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetTimer1, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if ((cyclicWakeMode !=  L99PM62DRV_ENABLE) && (cyclicWakeMode !=  L99PM62DRV_DISABLE) )
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCyclicWakeUp, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  if ((timer != L99PM62DRV_CYCLIC_WAKEUP_TIMER1) && (timer != L99PM62DRV_CYCLIC_WAKEUP_TIMER2))
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCyclicWakeUp, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }
#endif


  if (cyclicWakeMode ==  L99PM62DRV_ENABLE)
  {
    CtrlReg3[0] |= 0x02U;
  }
  else if (cyclicWakeMode == L99PM62DRV_DISABLE)
  {
    CtrlReg3[0] &= (u8)~0x02U;
  }
  else return;

  if (timer == L99PM62DRV_CYCLIC_WAKEUP_TIMER1)
  {
    CtrlReg3[0] |= 0x01U;
  }
  else if (timer == L99PM62DRV_CYCLIC_WAKEUP_TIMER2)
  {
    CtrlReg3[0] &= (u8)~0x01U;
  }
  else return;

  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
                        CtrlReg3,
                        &GlobalStatusRegister,
                        CtrlReg3_old);
}


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

void L99PM62drv_EnableBusWakeUp (L99PM62drv_EnableType LINWakeUp, L99PM62drv_EnableType CANWakeUp)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableBusWakeUp, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if ((LINWakeUp !=  L99PM62DRV_ENABLE) && (LINWakeUp !=  L99PM62DRV_DISABLE) )
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableBusWakeUp, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }
  if ((CANWakeUp !=  L99PM62DRV_ENABLE) && (CANWakeUp !=  L99PM62DRV_DISABLE) )
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_EnableBusWakeUp, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE))
    {
      return;
    }
  }

#endif


  if (LINWakeUp ==  L99PM62DRV_DISABLE)
  {
    CtrlReg3[0] &= (u8)~0x08U;
  }
  else
  {
    CtrlReg3[0] |= 0x08U;
  }
  if (CANWakeUp ==  L99PM62DRV_DISABLE)
  {
    CtrlReg3[0] &= (u8)~0x04U;
  }
  else
  {
    CtrlReg3[0] |= 0x04U;
  }
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
                        CtrlReg3,
                        &GlobalStatusRegister,
                        CtrlReg3_old);
}

/******************************************************************************/
/*! @fn             void L99PM62drv_SetCanStandbyMode (L99PM62drv_EnableType CanSleep)
    @param[in]      Enables/disables the CAN cell
    @brief
Function enables the CAN peripherial. If CanSleep == FALSE the CAN is swithed to
sleep mode.
Affected register: CR4..4
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetCanStandbyMode (L99PM62drv_EnableType CanSleep)
{
#ifdef  L99PM62DRV_DEV_ERROR_DETECT

  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCanStandbyMode, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
  if ((CanSleep !=  L99PM62DRV_ENABLE) && (CanSleep !=  L99PM62DRV_DISABLE) )
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_SetCanStandbyMode, L99PM62DRV_EID_PARAMETER1_OUT_OF_RANGE))
    {
      return;
    }
  }

#endif


  if (CanSleep ==  L99PM62DRV_DISABLE)
  {
    CtrlReg4[0] &= (u8)~0x10U;
  }
  else
  {
    CtrlReg4[0] |= 0x10U;
  }

  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);

}

/******************************************************************************/
/*! @fn             bool L99PM62drv_GetGlobaStatusRegister (void)
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

u8 L99PM62drv_GetGlobalStatusRegister (void)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_GetGlobalStatusRegister, L99PM62DRV_EID_UNINIT))
    {
      return (TRUE);          /* return Global error to upper function */
    }
  }
#endif
  return (GlobalStatusRegister);
}


/******************************************************************************/
/*! @fn             void L99PM62drv_ReadStatus (L99PM62drv_RegIDType regID,L99PM62drv_RegType *DataPtr)
    @param[out]     *dataPtr points to variable which will be filled with StatusRegister data
  @param[in]      regID select the status register for this SPI operation
    @brief
Function reads selected status register from L99PM62 via SPI and than files data
structure with received data.
Caveats: Function waits until the data are transferred completely to L99PM62
via SPI.
*/
/******************************************************************************/

void L99PM62drv_ReadStatus (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ReadStatus, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (regID)
  {
    case L99PM62DRV_SR1:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_SR1,
                            StatReg1,
                            &GlobalStatusRegister,
                            StatReg1);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg1[1] << 8 ) + (L99PM62drv_RegType)StatReg1[0] ;
      break;
    case L99PM62DRV_SR2:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_SR2,
                            StatReg2,
                            &GlobalStatusRegister,
                            StatReg2);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg2[1] << 8) + (L99PM62drv_RegType)StatReg2[0] ;
      break;
    case L99PM62DRV_SR3:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_SR3,
                            StatReg3,
                            &GlobalStatusRegister,
                            StatReg3);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg3[1] << 8) + (L99PM62drv_RegType)StatReg3[0] ;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_ReadStatus, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
#endif
      return;
  }
}


/******************************************************************************/
/*! @fn             void L99PM62drv_ReadClearStatus (L99PM62drv_RegIDType regID,L99PM62drv_RegType *DataPtr)
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

void L99PM62drv_ReadClearStatus (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ReadClearStatus, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (regID)
  {
    case L99PM62DRV_SR1:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_SR1,
                            StatReg1,
                            &GlobalStatusRegister,
                            StatReg1);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg1[1] << 8) + (L99PM62drv_RegType)StatReg1[0] ;
      break;
    case L99PM62DRV_SR2:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_SR2,
                            StatReg2,
                            &GlobalStatusRegister,
                            StatReg2);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg2[1] << 8) + (L99PM62drv_RegType)StatReg2[0] ;
      break;
    case L99PM62DRV_SR3:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_SR3,
                            StatReg3,
                            &GlobalStatusRegister,
                            StatReg3);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)StatReg3[1] << 8) + (L99PM62drv_RegType)StatReg3[0] ;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_ReadClearStatus, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
#endif
      return;
  }
}

/******************************************************************************/
/*! @fn             void L99PM62drv_ReadControl (L99PM62drv_RegIDType regID,L99PM62drv_RegType *DataPtr)
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
void L99PM62drv_ReadControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ReadControl, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (regID)
  {
    case L99PM62DRV_CR1:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR1,
                            CtrlReg1,
                            &GlobalStatusRegister,
                            CtrlReg1);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg1[1] << 8 ) + (L99PM62drv_RegType)CtrlReg1[0] ;
      break;
    case L99PM62DRV_CR2:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR2,
                            CtrlReg2,
                            &GlobalStatusRegister,
                            CtrlReg2);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg2[1] << 8 ) + (L99PM62drv_RegType)CtrlReg2[0] ;
      break;
    case L99PM62DRV_CR3:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR3,
                            CtrlReg3,
                            &GlobalStatusRegister,
                            CtrlReg3);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg3[1] << 8) + (L99PM62drv_RegType)CtrlReg3[0] ;
      break;
    case L99PM62DRV_CR4:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR4,
                            CtrlReg4,
                            &GlobalStatusRegister,
                            CtrlReg4);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg4[1] << 8) + (L99PM62drv_RegType)CtrlReg4[0] ;
      break;
    case L99PM62DRV_CR5:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR5,
                            CtrlReg5,
                            &GlobalStatusRegister,
                            CtrlReg5);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg5[1] << 8) + (L99PM62drv_RegType)CtrlReg5[0] ;
      break;
    case L99PM62DRV_CR6:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CR6,
                            CtrlReg6,
                            &GlobalStatusRegister,
                            CtrlReg6);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg6[1] << 8) + (L99PM62drv_RegType)CtrlReg6[0] ;
      break;
    case L99PM62DRV_CFR:
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ | L99PM62DRV_CFR,
                            ConfigReg,
                            &GlobalStatusRegister,
                            ConfigReg);
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)ConfigReg[1] << 8) + (L99PM62drv_RegType)ConfigReg[0] ;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_ReadControl, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
#endif
      return;
  }
}


/******************************************************************************/
/*! @fn             void L99PM62drv_GetControl (L99PM62drv_RegIDType regID,L99PM62drv_RegType *DataPtr)
    @param[out]     *dataPtr points to variable which will be filled with StatusRegister data
  @param[in]      regID select the status register for this SPI operation
    @brief
Function returns the las CR value readed bach during CR write operation. This
function don't access directly to silicon vias SPI.
Caveats: returned value is related to last I/O operation with selected Control
register
*/
/******************************************************************************/
void L99PM62drv_GetControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr )
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_GetControl, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (regID)
  {
    case L99PM62DRV_CR1:
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg1_old[1] << 8) + (L99PM62drv_RegType)CtrlReg1_old[0] ;
      break;
    case L99PM62DRV_CR2:
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg2_old[1] << 8) + (L99PM62drv_RegType)CtrlReg2_old[0] ;
      break;
    case L99PM62DRV_CR3:
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg3_old[1] << 8) + (L99PM62drv_RegType)CtrlReg3_old[0] ;
      break;
    case L99PM62DRV_CR4:
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg4_old[1] << 8) + (L99PM62drv_RegType)CtrlReg4_old[0] ;
      break;
    case L99PM62DRV_CR5:
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg5_old[1] << 8) + (L99PM62drv_RegType)CtrlReg5_old[0] ;
      break;
    case L99PM62DRV_CR6:
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)CtrlReg6_old[1] << 8) + (L99PM62drv_RegType)CtrlReg6_old[0] ;
      break;
    case L99PM62DRV_CFR:
      *DataPtr = (L99PM62drv_RegType)((L99PM62drv_RegType)ConfigReg_old[1] << 8) + (L99PM62drv_RegType)ConfigReg_old[0] ;
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_GetControl, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
#endif
      return;
  }
}

/******************************************************************************/
/*! @fn             void L99PM62drv_WriteControl (L99PM62drv_RegIDType regID,L99PM62drv_RegType *DataPtr)
    @param[in]     *dataPtr points to variable which will is filled with StatusRegister data
  @param[in]      regID select the status register for this SPI operation
    @brief
Function reads selected control register from L99PM62 via SPI and than files
data structure with received data. This function has no sense to use if driver
should protect user to access directly to control register
Caveats: Function waits until the data are transferred completely to L99PM62
via SPI.
*/
/******************************************************************************/
void L99PM62drv_WriteControl (L99PM62drv_RegIDType regID, L99PM62drv_RegType *DataPtr)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_WriteControl, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif

  switch (regID)
  {
    case L99PM62DRV_CR1:
      CtrlReg1[1] = (u8)(*DataPtr >> 8);
      CtrlReg1[0] = (CtrlReg1[0] & 0x01U) | ((u8)(*DataPtr) & ~0x01U);
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR1,
                            CtrlReg1,
                            &GlobalStatusRegister,
                            CtrlReg1_old);
      break;
    case L99PM62DRV_CR2:
      CtrlReg2[1] = (u8)(*DataPtr >> 8);
      CtrlReg2[0] = (u8)(*DataPtr);
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR2,
                            CtrlReg2,
                            &GlobalStatusRegister,
                            CtrlReg2_old);
      break;
    case L99PM62DRV_CR3:
      CtrlReg3[1] = (u8)(*DataPtr >> 8);
      CtrlReg3[0] = (u8)(*DataPtr);
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR3,
                            CtrlReg3,
                            &GlobalStatusRegister,
                            CtrlReg3_old);
      break;
    case L99PM62DRV_CR4:
      CtrlReg4[1] = (u8)(*DataPtr >> 8);
      CtrlReg4[0] = (u8)(*DataPtr);
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                            CtrlReg4,
                            &GlobalStatusRegister,
                            CtrlReg4_old);
      break;
    case L99PM62DRV_CR5:
      CtrlReg5[1] = (u8)(*DataPtr >> 8);
      CtrlReg5[0] = (u8)(*DataPtr);
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR5,
                            CtrlReg5,
                            &GlobalStatusRegister,
                            CtrlReg5_old);
      break;
    case L99PM62DRV_CR6:
      CtrlReg6[1] = (u8)(*DataPtr >> 8);
      CtrlReg6[0] = (u8)(*DataPtr);
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR6,
                            CtrlReg6,
                            &GlobalStatusRegister,
                            CtrlReg6_old);
      break;
    case L99PM62DRV_CFR:
      ConfigReg[1] = (u8)(*DataPtr >> 8);
      ConfigReg[0] = (u8)(*DataPtr);
      L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CFR,
                            ConfigReg,
                            &GlobalStatusRegister,
                            ConfigReg_old);
      break;
    default:
#ifdef  L99PM62DRV_DEV_ERROR_DETECT
      L99PM62drv_ReportError (SID_L99PM62drv_WriteControl, L99PM62DRV_EID_PARAMETER2_OUT_OF_RANGE);
#endif
      return;
  }
}



/******************************************************************************/
/*! @fn             void L99PM62drv_ClearStatusRegisters (void)
    @brief
Function clears content of all status registers and GSR directly in L99PM62.
Function processes Read and Clear command on the Configuration Register
at ST-SPI RAM address 0x3F(for details see ST SPI Spec 3.0)
*/
/******************************************************************************/

void L99PM62drv_ClearStatusRegisters (void)
{

#ifdef  L99PM62DRV_DEV_ERROR_DETECT
  if (!InitFlag)
  {
    if (FALSE == L99PM62drv_ReportError (SID_L99PM62drv_ClearStatusRegisters, L99PM62DRV_EID_UNINIT))
    {
      return;
    }
  }
#endif
  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_READ_CLEAR | L99PM62DRV_CFR,
                        ConfigReg,
                        &GlobalStatusRegister,
                        ConfigReg_old);
}



/******************************************************************************/
/*! @fn             bool L99PM62DRV_AL_SPI_WR( u8  commandByte,  u8*  dataIn,
      u8*  globalStatus,  u8*  dataOut)
    @brief
Function sends and receives data from L99PM62. Send and receive 3 bytes.
Manage CSN pin of L99PM62 which is connected to STM8AF PE5 port as a chip select.

*/
/******************************************************************************/
void L99PM62DRV_AL_SPI_WR( u8  commandByte,  u8*  dataIn,
                           u8*  globalStatus,  u8*  dataOut)
{
  u8 temp;

  //Set CSN pin (PE5) low from L99PM62 (enable SPI transmission)
  temp = GPIOE->ODR;
  temp &= 0xDF;
  GPIOE->ODR = temp;

  SPI_SendData(commandByte);
  while (!SPI_GetFlagStatus(SPI_FLAG_TXE));

  while (!SPI_GetFlagStatus(SPI_FLAG_RXNE));
  globalStatus[0] = SPI_ReceiveData();

  /* Read Global Status register and warn if an error is detected */
  if (globalStatus[0] != L99PM62_NoError)
  {
    ErrorState = TRUE;
    if (StartupCompleted == TRUE) /* To allow leds display at startup */
    {
      count ++;
      if (count > 20)
      {
        GPIO_TOGGLE(GPIOA, GPIO_PIN_3);
        count = 0;
      }
      switch (globalStatus[0])
      {
        case (L99PM62_CommError):
              case (L99PM62_WD_SPI_Error):
                  /* LD4 ON Invalid clock count*/
                  GPIO_HIGH(GPIOD, GPIO_PIN_3);
          GPIO_LOW(GPIOD, GPIO_PIN_0);
          GPIO_LOW(GPIOE, GPIO_PIN_3);
          GPIO_LOW(GPIOC, GPIO_PIN_3);
          break;

        case (L99PM62_VsOverVUnderV):
              case (L99PM62_VsOverVUnderVFS):
                  /* LD5 ON Vs out of range */
                  GPIO_LOW(GPIOD, GPIO_PIN_3);
          GPIO_HIGH(GPIOD, GPIO_PIN_0);
          GPIO_LOW(GPIOE, GPIO_PIN_3);
          GPIO_LOW(GPIOC, GPIO_PIN_3);
          break;

        case (L99PM62_TSD1):
              case (L99PM62_TSD2):
                  /* LD7 ON Thermal shutdown */
                  GPIO_LOW(GPIOD, GPIO_PIN_3);
          GPIO_LOW(GPIOD, GPIO_PIN_0);
          GPIO_HIGH(GPIOE, GPIO_PIN_3);
          GPIO_LOW(GPIOC, GPIO_PIN_3);
          break;

        default:
          GPIO_LOW(GPIOD, GPIO_PIN_3);
          GPIO_LOW(GPIOD, GPIO_PIN_0);
          GPIO_LOW(GPIOE, GPIO_PIN_3);
          GPIO_HIGH(GPIOC, GPIO_PIN_3);
          break;
      }
    }
  }
  else
{
    ErrorState = FALSE;
  }

  SPI_SendData(dataIn[1]);
  while (!SPI_GetFlagStatus(SPI_FLAG_TXE));

  while (!SPI_GetFlagStatus(SPI_FLAG_RXNE));
  dataOut[1] = SPI_ReceiveData();

  SPI_SendData(dataIn[0]);
  while (!SPI_GetFlagStatus(SPI_FLAG_TXE));

  while (!SPI_GetFlagStatus(SPI_FLAG_RXNE));
  dataOut[0] = SPI_ReceiveData();

  //Set CSN pin (PE5) high from L99PM62 (disable SPI transmission)
  temp = GPIOE->ODR;
  temp |= 0x20;
  GPIOE->ODR = (uint8_t)temp;
}

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

void L99PM62drv_SetCanLoopBackMode (L99PM62drv_EnableType CanLoop)
{

  if (CanLoop ==  L99PM62DRV_DISABLE)
  {
    CtrlReg4[0] &= (u8)~0x08U;
  }
  else
  {
    CtrlReg4[0] |= 0x08U;
  }

  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);

}

/******************************************************************************/
/*! @fn             void L99PM62drv_SetCanPatternWakeUp (L99PM62drv_EnableType CanPattern)
    @param[in]      Enable CAN cell in Loop Back Mode
    @brief
Function enables or disables the CAN peripheral Pattern WakeUp
Note: Function updates SW driver internal copy of Control Register 4
and the register is immediately sent to L99PM62 via SPI.
*/
/******************************************************************************/

void L99PM62drv_SetCanPatternWakeUp (L99PM62drv_EnableType CanPattern)
{

  if (CanPattern ==  L99PM62DRV_DISABLE)
  {
    CtrlReg4[0] &= (u8)~0x04U;
  }
  else
  {
    CtrlReg4[0] |= 0x04U;
  }

  L99PM62DRV_AL_SPI_WR( L99PM62DRV_ST_SPI_WRITE | L99PM62DRV_CR4,
                        CtrlReg4,
                        &GlobalStatusRegister,
                        CtrlReg4_old);

}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
