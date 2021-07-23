#ifndef __BSP_ABIT_USART_H
#define __BSP_ABIT_USART_H

#include "stm32f4xx_gpio.h"
#include "stm32f4xx_usart.h"
#include "stm32f4xx_rcc.h"

#define USART_TX        GPIO_Pin_9
#define USART_RX        GPIO_Pin_10

void bsp_abit_usart_init(uint32_t baud);

#endif //__BSP_ABIT_USART_H