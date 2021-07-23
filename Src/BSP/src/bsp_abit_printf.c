#include "bsp_aibt_printf.h"

#ifdef __GNUC__
  /* With GCC/RAISONANCE, small printf (option LD Linker->Libraries->Small printf
     set to 'Yes') calls __io_putchar() */
  #define PUTCHAR_PROTOTYPE int __io_putchar(int ch)
#else
  #define PUTCHAR_PROTOTYPE int fputc(int ch, FILE *f)
#endif /* __GNUC__ */

PUTCHAR_PROTOTYPE
{
  /* Place your implementation of fputc here */
  /* e.g. write a character to the USART */
    while((USART1->SR & 0x40) == 0);
    USART1->DR = (uint8_t)(ch);

    return ch;
}

__attribute__((weak)) int _write(int file, char *ptr, int len)
{
   int DataIdx;
   for (DataIdx = 0; DataIdx < len; DataIdx++)
   {
      __io_putchar(*ptr++);
   }
   return len;
}