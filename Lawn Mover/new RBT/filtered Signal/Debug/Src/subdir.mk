################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Src/adc.c \
../Src/gpio.c \
../Src/main.c \
../Src/stm32f1xx_hal_msp.c \
../Src/stm32f1xx_it.c \
../Src/tim.c 

OBJS += \
./Src/adc.o \
./Src/gpio.o \
./Src/main.o \
./Src/stm32f1xx_hal_msp.o \
./Src/stm32f1xx_it.o \
./Src/tim.o 

C_DEPS += \
./Src/adc.d \
./Src/gpio.d \
./Src/main.d \
./Src/stm32f1xx_hal_msp.d \
./Src/stm32f1xx_it.d \
./Src/tim.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xB -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/new RBT/filtered Signal/Inc" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/new RBT/filtered Signal/Drivers/STM32F1xx_HAL_Driver/Inc" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/new RBT/filtered Signal/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/new RBT/filtered Signal/Drivers/CMSIS/Include" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/new RBT/filtered Signal/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/new RBT/filtered Signal/Inc"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


