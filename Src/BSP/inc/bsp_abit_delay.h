#ifndef __BSP_ABIT_DELAY_H
#define __BSP_ABIT_DELAY_H

#include "misc.h"

#ifndef SUPPORT_OS
#define SUPPORT_OS          1
#endif

#ifdef SUPPORT_OS
#include "core_cm4.h"
#include "system_stm32f4xx.h"
#endif
#include "stm32f4xx_rtc.h"

void bsp_abit_delay_init(uint8_t TICK);

void bsp_abit_delay_us(uint32_t nus);

void bsp_abit_delay_ms(uint16_t nms);

#endif //__BSP_ABIT_DELAY_H