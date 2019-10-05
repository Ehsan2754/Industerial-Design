################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Src/main.c \
../Src/stm32f1xx_hal_msp.c \
../Src/stm32f1xx_it.c 

OBJS += \
./Src/main.o \
./Src/stm32f1xx_hal_msp.o \
./Src/stm32f1xx_it.o 

C_DEPS += \
./Src/main.d \
./Src/stm32f1xx_hal_msp.d \
./Src/stm32f1xx_it.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xE -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/controll/RBT/Inc" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/controll/RBT/Drivers/STM32F1xx_HAL_Driver/Inc" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/controll/RBT/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/controll/RBT/Drivers/CMSIS/Include" -I"E:/W/Projects/Hard-Wear/Industerial/grass cutter machine/controll/RBT/Drivers/CMSIS/Device/ST/STM32F1xx/Include"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


