################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/adc.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/dma.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/gpio.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/main.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/spi.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/stm32f1xx_hal_msp.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/stm32f1xx_it.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/tim.c \
D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/usart.c 

OBJS += \
./Application/User/adc.o \
./Application/User/dma.o \
./Application/User/gpio.o \
./Application/User/main.o \
./Application/User/spi.o \
./Application/User/stm32f1xx_hal_msp.o \
./Application/User/stm32f1xx_it.o \
./Application/User/tim.o \
./Application/User/usart.o 

C_DEPS += \
./Application/User/adc.d \
./Application/User/dma.d \
./Application/User/gpio.d \
./Application/User/main.d \
./Application/User/spi.d \
./Application/User/stm32f1xx_hal_msp.d \
./Application/User/stm32f1xx_it.d \
./Application/User/tim.d \
./Application/User/usart.d 


# Each subdirectory must supply rules for building sources it contributes
Application/User/adc.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/adc.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/adc.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/dma.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/dma.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/dma.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/gpio.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/gpio.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/gpio.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/main.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/main.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/main.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/spi.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/spi.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/spi.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/stm32f1xx_hal_msp.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/stm32f1xx_hal_msp.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/stm32f1xx_hal_msp.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/stm32f1xx_it.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/stm32f1xx_it.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/stm32f1xx_it.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/tim.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/tim.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/tim.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/usart.o: D:/Electronic/Projects/BLDC\ V3/Program/TEST_6/Src/usart.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"D:/Electronic/Projects/BLDC V3/Program/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Application/User/usart.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


