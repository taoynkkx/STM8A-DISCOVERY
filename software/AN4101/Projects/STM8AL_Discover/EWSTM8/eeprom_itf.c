#include "stm8l15x_flash.h"

int __eeprom_wait_for_last_operation(void)
{
  FLASH_Status_TypeDef status = FLASH_WaitForLastOperation(FLASH_MemType_Data);
  return !!(status &  ( (uint8_t)FLASH_Status_Successful_Operation
                      | FLASH_FLAG_HVOFF));
}

void __eeprom_program_byte(unsigned char __near * dst, unsigned char v)
{
  FLASH_ProgramByte((u32)dst, (u8)v);
}

void __eeprom_program_long(unsigned char __near * dst, unsigned long v)
{
  FLASH_ProgramWord((u32)dst, (u32)v);
}