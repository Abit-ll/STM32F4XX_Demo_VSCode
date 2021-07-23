@echo off

set dir_path=F:\\Free\\Intelligent_Home\\Debugger
set image=F:\\Free\\Intelligent_Home\\Obj\\STM32F4XX.bin
set stlink_cfg=F:\\Free\\Intelligent_Home\\Debugger\\stlink.cfg
set stm32_cfg=F:\\Free\\Intelligent_Home\\Debugger\\stm32f4x.cfg

openocd -s %dir_path% -f %stlink_cfg% -f %stm32_cfg% -c ^
"init;halt;reset halt;flash write_image erase %image% 0x08000000;shutdown;"

@echo on