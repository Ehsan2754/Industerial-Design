################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/system_stm32f1xx.c 

OBJS += \
./Drivers/CMSIS/system_stm32f1xx.o 

C_DEPS += \
./Drivers/CMSIS/system_stm32f1xx.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/CMSIS/system_stm32f1xx.o: E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/system_stm32f1xx.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak=__attribute__((weak)) -D__packed=__attribute__((__packed__)) -DUSE_HAL_DRIVER -DSTM32F103xB -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Inc" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/CMSIS/Include" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Inc" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Inc" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/CMSIS/Include" -I"E:/electronics/BLDC_FOC_STM32F103RBT/TEST_6/Drivers/CMSIS/Device/ST/STM32F1xx/Include"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Drivers/CMSIS/system_stm32f1xx.d" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


