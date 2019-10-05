            ; for(i=0;i<1000;i++)
00028b 2444      	CLR  R4
00028c 2455      	CLR  R5
                 _0x4:
00028d eee8      	LDI  R30,LOW(1000)
00028e e0f3      	LDI  R31,HIGH(1000)
00028f 164e      	CP   R4,R30
000290 065f      	CPC  R5,R31
000291 f4d4      	BRGE _0x5
                 ; {
                 ;  ReadGyroData();
000292 df5d      	RCALL _ReadGyroData
                 ;
                 ;  CGyro_X_Offset += GYRO_XOUT;
000293 91e0 0266 	LDS  R30,_GYRO_XOUT
000295 91f0 0267 	LDS  R31,_GYRO_XOUT+1
                +
000297 0f0e     +ADD R16 , R30
000298 1f1f     +ADC R17 , R31
                 	__ADDWRR 16,17,30,31
                 ;  CGyro_Y_Offset += GYRO_YOUT;
000299 91e0 0268 	LDS  R30,_GYRO_YOUT
00029b 91f0 0269 	LDS  R31,_GYRO_YOUT+1
                +
00029d 0f2e     +ADD R18 , R30
00029e 1f3f     +ADC R19 , R31
                 	__ADDWRR 18,19,30,31
                 ;  CGyro_Z_Offset += GYRO_ZOUT;
00029f 91e0 026a 	LDS  R30,_GYRO_ZOUT
0002a1 91f0 026b 	LDS  R31,_GYRO_ZOUT+1
                +
0002a3 0f4e     +ADD R20 , R30
0002a4 1f5f     +ADC R21 , R31
                 	__ADDWRR 20,21,30,31
                 ;  delay_ms(1);
0002a5 e0a1      	LDI  R26,LOW(1)
0002a6 e0b0      	LDI  R27,0
0002a7 da2b      	RCALL _delay_ms
                 ; }
0002a8 01f2      	MOVW R30,R4
0002a9 9631      	ADIW R30,1
0002aa 012f      	MOVW R4,R30
0002ab cfe1      	RJMP _0x4
                 _0x5:
                 ;  GYRO_XOUT_OFFSET = CGyro_X_Offset / 1000;
0002ac 01d8      	MOVW R26,R16
0002ad eee8      	LDI  R30,LOW(1000)
0002ae e0f3      	LDI  R31,HIGH(1000)
0002af dc6b      	RCALL __DIVW21
0002b0 93e0 026c 	STS  _GYRO_XOUT_OFFSET,R30
0002b2 93f0 026d 	STS  _GYRO_XOUT_OFFSET+1,R31
                 ;  GYRO_YOUT_OFFSET = CGyro_Y_Offset / 1000;
0002b4 01d9      	MOVW R26,R18
0002b5 eee8      	LDI  R30,LOW(1000)
0002b6 e0f3      	LDI  R31,HIGH(1000)
0002b7 dc63      	RCALL __DIVW21
0002b8 93e0 026e 	STS  _GYRO_YOUT_OFFSET,R30
0002ba 93f0 026f 	STS  _GYRO_YOUT_OFFSET+1,R31
                 ;  GYRO_ZOUT_OFFSET = CGyro_Z_Offset / 1000;
0002bc 01da      	MOVW R26,R20
0002bd eee8      	LDI  R30,LOW(1000)
0002be e0f3      	LDI  R31,HIGH(1000)
0002bf dc5b      	RCALL __DIVW21
0002c0 93e0 0270 	STS  _GYRO_ZOUT_OFFSET,R30
0002c2 93f0 0271 	STS  _GYRO_ZOUT_OFFSET+1,R31
                 ; printf("Gyro_X_Offset:%d#", GYRO_XOUT_OFFSET);
                +
0002c4 e3e0     +LDI R30 , LOW ( 2 * _0x0 + ( 0 ) )
0002c5 e0f0     +LDI R31 , HIGH ( 2 * _0x0 + ( 0 ) )
                 	__POINTW1FN _0x0,0
0002c6 93fa      	ST   -Y,R31
0002c7 93ea      	ST   -Y,R30
0002c8 91e0 026c 	LDS  R30,_GYRO_XOUT_OFFSET
0002ca 91f0 026d 	LDS  R31,_GYRO_XOUT_OFFSET+1
0002cc dc23      	RCALL __CWD1
0002cd dcbf      	RCALL __PUTPARD1
0002ce e084      	LDI  R24,4
0002cf d5fb      	RCALL _printf
0002d0 9626      	ADIW R28,6
                 ; delay_ms(100);
0002d1 e6a4      	LDI  R26,LOW(100)
0002d2 e0b0      	LDI  R27,0
0002d3 d9ff      	RCALL _delay_ms
                 ; printf("Gyro_Y_Offset:%d#", GYRO_YOUT_OFFSET);
                +
0002d4 e4e2     +LDI R30 , LOW ( 2 * _0x0 + ( 18 ) )
0002d5 e0f0     +LDI R31 , HIGH ( 2 * _0x0 + ( 18 ) )
                 	__POINTW1FN _0x0,18
0002d6 93fa      	ST   -Y,R31
0002d7 93ea      	ST   -Y,R30
0002d8 91e0 026e 	LDS  R30,_GYRO_YOUT_OFFSET
0002da 91f0 026f 	LDS  R31,_GYRO_YOUT_OFFSET+1
0002dc dc13      	RCALL __CWD1
0002dd dcaf      	RCALL __PUTPARD1
0002de e084      	LDI  R24,4
0002df d5eb      	RCALL _printf
0002e0 9626      	ADIW R28,6
                 ; delay_ms(100);
0002e1 e6a4      	LDI  R26,LOW(100)
0002e2 e0b0      	LDI  R27,0
0002e3 d9ef      	RCALL _delay_ms
                 ; printf("Gyro_Z_Offset:%d#", GYRO_ZOUT_OFFSET);
                +
0002e4 e5e4     +LDI R30 , LOW ( 2 * _0x0 + ( 36 ) )
0002e5 e0f0     +LDI R31 , HIGH ( 2 * _0x0 + ( 36 ) )
                 	__POINTW1FN _0x0,36
0002e6 93fa      	ST   -Y,R31
0002e7 93ea      	ST   -Y,R30
0002e8 91e0 0270 	LDS  R30,_GYRO_ZOUT_OFFSET
0002ea 91f0 0271 	LDS  R31,_GYRO_ZOUT_OFFSET+1
0002ec dc03      	RCALL __CWD1
0002ed dc9f      	RCALL __PUTPARD1
0002ee e084      	LDI  R24,4
0002ef d5db      	RCALL _printf
0002f0 9626      	ADIW R28,6
                 ; delay_ms(100);
0002f1 e6a4      	LDI  R26,LOW(100)
0002f2 e0b0      	LDI  R27,0
0002f3 d9df      	RCALL _delay_ms
                 ;
                 ;}
0002f4 dcc5      	RCALL __LOADLOCR6
0002f5 9626      	ADIW R28,6
0002f6 9508      	RET
                 ;void  MPU_Config_DLPF()
                 ;{
                 ;    PcDbg("StartConfig...");
                 ;    fi2c_write(MPU_ADDRESS,MPU6050_RA_SMPLRT_DIV,0x01);          // Set Sample Rate to 1KHz ( DLPF Enabled; 1khz/1+1 = 500hz ) P[12[
                 ;    PcDbg("SampleRate Configed!");
                 ;    fi2c_write(MPU_ADDRESS,MPU6050_RA_CONFIG, 0x03);           // Set Fsync Disabled And DLPF Disabled  , See Register Map P[13]
                 ;    PcDbg("Fsync,DLPF Configed!");
                 ;    fi2c_write(MPU_ADDRESS,MPU6050_RA_GYRO_CONFIG, 0b00001000);       // Set Gyro to 500 LSB/S     (FS_SEL = 1)
                 ;    PcDbg("Gyro Configed!");
                 ;    fi2c_write(MPU_ADDRESS, MPU6050_RA_ACCEL_CONFIG, 0b00001000);     // Set Accel to +-4g         (AFS_SEL = 1)
                 ;    PcDbg("Accel Configed!");
                 ;    fi2c_write(MPU_ADDRESS,MPU6050_RA_PWR_MGMT_1,0x00);               //Clock select and sleep off   Clock is set to internal oscillator
                 ;}
                 ;
                 ;void  MPU_config(char dbgmpu)
                 ;{
                 _MPU_config:
                 ;    char data = 0;
                 ;    fi2c_write(MPU_ADDRESS,MPU6050_RA_SMPLRT_DIV,0x07);
0002f7 93aa      	ST   -Y,R26
0002f8 931a      	ST   -Y,R17
                 ;	dbgmpu -> Y+1
                 ;	data -> R17
0002f9 e010      	LDI  R17,0
0002fa ede0      	LDI  R30,LOW(208)
0002fb 93ea      	ST   -Y,R30
0002fc e1e9      	LDI  R30,LOW(25)
0002fd 93ea      	ST   -Y,R30
0002fe e0a7      	LDI  R26,LOW(7)
0002ff d032      	RCALL _fi2c_write
                 ;    //fi2c_write(MPU_ADDRESS,MPU6050_RA_SMPLRT_DIV,0x07);        // Set Sample Rate to 1KHz ( DLPF Disabled ; 8khz/1+7 = 1khz ) P[12[
                 ;    PcDbg("SampleRate Configed!");
          