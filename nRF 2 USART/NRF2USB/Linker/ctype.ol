e0b0     +LDI R27 , HIGH ( 2 * _0x0 + ( 111 ) )
                 	__POINTW2FN _0x0,111
00031a d11d      	RCALL _PcDbg
                 ;     delay_ms(10);
00031b e0aa      	LDI  R26,LOW(10)
00031c e0b0      	LDI  R27,0
00031d d9b5      	RCALL _delay_ms
                 ;    fi2c_write(MPU_ADDRESS, MPU6050_RA_ACCEL_CONFIG, 0b00001000);     // Set Accel to +-4g         (AFS_SEL = 1)
00031e ede0      	LDI  R30,LOW(208)
00031f 93ea      	ST   -Y,R30
000320 e1ec      	LDI  R30,LOW(28)
000321 93ea      	ST   -Y,R30
000322 e0a8      	LDI  R26,LOW(8)
000323 d00e      	RCALL _fi2c_write
                 ;    PcDbg("Accel Configed!");
                +
000324 eaae     +LDI R26 , LOW ( 2 * _0x0 + ( 126 ) )
000325 e0b0     +LDI R27 , HIGH ( 2 * _0x0 + ( 126 ) )
                 	__POINTW2FN _0x0,126
000326 d111      	RCALL _PcDbg
                 ;     delay_ms(10);
000327 e0aa      	LDI  R26,LOW(10)
000328 e0b0      	LDI  R27,0
000329 d9a9      	RCALL _delay_ms
                 ;    fi2c_write(MPU_ADDRESS,MPU6050_RA_PWR_MGMT_1,0x00);               //Clock select and sleep off   Clock is set to internal oscillator
00032a ede0      	LDI  R30,LOW(208)
00032b 93ea      	ST   -Y,R30
00032c e6eb      	LDI  R30,LOW(107)
00032d 93ea      	ST   -Y,R30
00032e e0a0      	LDI  R26,LOW(0)
00032f d002      	RCALL _fi2c_write
                 ;//    if(dbgmpu == TRUE)
                 ;//    {
                 ;//     PcDbg("DebugMPU...");
                 ;//     delay_ms(50);
                 ;//     data = fi2c_read(MPU_ADDRESS,MPU6050_RA_SMPLRT_DIV);
                 ;//     if(data!=0x07) printf("/nRegister RA_SMPLRT failed, value should be 0x07, was 0x%x#", data);
                 ;//     delay_ms(50);
                 ;//     data = fi2c_read(MPU_ADDRESS,MPU6050_RA_CONFIG);
                 ;//     if(data!=0x00) printf("/nRegister RA_CONFIG failed, value should be 0x00, was 0x%x#", data);
                 ;//     delay_ms(50);
                 ;//     data = fi2c_read(MPU_ADDRESS,MPU6050_RA_GYRO_CONFIG);
                 ;//     if(data!=0x08) printf("/nRegister RA_GYRO_CONFIG failed, value should be 0x08, was 0x%x#", data);
                 ;//     delay_ms(50);
                 ;//     data = fi2c_read(MPU_ADDRESS,MPU6050_RA_ACCEL_CONFIG);
                 ;//     if(data!=0x08) printf("/nRegister RA_ACCEL_CONFIG failed, value should be 0x08, was 0x%x#", data);
                 ;//
                 ;//      if(fi2c_read(MPU_ADDRESS,MPU6050_RA_PWR_MGMT_1)!=0x00)
                 ;//      PcDbg("MPU6050_RA_PWR_MGMT_1 Failed");
                 ;//      delay_ms(50);
                 ;//    }
                 ;}
000330 8118      	LDD  R17,Y+0
000331 c115      	RJMP _0x20A0009
                 ;void fi2c_write(char slave_address, char reg_address, char data)
                 ;{
                 _fi2c_write:
                 ;    i2c_start();
000332 93aa      	ST   -Y,R26
                 ;	slave_address -> Y+2
                 ;	reg_address -> Y+1
                 ;	data -> Y+0
000333 d953      	RCALL _i2c_start
                 ;    i2c_write(slave_address);
000334 81aa      	LDD  R26,Y+2
000335 d985      	RCALL _i2c_write
                 ;    i2c_write(reg_address);
000336 81a9      	LDD  R26,Y+1
000337 d983      	RCALL _i2c_write
                 ;    i2c_write(data);
000338 81a8      	LD   R26,Y
000339 d981      	RCALL _i2c_write
                 ;    i2c_stop();
00033a d95b      	RCALL _i2c_stop
                 ;}
00033b c170      	RJMP _0x20A0008
                 ;unsigned char fi2c_read(char slave_address, char reg_address)
                 ;{
                 _fi2c_read:
                 ;    char data;
                 ;    i2c_start();
00033c 93aa      	ST   -Y,R26
00033d 931a      	ST   -Y,R17
                 ;	slave_address -> Y+2
                 ;	reg_address -> Y+1
                 ;	data -> R17
00033e d948      	RCALL _i2c_start
                 ;    i2c_write(slave_address | 0);
00033f 81ea      	LDD  R30,Y+2
000340 2fae      	MOV  R26,R30
000341 d979      	RCALL _i2c_write
                 ;    i2c_write(reg_address);
000342 81a9      	LDD  R26,Y+1
000343 d977      	RCALL _i2c_write
                 ;
                 ;    i2c_start();
000344 d942      	RCALL _i2c_start
                 ;    i2c_write(slave_address | 1);
000345 81ea      	LDD  R30,Y+2
000346 60e1      	ORI  R30,1
000347 2fae      	MOV  R26,R30
000348 d972      	RCALL _i2c_write
                 ;    data=i2c_read(0);
000349 e0a0      	LDI  R26,LOW(0)
00034a d955      	RCALL _i2c_read
00034b 2f1e      	MOV  R17,R30
                 ;    i2c_stop();
00034c d949      	RCALL _i2c_stop
                 ;
                 ;    return data;
00034d 2fe1      	MOV  R30,R17
00034e 8118      	LDD  R17,Y+0
00034f c15c      	RJMP _0x20A0008
                 ;}
                 ;char i2c_test()
                 ;{     char data;
                 _i2c_test:
                 ;      data = fi2c_read(MPU_ADDRESS,MPU6050_RA_WHO_AM_I); //reads the who am I reg it should be 0x68
000350 931a      	ST   -Y,R17
                 ;	data -> R17
000351 ede0      	LDI  R30,LOW(208)
000352 93ea      	ST   -Y,R30
000353 e7a5      	LDI  R26,LOW(117)
000354 dfe7      	RCALL _fi2c_read
000355 2f1e      	MOV  R17,R30
                 ;      return data;
000356 2fe1      	MOV  R30,R17
000357 9119      	LD   R17,Y+
000358 9508      	RET
                 ;}
                 ;#include <R2T_IMU_Common.h>
                 ;#include <R2T_IMU_Common_DEC.h>
                 ;#define EnterKey   PINC.2
                 ;#define ADC_VREF_TYPE 0x00
                 ;//========================================================MPU-6050 Codes==========================================================
                 ;char  OnPcDebug =    1;
                 ;char TimerCounterFlag=0;
                 ;int Timer1Freq=0;
                 ;int Timer2CounterFlag = 0;
                 ;#ifndef RXB8
                 ;#define RXB8 1
                 ;#endif
                 ;#ifndef TXB8
                 ;#define TXB8 0
                 ;#endif
                 ;#ifndef UPE
                 ;#define UPE 2
                 ;#endif
                 ;#ifndef DOR
                 ;#define DOR 3
                 ;#endif
                 ;#ifndef FE
                 ;#define FE 4
                 ;#endif
                 ;#ifndef UDRE
                 ;#define UDRE 5
                 ;#endif
                 ;#ifndef RXC
                 ;#define RXC 7
                 ;#endif
                 ;#define FRAMING_ERROR (1<<FE)
                 ;#define PARITY_ERROR (1<<UPE)
                 ;#define DATA_OVERRUN (1<<DOR)
                 ;#define DATA_REGISTER_EMPTY (1<<UDRE)
                 ;#define RX_COMPLETE (1<<RXC)
                 ;#define RX_BUFFER_SIZE 8             // USART Receiver buffer
                 ;char rx_buffer[RX_BUFFER_SIZE];
                 ;#if RX_BUFFER_SIZE <= 256
                 ;unsigned char rx_wr_index,rx_rd_index,rx_counter;
                 ;#else
                 ;unsigned int rx_wr_index,rx_rd_index,rx_counter;
                 ;#endif
                 ;bit rx_buffer_overflow;            // This flag is set on USART Receiver buffer overflow
                 ;interrupt [USART_RXC] void usart_rx_isr(void)
                 ; 0000 004B {
                 _usart_rx_isr:
000359 93aa      	ST   -Y,R26
00035a 93ea      	ST   -Y,R30
00035b 93fa      	ST   -Y,R31
00035c b7ef      	IN   R30,SREG
00035d 93ea      	ST   -Y,R30
                 ; 0000 004C char status,data;
                 ; 0000 004D status=UCSRA;
00035e dc58      	RCALL __SAVELOCR2
                 ;	status -> R17
                 ;	data -> R16
00035f b11b      	IN   R17,11
                 ; 0000 004E data=UDR;
000360 b10c      	IN   R16,12
                 ; 0000 004F if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
000361 2fe1      	MOV  R30,R17
000362 71ec      	ANDI R30,LOW(0x1C)
000363 f4b1      	BRNE _0x6
                 ; 0000 0050    {
                 ; 0000 0051    rx_buffer[rx_wr_index++]=data;
000364 2ded      	MOV  R30,R13
000365 94d3      	INC  R13
000366 e0f0      	LDI  R31,0
000367 57ea      	SUBI R30,LOW(-_rx_buffer)
000368 4ffd      	SBCI R31,HIGH(-_rx_buffer)
000369 8300      	ST   Z,R16
                 ; 0000 0052 #if RX_BUFFER_SIZE == 256
                 ; 0000 0053    // special case for receiver buffer size=256
                 ; 0000 0054    if (++rx_counter == 0) rx_buffer_overflow=1;
                 ; 0000 0055 #else
                 ; 0000 0056    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
00036a e0e8      	LDI  R30,LOW(8)
00036b 15ed      	CP   R30,R13
00036c f409      	BRNE _0x7
00036d 24dd      	CLR  R13
                 ; 0000 0057    if (++rx_counter == RX_BUFFER_SIZE)
                 _0x7:
00036e 91a0 028e 	LDS  R26,_rx_counter
000370 5faf      	SUBI R26,-LOW(1)
000371 93a0 028e 	STS  _rx_counter,R26
000373 30a8      	CPI  R26,LOW(0x8)
000374 f429      	BRNE _0x8
                 ; 0000 0058       {
                 ; 0000 0059       rx_counter=0;
000375 e0e0      	LDI  R30,LOW(0)
000376 93e0 028e 	STS  _rx_counter,R30
                 ; 0000 005A       rx_buffer_overflow=1;
000378 9468      	SET
000379 f820      	BLD  R2,0
                 ; 0000 005B       }
                 ; 0000 005C #endif
                 ; 0000 005D    }
                 _0x8:
                 ; 0000 005E }
                 _0x6:
00037a dc46      	RCALL __LOADLOCR2P
00037b 91e9      	LD   R30,Y+
00037c bfef      	OUT  SREG,R30
00037d 91f9      	LD   R31,Y+
00037e 91e9      	LD   R30,Y+
00037f 91a9      	LD   R26,Y+
000380 9518      	RETI
                 ;#ifndef _DEBUG_TERMINAL_IO_
                 ;// Get a character from the USART Receiver buffer
                 ;#define _ALTERNATE_GETCHAR_
                 ;#pragma used+
                 ;char getchar(void)
                 ; 0000 0064 {
                 ; 0000 0065 char data;
                 ; 0000 0066 while (rx_counter==0);
                 ;	data -> R17
                 ; 0000 0067 data=rx_buffer[rx_rd_index++];
                 ; 0000 0068 #if RX_BUFFER_SIZE != 256
                 ; 0000 0069 if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
                 ; 0000 006A #endif
                 ; 0000 006B #asm("cli")
                 ; 0000 006C --rx_counter;
                 ; 0000 006D #asm("sei")
                 ; 0000 006E return data;
                 ; 0000 006F }
                 ;#pragma used-
                 ;#endif
                 ;interrupt [EXT_INT1] void ext_int1_isr(void)
                 ; 0000 0073 {
                 _ext_int1_isr:
                 ; 0000 0074 
                 ; 0000 0075 }
000381 9518      	RETI
                 ;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
                 ; 0000 0077 {
                 _timer0_ovf_isr:
000382 920a      	ST   -Y,R0
000383 921a      	ST   -Y,R1
000384 92fa      	ST   -Y,R15
000385 936a      	ST   -Y,R22
000386 937a      	ST   -Y,R23
000387 938a      	ST   -Y,R24
000388 939a      	ST   -Y,R25
000389 93aa      	ST   -Y,R26
00038a 93ba      	ST   -Y,R27
00038b 93ea      	ST   -Y,R30
00038c 93fa      	ST   -Y,R31
00038d b7ef      	IN   R30,SREG
00038e 93ea      	ST   -Y,R30
                 ; 0000 0078 TCNT0=156;
00038f e9ec      	LDI  R30,LOW(156)
000390 bfe2      	OUT  0x32,R30
                 ; 0000 0079 
                 ; 0000 007A TimerCounterFlag++;
000391 9463      	INC  R6
                 ; 0000 007B if(TimerCounterFlag == 96)
000392 e6e0      	LDI  R30,LOW(96)
000393 15e6      	CP   R30,R6
000394 f439      	BRNE _0xD
                 ; 0000 007C {
                 ; 0000 007D //PcDbg("1");
                 ; 0000 007E  Timer1Freq++;
000395 01f4      	MOVW R30,R8
000396 9631      	ADIW R30,1
000397 014f      	MOVW R8,R30
                 ; 0000 007F  //#asm("cli");
                 ; 0000 0080  ReadAccelData();
000398 dd91      	RCALL _ReadAccelData
                 ; 0000 0081  ReadGyroData();
000399 de56      	RCALL _ReadGyroData
                 ; 0000 0082  Get_Accel_Angles();
00039a ddcd      	RCALL _Get_Accel_Angles
                 ; 0000 0083  //#asm("sei");
                 ; 0000 0084  TimerCounterFlag = 0;
00039b 2466      	CLR  R6
                 ; 0000 0085 }
                 ; 0000 0086 }
                 _0xD:
00039c 91e9      	LD   R30,Y+
00039d bfef      	OUT  SREG,R30
00039e 91f9      	LD   R31,Y+
00039f 91e9      	LD   R30,Y+
0003a0 91b9      	LD   R27,Y+
0003a1 91a9      	LD   R26,Y+
0003a2 9199      	LD   R25,Y+
0003a3 9189      	LD   R24,Y+
0003a4 9179      	LD   R23,Y+
0003a5 9169      	LD   R22,Y+
0003a6 90f9      	LD   R15,Y+
0003a7 9019      	LD   R1,Y+
0003a8 9009      	LD   R0,Y+
0003a9 9518      	RETI
                 ;interrupt [TIM2_OVF] void timer2_ovf_isr(void)
                 ; 0000 0088 {
                 _timer2_ovf_isr:
0003aa 920a      	ST   -Y,R0
0003ab 921a      	ST   -Y,R1
0003ac 92fa      	ST   -Y,R15
0003ad 936a      	ST   -Y,R22
0003ae 937a      	ST   -Y,R23
0003af 938a      	ST   -Y,R24
0003b0 939a      	ST   -Y,R25
0003b1 93aa      	ST   -Y,R26
0003b2 93ba      	ST   -Y,R27
0003b3 93ea      	ST   -Y,R30
0003b4 93fa      	ST   -Y,R31
0003b5 b7ef      	IN   R30,SREG
0003b6 93ea      	ST   -Y,R30
                 ; 0000 0089  TCNT2 = 6;
0003b7 e0e6      	LDI  R30,LOW(6)
0003b8 bde4      	OUT  0x24,R30
                 ; 0000 008A  Timer2CounterFlag++;
0003b9 01f5      	MOVW R30,R10
0003ba 9631      	ADIW R30,1
0003bb 015f      	MOVW R10,R30
                 ; 0000 008B  if(Timer2CounterFlag == 1000)
0003bc eee8      	LDI  R30,LOW(1000)
0003bd e0f3      	LDI  R31,HIGH(1000)
0003be 15ea      	CP   R30,R10
0003bf 05fb      	CPC  R31,R11
0003c0 f479      	BRNE _0xE
                 ; 0000 008C  {
                 ; 0000 008D   printf("T0:%dHz#",Timer1Freq);
                +
0003c1 ebee     +LDI R30 , LOW ( 2 * _0x0 + ( 142 ) )
0003c2 e0f0     +LDI R31 , HIGH ( 2 * _0x0 + ( 142 ) )
                 	__POINTW1FN _0x0,142
0003c3 93fa      	ST   -Y,R31
0003c4 93ea      	ST   -Y,R30
0003c5 01f4      	MOVW R30,R8
0003c6 db29      	RCALL __CWD1
0003c7 dbc5      	RCALL __PUTPARD1
0003c8 e084      	LDI  R24,4
0003c9 d501      	RCALL _printf
0003ca 9626      	ADIW R28,6
                 ; 0000 008E   Timer1Freq = 1;
0003cb e0e1      	LDI  R30,LOW(1)
0003cc e0f0      	LDI  R31,HIGH(1)
0003cd 014f      	MOVW R8,R30
                 ; 0000 008F   Timer2CounterFlag = 0;
0003ce 24aa      	CLR  R10
0003cf 24bb      	CLR  R11
                 ; 0000 0090  }
                 ; 0000 0091 }
                 _0xE:
0003d0 91e9      	LD   R30,Y+
0003d1 bfef      	OUT  SREG,R30
0003d2 91f9      	LD   R31,Y+
0003d3 91e9      	LD   R30,Y+
0003d4 91b9      	LD   R27,Y+
0003d5 91a9      	LD   R26,Y+
0003d6 9199      	LD   R25,Y+
0003d7 9189      	LD   R24,Y+
0003d8 9179      	LD   R23,Y+
0003d9 9169      	LD   R22,Y+
0003da 90f9      	LD   R15,Y+
0003db 9019      	LD   R1,Y+
0003dc 9009      	LD   R0,Y+
0003dd 9518      	RETI
                 ;unsigned int read_adc(unsigned char adc_input)
                 ; 0000 0093 {
                 ; 0000 0094 ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
                 ;	adc_input -> Y+0
                 ; 0000 0095 // Delay needed for the stabilization of the ADC input voltage
                 ; 0000 0096 delay_us(10);
                 ; 0000 0097 // Start the AD conversion
                 ; 0000 0098 ADCSRA|=0x40;
                 ; 0000 0099 // Wait for the AD conversion to complete
                 ; 0000 009A while ((ADCSRA & 0x10)==0);
                 ; 0000 009B ADCSRA|=0x10;
                 ; 0000 009C return ADCW;
                 ; 0000 009D }
                 ;void init()
                 ; 0000 009F {
                 _init:
                 ; 0000 00A0 // Declare your local variables here
                 ; 0000 00A1 
                 ; 0000 00A2 // Input/Output Ports initialization
                 ; 0000 00A3 // Port B initialization
                 ; 0000 00A4 // Func7=In Func6=In Func5=Out Func4=In Func3=In Func2=Out Func1=Out Func0=Out
                 ; 0000 00A5 // State7=T State6=T State5=0 State4=T State3=T State2=0 State1=0 State0=0
                 ; 0000 00A6 PORTB=0x00;
0003de e0e0      	LDI  R30,LOW(0)
0003df bbe8      	OUT  0x18,R30
                 ; 0000 00A7 DDRB=0x27;
0003e0 e2e7      	LDI  R30,LOW(39)
0003e1 bbe7      	OUT  0x17,R30
                 ; 0000 00A8 
                 ; 0000 00A9 // Port C initialization
                 ; 0000 00AA // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
                 ; 0000 00AB // State6=T State5=T State4=T State3=T State2=P State1=T State0=T
                 ; 0000 00AC PORTC=0x04;
0003e2 e0e4      	LDI  R30,LOW(4)
0003e3 bbe5      	OUT  0x15,R30
                 ; 0000 00AD DDRC=0x00;
0003e4 e0e0      	LDI  R30,LOW(0)
0003e5 bbe4      	OUT  0x14,R30
                 ; 0000 00AE 
                 ; 0000 00AF // Port D initialization
                 ; 0000 00B0 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In
                 ; 0000 00B1 // State7=0 State6=0 State5=0 State4=0 State3=T State2=T State1=T State0=T
                 ; 0000 00B2 PORTD=0x00;
0003e6 bbe2      	OUT  0x12,R30
                 ; 0000 00B3 DDRD=0xF0;
0003e7 efe0      	LDI  R30,LOW(240)
0003e8 bbe1      	OUT  0x11,R30
                 ; 0000 00B4 
                 ; 0000 00B5 // Timer/Counter 0 initialization
                 ; 0000 00B6 // Clock source: System Clock
                 ; 0000 00B7 // Clock value: 1 Mhz  / EveryThick is 1us / So 100thick is 0.1ms / 256-100 = 156 / So Every Interrupt is 0.1ms
                 ; 0000 00B8 TCCR0=0x02;
0003e9 e0e2      	LDI  R30,LOW(2)
0003ea bfe3      	OUT  0x33,R30
                 ; 0000 00B9 TCNT0=156;
0003eb e9ec      	LDI  R30,LOW(156)
0003ec bfe2      	OUT  0x32,R30
                 ; 0000 00BA 
                 ; 0000 00BB // Timer/Counter 1 initialization
                 ; 0000 00BC // Clock source: System Clock
                 ; 0000 00BD // Clock value: 7.813 kHz
                 ; 0000 00BE // Mode: Fast PWM top=0x00FF
                 ; 0000 00BF // OC1A output: Non-Inv.
                 ; 0000 00C0 // OC1B output: Non-Inv.
                 ; 0000 00C1 // Noise Canceler: Off
                 ; 0000 00C2 // Input Capture on Falling Edge
                 ; 0000 00C3 // Timer1 Overflow Interrupt: Off
                 ; 0000 00C4 // Input Capture Interrupt: Off
                 ; 0000 00C5 // Compare A Match Interrupt: Off
                 ; 0000 00C6 // Compare B Match Interrupt: Off
                 ; 0000 00C7 TCCR1A=0xA1;
0003ed eae1      	LDI  R30,LOW(161)
0003ee bdef      	OUT  0x2F,R30
                 ; 0000 00C8 TCCR1B=0x0D;
0003ef e0ed      	LDI  R30,LOW(13)
0003f0 bdee      	OUT  0x2E,R30
                 ; 0000 00C9 TCNT1H=0x00;
0003f1 e0e0      	LDI  R30,LOW(0)
0003f2 bded      	OUT  0x2D,R30
                 ; 0000 00CA TCNT1L=0x00;
0003f3 bdec      	OUT  0x2C,R30
                 ; 0000 00CB ICR1H=0x00;
0003f4 bde7      	OUT  0x27,R30
                 ; 0000 00CC ICR1L=0x00;
0003f5 bde6      	OUT  0x26,R30
                 ; 0000 00CD OCR1AH=0x00;
0003f6 bdeb      	OUT  0x2B,R30
                 ; 0000 00CE OCR1AL=0x00;
0003f7 bdea      	OUT  0x2A,R30
                 ; 0000 00CF OCR1BH=0x00;
0003f8 bde9      	OUT  0x29,R30
                 ; 0000 00D0 OCR1BL=0x00;
0003f9 bde8      	OUT  0x28,R30
                 ; 0000 00D1 
                 ; 0000 00D2 // Timer/Counter 2 initialization
                 ; 0000 00D3 // Clock source: System Clock
                 ; 0000 00D4 // Clock value: 250.000 kHz  // every 250 thick is 1ms
                 ; 0000 00D5 // Mode: Normal top=0xFF
                 ; 0000 00D6 // OC2 output: Disconnected
                 ; 0000 00D7 ASSR=0x00;
0003fa bde2      	OUT  0x22,R30
                 ; 0000 00D8 TCCR2=0x03;
0003fb e0e3      	LDI  R30,LOW(3)
0003fc bde5      	OUT  0x25,R30
                 ; 0000 00D9 TCNT2=0x06;
0003fd e0e6      	LDI  R30,LOW(6)
0003fe bde4      	OUT  0x24,R30
                 ; 0000 00DA OCR2=0x00;
0003ff e0e0      	LDI  R30,LOW(0)
000400 bde3      	OUT  0x23,R30
                 ; 0000 00DB 
                 ; 0000 00DC // External Interrupt(s) initialization
                 ; 0000 00DD // INT0: Off
                 ; 0000 00DE // INT1: On
                 ; 0000 00DF // INT1 Mode: Rising Edge
                 ; 0000 00E0 GICR|=0x80;
000401 b7eb      	IN   R30,0x3B
000402 68e0      	ORI  R30,0x80
000403 bfeb      	OUT  0x3B,R30
                 ; 0000 00E1 MCUCR=0x0C;
000404 e0ec      	LDI  R30,LOW(12)
000405 bfe5      	OUT  0x35,R30
                 ; 0000 00E2 GIFR=0x80;
000406 e8e0      	LDI  R30,LOW(128)
000407 bfea      	OUT  0x3A,R30
                 ; 0000 00E3 
                 ; 0000 00E4 // Timer(s)/Counter(s) Interrupt(s) initialization
                 ; 0000 00E5 TIMSK=0x41;
000408 e4e1      	LDI  R30,LOW(65)
000409 bfe9      	OUT  0x39,R30
                 ; 0000 00E6 
                 ; 0000 00E7 //// USART initialization
                 ; 0000 00E8 //// Communication Parameters: 8 Data, 1 Stop, No Parity
                 ; 0000 00E9 //// USART Receiver: On
                 ; 0000 00EA //// USART Transmitter: On
                 ; 0000 00EB //// USART Mode: Asynchronous
                 ; 0000 00EC //// USART Baud Rate: 38400
                 ; 0000 00ED //UCSRA=0x00;
                 ; 0000 00EE //UCSRB=0x98;
                 ; 0000 00EF //UCSRC=0x86;
                 ; 0000 00F0 //UBRRH=0x00;
                 ; 0000 00F1 //UBRRL=0x0C;
                 ; 0000 00F2 
                 ; 0000 00F3 // USART initialization
                 ; 0000 00F4 // Communication Parameters: 8 Data, 1 Stop, No Parity
                 ; 0000 00F5 // USART Receiver: On
                 ; 0000 00F6 // USART Transmitter: On
                 ; 0000 00F7 // USART Mode: Asynchronous
                 ; 0000 00F8 // USART Baud Rate: 115200   0x03
                 ; 0000 00F9 // USART Baud Rate: 56000  0x08
                 ; 0000 00FA // USART Baud Rate: 38400   0x0C
                 ; 0000 00FB 
                 ; 0000 00FC UCSRA=0x00;
00040a e0e0      	LDI  R30,LOW(0)
00040b b9eb      	OUT  0xB,R30
                 ; 0000 00FD 