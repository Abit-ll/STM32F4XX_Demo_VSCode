TARGET = STM32F4XX

BUILD_DIR = Obj

# C源文件
C_SOURCES =  \
Src/USER/src/main.c \
Src/BSP/src/bsp_abit_led.c \
Src/CORE/src/system_stm32f4xx.c \
Src/FWLIB/src/stm32f4xx_gpio.c \
Src/FWLIB/src/stm32f4xx_rcc.c \
Src/FWLIB/src/stm32f4xx_usart.c \
Src/FWLIB/src/misc.c \
Src/FWLIB/src/stm32f4xx_adc.c \
Src/FWLIB/src/stm32f4xx_can.c \
Src/FWLIB/src/stm32f4xx_crc.c \
Src/FWLIB/src/stm32f4xx_cryp_aes.c \
Src/FWLIB/src/stm32f4xx_cryp_des.c \
Src/FWLIB/src/stm32f4xx_cryp_tdes.c \
Src/FWLIB/src/stm32f4xx_cryp.c \
Src/FWLIB/src/stm32f4xx_dac.c \
Src/FWLIB/src/stm32f4xx_dbgmcu.c \
Src/FWLIB/src/stm32f4xx_dcmi.c \
Src/FWLIB/src/stm32f4xx_dma.c \
Src/FWLIB/src/stm32f4xx_dma2d.c \
Src/FWLIB/src/stm32f4xx_exti.c \
Src/FWLIB/src/stm32f4xx_flash_ramfunc.c \
Src/FWLIB/src/stm32f4xx_flash.c \
Src/FWLIB/src/stm32f4xx_fsmc.c \
Src/FWLIB/src/stm32f4xx_hash_md5.c \
Src/FWLIB/src/stm32f4xx_hash_sha1.c \
Src/FWLIB/src/stm32f4xx_hash.c \
Src/FWLIB/src/stm32f4xx_i2c.c \
Src/FWLIB/src/stm32f4xx_it.c \
Src/FWLIB/src/stm32f4xx_iwdg.c \
Src/FWLIB/src/stm32f4xx_ltdc.c \
Src/FWLIB/src/stm32f4xx_pwr.c \
Src/FWLIB/src/stm32f4xx_rng.c \
Src/FWLIB/src/stm32f4xx_rtc.c \
Src/FWLIB/src/stm32f4xx_sai.c \
Src/FWLIB/src/stm32f4xx_sdio.c \
Src/FWLIB/src/stm32f4xx_spi.c \
Src/FWLIB/src/stm32f4xx_syscfg.c \
Src/FWLIB/src/stm32f4xx_tim.c \
Src/FWLIB/src/stm32f4xx_wwdg.c \
Src/Bsp/src/bsp_abit_usart.c \
Src/Bsp/src/bsp_abit_printf.c \
Src/Bsp/src/bsp_abit_delay.c \
Src/FreeRTOS/src/croutine.c \
Src/FreeRTOS/src/event_groups.c \
Src/FreeRTOS/src/list.c \
Src/FreeRTOS/src/port.c \
Src/FreeRTOS/src/queue.c \
Src/FreeRTOS/src/stream_buffer.c \
Src/FreeRTOS/src/tasks.c \
Src/FreeRTOS/src/timers.c \
Src/FreeRTOS/src/heap_4.c
 
######################################
 
 
 
# ASM sources
ASM_SOURCES =  \
Src/CORE/src/startup_stm32f40_41xxx.s
 
######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Og
 
 
#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m4
 
# fpu
# NONE for Cortex-M0/M0+/M3
FPU = -mfloat-abi=hard -mfpu=fpv4-sp-d16
 
# float-abi
 
 
# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)
 
# macros for gcc
# AS defines
AS_DEFS = 
 
# C defines   宏定义标志
C_DEFS =  \
-DUSE_STDPERIPH_DRIVER \
-DSTM32F40_41xxx \
# -D__GNUC__
 
# AS includes
AS_INCLUDES = 
 
# C includes  C头文件路径
C_INCLUDES =  \
-ISrc/BSP/inc \
-ISrc/CORE/inc \
-ISrc/FWLIB/inc \
-ISrc/USER/inc \
-ISrc/FreeRTOS/inc
 
# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections
 
CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections
 
ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif
 
 
# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"
 
 
#######################################
# LDFLAGS
#######################################
# link script  链接配置文件
LDSCRIPT = Src/CORE/src/STM32F417IG_FLASH.ld
 
# libraries
#LIBS = -lc -lm -lnosys 
LIBS = -lc
LIBDIR = 
#LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections
LDFLAGS = $(MCU) --specs=nosys.specs --specs=nano.specs -std=c99 -u_printf_float -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections
 
# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin
 
 
#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))
 
$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@
 
$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@
 
$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@
 
$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@		
 
#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)