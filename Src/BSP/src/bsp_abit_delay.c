#include "bsp_abit_delay.h"

static uint8_t beat_us = 0;
static uint16_t beat_ms = 0;

void bsp_abit_delay_init(uint8_t TICK)
{
    SysTick_CLKSourceConfig(SysTick_CLKSource_HCLK_Div8);

#ifdef SUPPORT_OS
    CoreDebug->DEMCR &= (~CoreDebug_DEMCR_TRCENA_Msk);
    CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
    DWT->CYCCNT = 0x00;
    DWT->CTRL &= (~DWT_CTRL_CYCCNTENA_Msk);
    DWT->CTRL |= DWT_CTRL_CYCCNTENA_Msk;
#else
    beat_us = TICK / 8;
    beat_ms = (uint16_t)beat_us * 1000;
#endif
}

#ifdef SUPPORT_OS
static uint32_t bsp_abit_get_count()
{
    return (uint32_t)DWT->CYCCNT;
}
#endif

void bsp_abit_delay_us(uint32_t nus)
{
#ifdef SUPPORT_OS
    uint32_t ts = 0;
    uint32_t start = 0;

    ts = nus * (SystemCoreClock / 1000000);
    start = bsp_abit_get_count();

    while(bsp_abit_get_count() - start < ts);

#else
    uint32_t temp = 0;

    SysTick->LOAD = beat_us * nus;
    SysTick->VAL = 0x00;
    SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;

    do
    {
        temp = SysTick->CTRL;
    } while ((temp & 0x01) && (!(temp & (1 << 16))));
    
    SysTick->VAL = 0x00;
    SysTick->CTRL &= (~(SysTick_CTRL_ENABLE_Msk));
#endif
}

void bsp_abit_delay_ms(uint16_t nms)
{
#ifdef SUPPORT_OS
    uint32_t ts = 0;
    uint32_t start = 0;

    ts = nms * (SystemCoreClock / 1000000) * 1000;
    start = bsp_abit_get_count();

    while(bsp_abit_get_count() - start < ts);
#else
    uint32_t temp = 0;

    SysTick->LOAD = (uint32_t)beat_ms * nms;
    SysTick->VAL = 0x00;
    SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;

    do
    {
        temp = SysTick->CTRL;
    } while ((temp & 0x01) && (!(temp & (1 << 16))));
    
    SysTick->VAL = 0x00;
    SysTick->CTRL &= (~(SysTick_CTRL_ENABLE_Msk));
#endif
}