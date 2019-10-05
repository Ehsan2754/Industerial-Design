################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Src/ethernetif.c \
../Src/gpio.c \
../Src/lwip.c \
../Src/main.c \
../Src/stm32f4xx_hal_msp.c \
../Src/stm32f4xx_it.c 

OBJS += \
./Src/ethernetif.o \
./Src/gpio.o \
./Src/lwip.o \
./Src/main.o \
./Src/stm32f4xx_hal_msp.o \
./Src/stm32f4xx_it.o 

C_DEPS += \
./Src/ethernetif.d \
./Src/gpio.d \
./Src/lwip.d \
./Src/main.d \
./Src/stm32f4xx_hal_msp.d \
./Src/stm32f4xx_it.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo %cd%
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F429xx -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Inc" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Drivers/STM32F4xx_HAL_Driver/Inc" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Drivers/STM32F4xx_HAL_Driver/Inc/Legacy" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Drivers/CMSIS/Include" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Drivers/CMSIS/Device/ST/STM32F4xx/Include" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Inc" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/system" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/lwip" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/lwip/apps" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/lwip/priv" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/netif" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/netif/ppp" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/netif/ppp/polarssl" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/posix" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/src/include/posix/sys" -I"E:/W/Projects/Hard-Wear/Industerial/Lawn Mover/Ethernet/Middlewares/Third_Party/LwIP/system/arch"  -Os -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


