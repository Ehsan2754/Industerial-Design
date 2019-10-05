4e8      	CLT
001bfb ffa7      	SBRS R26,7
001bfc c002      	RJMP __MODB211
001bfd 95a1      	NEG  R26
001bfe 9468      	SET
                 __MODB211:
001bff fde7      	SBRC R30,7
001c00 95e1      	NEG  R30
001c01 dfad      	RCALL __DIVB21U
001c02 2fea      	MOV  R30,R26
001c03 f40e      	BRTC __MODB212
001c04 95e1      	NEG  R30
                 __MODB212:
001c05 9508      	RET
                 
                 __MODD21U:
001c06 dfce      	RCALL __DIVD21U
001c07 01fd      	MOVW R30,R26
001c08 01bc      	MOVW R22,R24
001c09 9508      	RET
                 
                 __CHKSIGNB:
001c0a 94e8      	CLT
001c0b ffe7      	SBRS R30,7
001c0c c002      	RJMP __CHKSB1
001c0d 95e1      	NEG  R30
001c0e 9468      	SET
                 __CHKSB1:
001c0f ffa7      	SBRS R26,7
001c10 c004      	RJMP __CHKSB2
001c11 95a1      	NEG  R26
001c12 f800      	BLD  R0,0
001c13 9403      	INC  R0
001c14 fa00      	BST  R0,0
                 __CHKSB2:
001c15 9508      	RET
                 
                 __CHKSIGNW:
001c16 94e8      	CLT
001c17 fff7      	SBRS R31,7
001c18 c002      	RJMP __CHKSW1
001c19 df62      	RCALL __ANEGW1
001c1a 9468      	SET
                 __CHKSW1:
001c1b ffb7      	SBRS R27,7
001c1c c006      	RJMP __CHKSW2
001c1d 95a0      	COM  R26
001c1e 95b0      	COM  R27
001c1f 9611      	ADIW R26,1
001c20 f800      	BLD  R0,0
001c21 9403      	INC  R0
001c22 fa00      	BST  R0,0
                 __CHKSW2:
001c23 9508      	RET
                 
                 __GETW1P:
001c24 91ed      	LD   R30,X+
001c25 91fc      	LD   R31,X
001c26 9711      	SBIW R26,1
001c27 9508      	RET
                 
                 __GETD1P:
001c28 91ed      	LD   R30,X+
001c29 91fd      	LD   R31,X+
001c2a 916d      	LD   R22,X+
001c2b 917c      	LD   R23,X
001c2c 9713      	SBIW R26,3
001c2d 9508      	RET
                 
                 __PUTDP1:
001c2e 93ed      	ST   X+,R30
001c2f 93fd      	ST   X+,R31
001c30 936d      	ST   X+,R22
001c31 937c      	ST   X,R23
001c32 9508      	RET
                 
                 __GETD1S0:
001c33 81e8      	LD   R30,Y
001c34 81f9      	LDD  R31,Y+1
001c35 816a      	LDD  R22,Y+2
001c36 817b      	LDD  R23,Y+3
001c37 9508      	RET
                 
                 __GETD2S0:
001c38 81a8      	LD   R26,Y
001c39 81b9      	LDD  R27,Y+1
001c3a 818a      	LDD  R24,Y+2
001c3b 819b      	LDD  R25,Y+3
001c3c 9508      	RET
                 
                 __PUTD1S0:
001c3d 83e8      	ST   Y,R30
001c3e 83f9      	STD  Y+1,R31
001c3f 836a      	STD  Y+2,R22
001c40 837b      	STD  Y+3,R23
001c41 9508      	RET
                 
                 __PUTPARD1L:
001c42 e060      	LDI  R22,0
001c43 e070      	LDI  R23,0
                 __PUTPARD1:
001c44 937a      	ST   -Y,R23
001c45 936a      	ST   -Y,R22
001c46 93fa      	ST   -Y,R31
001c47 93ea      	ST   -Y,R30
001c48 9508      	RET
                 
                 __PUTPARD2:
001c49 939a      	ST   -Y,R25
001c4a 938a      	ST   -Y,R24
001c4b 93ba      	ST   -Y,R27
001c4c 93aa      	ST   -Y,R26
001c4d 9508      	RET
                 
                 __CDF2U:
001c4e 9468      	SET
001c4f c001      	RJMP __CDF2U0
                 __CDF2:
001c50 94e8      	CLT
                 __CDF2U0:
001c51 d001      	RCALL __SWAPD12
001c52 ddb2      	RCALL __CDF1U0
                 
                 __SWAPD12:
001c53 2e18      	MOV  R1,R24
001c54 2f86      	MOV  R24,R22
001c55 2d61      	MOV  R22,R1
001c56 2e19      	MOV  R1,R25
001c57 2f97      	MOV  R25,R23
001c58 2d71      	MOV  R23,R1
                 
                 __SWAPW12:
001c59 2e1b      	MOV  R1,R27
001c5a 2fbf      	MOV  R27,R31
001c5b 2df1      	MOV  R31,R1
                 
                 __SWAPB12:
001c5c 2e1a      	MOV  R1,R26
001c5d 2fae      	MOV  R26,R30
001c5e 2de1      	MOV  R30,R1
001c5f 9508      	RET
                 
                 __CPD10:
001c60 9730      	SBIW R30,0
001c61 4060      	SBCI R22,0
001c62 4070      	SBCI R23,0
001c63 9508      	RET
                 
                 __CPD02:
001c64 2400      	CLR  R0
001c65 160a      	CP   R0,R26
001c66 060b      	CPC  R0,R27
001c67 0608      	CPC  R0,R24
001c68 0609      	CPC  R0,R25
001c69 9508      	RET
                 
                 __CPD12:
001c6a 17ea      	CP   R30,R26
001c6b 07fb      	CPC  R31,R27
001c6c 0768      	CPC  R22,R24
001c6d 0779      	CPC  R23,R25
001c6e 9508      	RET
                 
                 __SAVELOCR6:
001c6f 935a      	ST   -Y,R21
                 __SAVELOCR5:
001c70 934a      	ST   -Y,R20
                 __SAVELOCR4:
001c71 933a      	ST   -Y,R19
                 __SAVELOCR3:
001c72 932a      	ST   -Y,R18
                 __SAVELOCR2:
001c73 931a      	ST   -Y,R17
001c74 930a      	ST   -Y,R16
001c75 9508      	RET
                 
                 __LOADLOCR6:
001c76 815d      	LDD  R21,Y+5
                 __LOADLOCR5:
001c77 814c      	LDD  R20,Y+4
                 __LOADLOCR4:
001c78 813b      	LDD  R19,Y+3
                 __LOADLOCR3:
001c79 812a      	LDD  R18,Y+2
                 __LOADLOCR2:
001c7a 8119      	LDD  R17,Y+1
001c7b 8108      	LD   R16,Y
001c7c 9508      	RET
                 
                 ;END OF CODE MARKER
                 __END_OF_CODE:


RESOURCE USE INFORMATION
------------------------

Notice:
The register and instruction counts are symbol table hit counts,
and hence implicitly used resources are not counted, eg, the
'lpm' instruction without operands implicitly uses r0 and z,
none of which are counted.

x,y,z are separate entities in the symbol table and are
counted separately from r26..r31 here.

.dseg memory usage only counts static data declared with .byte

ATmega64A register use summary:
r0 :  92 r1 :  52 r2 :  20 r3 :  16 r4 :   2 r5 :   2 r6 :   2 r7 :   1 
r8 :   2 r9 :   1 r10:   0 r11:   0 r12:   0 r13:   0 r14:   0 r15:  11 
r16: 121 r17: 140 r18:  94 r19:  86 r20:  79 r21: 108 r22: 223 r23: 204 
r24: 152 r25: 119 r26: 473 r27: 249 r28:  76 r29:   1 r30:1203 r31: 437 
x  :  61 y  : 768 z  :  32 
Registers used: 30 out of 35 (85.7%)

ATmega64A instruction use summary:
.lds  :   0 .lds.l:   0 .sts  :   0 .sts.l:   0 adc   :  28 add   :  25 
adiw  :  68 and   :   5 andi  :  28 asr   :   0 bclr  :   0 bld   :  30 
brbc  :   0 brbs  :   0 brcc  :  19 brcs  :   7 break :   0 breq  :  96 
brge  :   9 brhc  :   0 brhs  :   0 brid  :   0 brie  :   0 brlo  :  36 
brlt  :   5 brmi  :  11 brne  : 150 brpl  :  15 brsh  :  21 brtc  :   5 
brts  :   3 brvc  :   4 brvs  :   4 bset  :   0 bst   :   6 call  : 689 
cbi   :  25 cbr   :   2 clc   :   4 clh   :   0 cli   :   1 cln   :   0 
clr   :  66 cls   :   0 clt   :  18 clv   :   0 clz   :   2 com   :  12 
cp    :  33 cpc   :  28 cpi   : 188 cpse  :   0 dec   :  19 des   :   0 
eor   :   8 fmul  :   0 fmuls :   0 fmulsu:   0 icall :   8 ijmp  :   0 
in    :  50 inc   :   4 jmp   :  59 ld    : 126 ldd   : 298 ldi   : 779 
lds   : 218 lpm   :  19 lsl   :  21 lsr   :   7 mov   : 133 movw  : 108 
mul   :  15 muls  :   0 mulsu :   0 neg   :  11 nop   :   1 or    :   2 
ori   :  27 out   :  64 pop   : 102 push  : 102 rcall : 137 ret   : 187 
reti  :   4 rjmp  : 304 rol   :  40 ror   :  17 sbc   :  14 sbci  :  25 
sbi   :  26 sbic  :   3 sbis  :   8 sbiw  :  64 sbr   :   5 sbrc  :   6 
sbrs  :  31 sec   :   6 seh   :   0 sei   :   2 sen   :   0 ser   :   9 
ses   :   0 set   :  22 sev   :   0 sez   :   1 sleep :   0 spm   :   0 
st    : 286 std   : 135 sts   : 182 sub   :   9 subi  :  73 swap  :   0 
tst   :  33 wdr   :   1 
Instructions used: 83 out of 116 (71.6%)

ATmega64A memory use summary [bytes]:
Segment   Begin    End      Code   Data   Used    Size   Use%
---------------------------------------------------------------
[.cseg] 0x000000 0x0038fa  13198   1388  14586   65536  22.3%
[.dseg] 0x000100 0x00060d      0    269    269    4351   6.2%
[.eseg] 0x000000 0x000000      0      0      0    2048   0.0%

Assembly complete, 0 errors, 12 warnings
                                        	__POINTW2FN _0x0,361
000464 dfd3      	RCALL _PcDbg
                 ; 0000 016E  //MPU_Config_DLPF();
                 ; 0000 016F   MPU_config(TRUE);
000465 e0a1      	LDI  R26,LOW(1)
000466 de90      	RCALL _MPU_config
                 ; 0000 0170 // if(MPU_config()==TRUE)
                 ; 0000 0171 //  {//MPU_config success
                 ; 0000 0172 //  PcDbg("Mpu Config is OK!");
                 ; 0000 0173 //  }
                 ; 0000 0174 // else
                 ; 0000 0175 //  {//MPU_Config fail
                 ; 0000 0176 //  DebugMpuConfig();
                 ; 0000 0177 //  }
                 ; 0000 0178  PcDbg("CalibrateGyro...");
                +
000467 eaa5     +LDI R26 , LOW ( 2 * _0x0 + ( 373 ) )
000468 e0b1     +LDI R27 , HIGH ( 2 * _0x0 + ( 373 ) )
                 	__POINTW2FN _0x0,373
000469 dfce      	RCALL _PcDbg
                 ; 0000 0179  GyroCalibrate();
00046a de0c      	RCALL _GyroCalibrate
                 ; 0000 017A  #asm("sei")
00046b 9478      	sei
                 ; 0000 017B  while(1)
                 _0x23:
                 ; 0000 017C  {
                 ; 0000 017D  delay_ms(1);
00046c e0a1      	LDI  R26,LOW(1)
00046d e0b0      	LDI  R27,0
00046e d864      	RCALL _delay_ms
                 ; 0000 017E  if(EnterKey == 0)break;
00046f 9b9a      	SBIS 0x13,2
000470 c001      	RJMP _0x25
                 ; 0000 017F  }
000471 cffa      	RJMP _0x23
                 _0x25:
                 ; 0000 0180  // Global enable interrupts
                 ; 0000 0181 
                 ; 0000 0182 while (1)
                 _0x27:
                 ; 0000 0183       {
                 ; 0000 0184 
                 ; 0000 0185       //*delay_ms(1);
                 ; 0000 0186 
                 ; 0000 0187        //printf("Xout:%d#",ACCEL_XOUT);
                 ; 0000 0188        printf("XAngle:%.1f#",ACCEL_XANGLE);
                +
000472 ebe6     +LDI R30 , LOW ( 2 * _0x0 + ( 390 ) )
000473 e0f1     +LDI R31 , HIGH ( 2 * _0x0 + ( 390 ) )
                 	__POINTW1FN _0x0,390
000474 93fa      	ST   -Y,R31
000475 93ea      	ST   -Y,R30
000476 91e0 027e 	LDS  R30,_ACCEL_XANGLE
000478 91f0 027f 	LDS  R31,_ACCEL_XANGLE+1
00047a 9160 0280 	LDS  R22,_ACCEL_XANGLE+2
00047c 9170 0281 	LDS  R23,_ACCEL_XANGLE+3
00047e db0e      	RCALL __PUTPARD1
00047f e084      	LDI  R24,4
000480 d44a      	RCALL _printf
000481 9626      	ADIW R28,6
                 ; 0000 0189        delay_ms(10);
000482 e0aa      	LDI  R26,LOW(10)
000483 e0b0      	LDI  R27,0
000484 d84e      	RCALL _delay_ms
                 ; 0000 018A        printf("YAngle:%.1f#",ACCEL_YANGLE);
                +
000485 ece3     +LDI R30 , LOW ( 2 * _0x0 + ( 403 ) )
000486 e0f1     +LDI R31 , HIGH ( 2 * _0x0 + ( 403 ) )
                 	__POINTW1FN _0x0,403
000487 93fa      	ST   -Y,R31
000488 93ea      	ST   -Y,R30
000489 91e0 0282 	LDS  R30,_ACCEL_YANGLE
00048b 91f0 0283 	LDS  R31,_ACCEL_YANGLE+1
00048d 9160 0284 	LDS  R22,_ACCEL_YANGLE+2
00048f 9170 0285 	LDS  R23,_ACCEL_YANGLE+3
000491 dafb      	RCALL __PUTPARD1
000492 e084      	LDI  R24,4
000493 d437      	RCALL _printf
000494 9626      	ADIW R28,6
                 ; 0000 018B        //printf("GXout:%d#",GYRO_XOUT);
                 ; 0000 018C //      printf("Yout:%d#",accel_read('y'));
                 ; 0000 018D //      printf("Zout:%d#",accel_read('z'));
                 ; 0000 018E      // printf("G_Xout:%d#",GyroRate('x'));
                 ; 0000 018F       //printf("G_Yout:%f#",GyroRate('y'));
                 ; 0000 0190       //SendDataNF(buffer);
                 ; 0000 0191       //printf("G_Zout:%d#",gyro_read('z'));
                 ; 0000 0192       // SendDataNF(Temp);
                 ; 0000 0193       delay_ms(10);
000495 e0aa      	LDI  R26,LOW(10)
000496 e0b0      	LDI  R27,0
000497 d83b      	RCALL _delay_ms
                 ; 0000 0194       }
000498 cfd9      	RJMP _0x27
                 ; 0000 0195 }
                 _0x2A:
000499 cfff      	RJMP _0x2A
                 	#ifndef __SLEEP_DEFINED__
                 	#endif
                 
                 	.CSEG
                 _putchar:
00049a 93aa      	ST   -Y,R26
                 putchar0:
00049b 9b5d           sbis usr,udre
00049c cffe           rjmp putchar0
00049d 81e8           ld   r30,y
00049e b9ec           out  udr,r30
00049f 9621      	ADIW R28,1
0004a0 9508      	RET
                 _put_usart_G100:
0004a1 93ba      	ST   -Y,R27
0004a2 93aa      	ST   -Y,R26
0004a3 81aa      	LDD  R26,Y+2
0004a4 dff5      	RCALL _putchar
0004a5 81a8      	LD   R26,Y
0004a6 81b9      	LDD  R27,Y+1
0004a7 91ed      	LD   R30,X+
0004a8 91fd      	LD   R31,X+
0004a9 9631      	ADIW R30,1
0004aa 93fe      	ST   -X,R31
0004ab 93ee      	ST   -X,R30
                 _0x20A0008:
0004ac 9623      	ADIW R28,3
0004ad 9508      	RET
                 __ftoe_G100:
0004ae 93ba      	ST   -Y,R27
0004af 93aa      	ST   -Y,R26
0004b0 9724      	SBIW R28,4
0004b1 e0e0      	LDI  R30,LOW(0)
0004b2 83e8      	ST   Y,R30
0004b3 83e9      	STD  Y+1,R30
0004b4 e8e0      	LDI  R30,LOW(128)
0004b5 83ea      	STD  Y+2,R30
0004b6 e3ef      	LDI  R30,LOW(63)
0004b7 83eb      	STD  Y+3,R30
0004b8 dafc      	RCALL __SAVELOCR4
0004b9 85ee      	LDD  R30,Y+14
0004ba 85ff      	LDD  R31,Y+14+1
0004bb 3fef      	CPI  R30,LOW(0xFFFF)
0004bc efaf      	LDI  R26,HIGH(0xFFFF)
0004bd 07fa      	CPC  R31,R26
0004be f441      	BRNE _0x2000019
0004bf 85e8      	LDD  R30,Y+8
0004c0 85f9      	LDD  R31,Y+8+1
0004c1 93fa      	ST   -Y,R31
0004c2 93ea      	ST   -Y,R30
                +
0004c3 eda0     +LDI R26 , LOW ( 2 * _0x2000000 + ( 0 ) )
0004c4 e0b1     +LDI R27 , HIGH ( 2 * _0x2000000 + ( 0 ) )
                 	__POINTW2FN _0x2000000,0
0004c5 d425      	RCALL _strcpyf
0004c6 c12c      	RJMP _0x20A0007
                 _0x2000019:
0004c7 3fef      	CPI  R30,LOW(0x7FFF)
0004c8 e7af      	LDI  R26,HIGH(0x7FFF)
0004c9 07fa      	CPC  R31,R26
0004ca f441      	BRNE _0x2000018
0004cb 85e8      	LDD  R30,Y+8
0004cc 85f9      	LDD  R31,Y+8+1
0004cd 93fa      	ST   -Y,R31
0004ce 93ea      	ST   -Y,R30
                +
0004cf eda1     +LDI R26 , LOW ( 2 * _0x2000000 + ( 1 ) )
0004d0 e0b1     +LDI R27 , HIGH ( 2 * _0x2000000 + ( 1 ) )
                 	__POINTW2FN _0x2000000,1
0004d1 d419      	RCALL _strcpyf
0004d2 c120      	RJMP _0x20A0007
                 _0x2000018:
0004d3 85ab      	LDD  R26,Y+11
0004d4 30a7      	CPI  R26,LOW(0x7)
0004d5 f010      	BRLO _0x200001B
0004d6 e0e6      	LDI  R30,LOW(6)
0004d7 87eb      	STD  Y+11,R30
                 _0x200001B:
0004d8 851b      	LDD  R17,Y+11
                 _0x200001C:
0004d9 2fe1      	MOV  R30,R17
0004da 5011      	SUBI R17,1
0004db 30e0      	CPI  R30,0
0004dc f071      	BREQ _0x200001E
                +
0004dd 81ac     +LDD R26 , Y + 4
0004de 81bd     +LDD R27 , Y + 4 + 1
0004df 818e     +LDD R24 , Y + 4 + 2
0004e0 819f     +LDD R25 , Y + 4 + 3
                 	__GETD2S 4
                +
0004e1 e0e0     +LDI R30 , LOW ( 0x41200000 )
0004e2 e0f0     +LDI R31 , HIGH ( 0x41200000 )
0004e3 e260     +LDI R22 , BYTE3 ( 0x41200000 )
0004e4 e471     +LDI R23 , BYTE4 ( 0x41200000 )
                 	__GETD1N 0x41200000
0004e5 d90a      	RCALL __MULF12
                +
0004e6 83ec     +STD Y + 4 , R30
0004e7 83fd     +STD Y + 4 + 1 , R31
0004e8 836e     +STD Y + 4 + 2 , R22
0004e9 837f     +STD Y + 4 + 3 , R23
                 	__PUTD1S 4
0004ea cfee      	RJMP _0x200001C
                 _0x200001E:
                +
0004eb 85ec     +LDD R30 , Y + 12
0004ec 85fd     +LDD R31 , Y + 12 + 1
0004ed 856e     +LDD R22 , Y + 12 + 2
0004ee 857f     +LDD R23 , Y + 12 + 3
                 	__GETD1S 12
0004ef dab4      	RCALL __CPD10
0004f0 f479      	BRNE _0x200001F
0004f1 e030      	LDI  R19,LOW(0)
                +
0004f2 81ac     +LDD R26 , Y + 4
0004f3 81bd     +LDD R27 , Y + 4 + 1
0004f4 818e     +LDD R24 , Y + 4 + 2
0004f5 819f     +LDD R25 , Y + 4 + 3
                 	__GETD2S 4
                +
0004f6 e0e0     +LDI R30 , LOW ( 0x41200000 )
0004f7 e0f0     +LDI R31 , HIGH ( 0x41200000 )
0004f8 e260     +LDI R22 , BYTE3 ( 0x41200000 )
0004f9 e471     +LDI R23 , BYTE4 ( 0x41200000 )
                 	__GETD1N 0x41200000
0004fa d8f5      	RCALL __MULF12
                +
0004fb 83ec     +STD Y + 4 , R30
0004fc 83fd     +STD Y + 4 + 1 , R31
0004fd 836e     +STD Y + 4 + 2 , R22
0004fe 837f     +STD Y + 4 + 3 , R23
                 	__PUTD1S 4
0004ff c073      	RJMP _0x2000020
                 _0x200001F:
000500 853b      	LDD  R19,Y+11
                +
000501 81ec     +LDD R30 , Y + 4
000502 81fd     +LDD R31 , Y + 4 + 1
000503 816e     +LDD R22 , Y + 4 + 2
000504 817f     +LDD R23 , Y + 4 + 3
                 	__GETD1S 4
                +
000505 85ac     +LDD R26 , Y + 12
000506 85bd     +LDD R27 , Y + 12 + 1
000507 858e     +LDD R24 , Y + 12 + 2
000508 859f     +LDD R25 , Y + 12 + 3
                 	__GETD2S 12
000509 d979      	RCALL __CMPF12
00050a f009      	BREQ PC+2
00050b f408      	BRCC PC+2
00050c c023      	RJMP _0x2000021
                +
00050d 81ac     +LDD R26 , Y + 4
00050e 81bd     +LDD R27 , Y + 4 + 1
00050f 818e     +LDD R24 , Y + 4 + 2
000510 819f     +LDD R25 , Y + 4 + 3
                 	__GETD2S 4
                +
000511 e0e0     +LDI R30 , LOW ( 0x41200000 )
000512 e0f0     +LDI R31 , HIGH ( 0x41200000 )
000513 e260     +LDI R22 , BYTE3 ( 0x41200000 )
000514 e471     +LDI R23 , BYTE4 ( 0x41200000 )
                 	__GETD1N 0x41200000
000515 d8da      	RCALL __MULF12
                +
000516 83ec     +STD Y + 4 , R30
000517 83fd     +STD Y + 4 + 1 , R31
000518 836e     +STD Y + 4 + 2 , R22
000519 837f     +STD Y + 4 + 3 , R23
                 	__PUTD1S 4
                 _0x2000022:
                +
00051a 81ec     +LDD R30 , Y + 4
00051b 81fd     +LDD R31 , Y + 4 + 1
00051c 816e     +LDD R22 , Y + 4 + 2
00051d 817f     +LDD R23 , Y + 4 + 3
                 	__GETD1S 4
                +
00051e 85ac     +LDD R26 , Y + 12
00051f 85bd     +LDD R27 , Y + 12 + 1
000520 858e     +LDD R24 , Y + 12 + 2
000521 859f     +LDD R25 , Y + 12 + 3
                 	__GETD2S 12
000522 d960      	RCALL __CMPF12
000523 f058      	BRLO _0x2000024
                +
000524 eced     +LDI R30 , LOW ( 0x3DCCCCCD )
000525 ecfc     +LDI R31 , HIGH ( 0x3DCCCCCD )
000526 ec6c     +LDI R22 , BYTE3 ( 0x3DCCCCCD )
000527 e37d     +LDI R23 , BYTE4 ( 0x3DCCCCCD )
                 	__GETD1N 0x3DCCCCCD
000528 d8c7      	RCALL __MULF12
                +
000529 87ec     +STD Y + 12 , R30
00052a 87fd     +STD Y + 12 + 1 , R31
00052b 876e     +STD Y + 12 + 2 , R22
00052c 877f     +STD Y + 12 + 3 , R23
                 	__PUTD1S 12
00052d 5f3f      	SUBI R19,-LOW(1)
00052e cfeb      	RJMP _0x2000022
                 _0x2000024:
00052f c022      	RJMP _0x2000025
                 _0x2000021:
                 _0x2000026:
                +
000530 81ec     +LDD R30 , Y + 4
000531 81fd     +LDD R31 , Y + 4 + 1
000532 816e     +LDD R22 , Y + 4 + 2
000533 817f     +LDD R23 , Y + 4 + 3
                 	__GETD1S 4
                +
000534 85ac     +LDD R26 , Y + 12
000535 85bd     +LDD R27 , Y + 12 + 1
000536 858e     +LDD R24 , Y + 12 + 2
000537 859f     +LDD R25 , Y + 12 + 3
                 	__GETD2S 12
000538 d94a      	RCALL __CMPF12
000539 f458      	BRSH _0x2000028
                +
00053a e0e0     +LDI R30 , LOW ( 0x41200000 )
00053b e0f0     +LDI R31 , HIGH ( 0x41200000 )
00053c e260     +LDI R22 , BYTE3 ( 0x41200000 )
00053d e471     +LDI R23 , BYTE4 ( 0x41200000 )
                 	__GETD1N 0x41200000
00053e d8b1      	RCALL __MULF12
                +
00053f 87ec     +STD Y + 12 , R30
000540 87fd     +STD Y + 12 + 1 , R31
000541 876e     +STD Y + 12 + 2 , R22
000542 877f     +STD Y + 12 + 3 , R23
                 	__PUTD1S 12
000543 5031      	SUBI R19,LOW(1)
000544 cfeb      	RJMP _0x2000026
                 _0x2000028:
                +
000545 81ac     +LDD R26 , Y + 4
000546 81bd     +LDD R27 , Y + 4 + 1
000547 818e     +LDD R24 , Y + 4 + 2
000548 819f     +LDD R25 , Y + 4 + 3
                 	__GETD2S 4
                +
000549 e0e0     +LDI R30 , LOW ( 0x41200000 )
00054a e0f0     +LDI R31 , HIGH ( 0x41200000 )
00054b e260     +LDI R22 , BYTE3 ( 0x41200000 )
00054c e471     +LDI R23 , BYTE4 ( 0x41200000 )
                 	__GETD1N 0x41200000
00054d d8a2      	RCALL __MULF12
                +
00054e 83ec     +STD Y + 4 , R30
00054f 83fd     +STD Y + 4 + 1 , R31
000550 836e     +STD Y + 4 + 2 , R22
000551 837f     +STD Y + 4 + 3 , R23
                 	__PUTD1S 4
                 _0x2000025:
                +
000552 85ec     +LDD R30 , Y + 12
000553 85fd     +LDD R31 , Y + 12 + 1
000554 856e     +LDD R22 , Y + 12 + 2
000555 857f     +LDD R23 , Y + 12 + 3
                 	__GETD1S 12
                +
000556 e0a0     +LDI R26 , LOW ( 0x3F000000 )
000557 e0b0     +LDI R27 , HIGH ( 0x3F000000 )
000558 e080     +LDI R24 , BYTE3 ( 0x3F000000 )
000559 e39f     +LDI R25 , BYTE4 ( 0x3F000000 )
                 	__GETD2N 0x3F000000
00055a d845      	RCALL __ADDF12
                +
00055b 87ec     +STD Y + 12 , R30
00055c 87fd     +STD Y + 12 + 1 , R31
00055d 876e     +STD Y + 12 + 2 , R22
00055e 877f     +STD Y + 12 + 3 , R23
                 	__PUTD1S 12
                +
00055f 81ec     +LDD R30 , Y + 4
000560 81fd     +LDD R31 , Y + 4 + 1
000561 816e     +LDD R22 , Y + 4 + 2
000562 817f     +LDD R23 , Y + 4 + 3
                 	__GETD1S 4
                +
000563 85ac     +LDD R26 , Y + 12
000564 85bd     +LDD R27 , Y + 12 + 1
000565 858e     +LDD R24 , Y + 12 + 2
000566 859f     +LDD R25 , Y + 12 + 3
                 	__GETD2S 12
000567 d91b      	RCALL __CMPF12
000568 f050      	BRLO _0x2000029
                +
000569 eced     +LDI R30 , LOW ( 0x3DCCCCCD )
00056a ecfc     +LDI R31 , HIGH ( 0x3DCCCCCD )
00056b ec6c     +LDI R22 , BYTE3 ( 0x3DCCCCCD )
00056c e37d     +LDI R23 , BYTE4 ( 0x3DCCCCCD )
                 	__GETD1N 0x3DCCCCCD
00056d d882      	RCALL __MULF12
                +
00056e 87ec     +STD Y + 12 , R30
00056f 87fd     +STD Y + 12 + 1 , R31
000570 876e     +STD Y + 12 + 2 , R22
000571 877f     +STD Y + 12 + 3 , R23
                 	__PUTD1S 12
000572 5f3f      	SUBI R19,-LOW(1)
                 _0x2000029:
                 _0x2000020:
000573 e010      	LDI  R17,LOW(0)
                 _0x200002A:
000574 85eb      	LDD  R30,Y+11
000575 17e1      	CP   R30,R17
000576 f408      	BRSH PC+2
000577 c047      	RJMP _0x200002C
                +
000578 81ac     +LDD R26 , Y + 4
000579 81bd     +LDD R27 , Y + 4 + 1
00057a 818e     +LDD R24 , Y + 4 + 2
00057b 819f     +LDD R25 , Y + 4 + 3
                 	__GETD2S 4
                +
00057c eced     +LDI R30 , LOW ( 0x3DCCCCCD )
00057d ecfc     +LDI R31 , HIGH ( 0x3DCCCCCD )
00057e ec6c     +LDI R22 , BYTE3 ( 0x3DCCCCCD )
00057f e37d     +LDI R23 , BYTE4 ( 0x3DCCCCCD )
                 	__GETD1N 0x3DCCCCCD
000580 d86f      	RCALL __MULF12
                +
000581 e0a0     +LDI R26 , LOW ( 0x3F000000 )
000582 e0b0     +LDI R27 , HIGH ( 0x3F000000 )
000583 e080     +LDI R24 , BYTE3 ( 0x3F000000 )
000584 e39f     +LDI R25 , BYTE4 ( 0x3F000000 )
                 	__GETD2N 0x3F000000
000585 d81a      	RCALL __ADDF12
000586 01df      	MOVW R26,R30
000587 01cb      	MOVW R24,R22
000588 d3b8      	RCALL _floor
                +
000589 83ec     +STD Y + 4 , R30
00058a 83fd     +STD Y + 4 + 1 , R31
00058b 836e     +STD Y + 4 + 2 , R22
00058c 837f     +STD Y + 4 + 3 , R23
                 	__PUTD1S 4
                +
00058d 85ac     +LDD R26 , Y + 12
00058e 85bd     +LDD R27 , Y + 12 + 1
00058f 858e     +LDD R24 , Y + 12 + 2
000590 859f     +LDD R25 , Y + 12 + 3
                 	__GETD2S 12
000591 d8ac      	RCALL __DIVF21
000592 d79a      	RCALL __CFD1U
000593 2f0e      	MOV  R16,R30
000594 85a8      	LDD  R26,Y+8
000595 85b9      	LDD  R27,Y+8+1
000596 9611      	ADIW R26,1
000597 87a8      	STD  Y+8,R26
000598 87b9      	STD  Y+8+1,R27
000599 9711      	SBIW R26,1
00059a 2fe0      	MOV  R30,R16
00059b 5de0      	SUBI R30,-LOW(48)
00059c 93ec      	ST   X,R30
00059d 2fe0      	MOV  R30,R16
00059e 27ff      	CLR  R31
00059f 2766      	CLR  R22
0005a0 2777      	CLR  R23
0005a1 d7c4      	RCALL __CDF1
                +
0005a2 81ac     +LDD R26 , Y + 4
0005a3 81bd     +LDD R27 , Y + 4 + 1
0005a4 818e     +LDD R24 , Y + 4 + 2
0005a5 819f     +LDD R25 , Y + 4 + 3
                 	__GETD2S 4
0005a6 d849      	RCALL __MULF12
                +
0005a7 85ac     +LDD R26 , Y + 12
0005a8 85bd     +LDD R27 , Y + 12 + 1
0005a9 858e     +LDD R24 , Y + 12 + 2
0005aa 859f     +LDD R25 , Y + 12 + 3
                 	__GETD2S 12
0005ab d9eb      	RCALL __SWAPD12
0005ac d7ec      	RCALL __SUBF12
                +
0005ad 87ec     +STD Y + 12 , R30
0005ae 87fd     +STD Y + 12 + 1 , R31
0005af 876e     +STD Y + 12 + 2 , R22
0005b0 877f     +STD Y + 12 + 3 , R23
                 	__PUTD1S 12
0005b1 2fe1      	MOV  R30,R17
0005b2 5f1f      	SUBI R17,-1
0005b3 30e0      	CPI  R30,0
0005b4 f009      	BREQ _0x200002D
0005b5 cfbe      	RJMP _0x200002A
                 _0x200002D:
0005b6 85a8      	LDD  R26,Y+8
0005b7 85b9      	LDD  R27,Y+8+1
0005b8 9611      	ADIW R26,1
0005b9 87a8      	STD  Y+8,R26
0005ba 87b9      	STD  Y+8+1,R27
0005bb 9711      	SBIW R26,1
0005bc e2ee      	LDI  R30,LOW(46)
0005bd 93ec      	ST   X,R30
0005be cfb5      	RJMP _0x200002A
                 _0x200002C:
0005bf 85e8      	LDD  R30,Y+8
0005c0 85f9      	LDD  R31,Y+8+1
0005c1 9631      	ADIW R30,1
0005c2 87e8      	STD  Y+8,R30
0005c3 87f9      	STD  Y+8+1,R31
0005c4 9731      	SBIW R30,1
0005c5 85aa      	LDD  R26,Y+10
0005c6 83a0      	STD  Z+0,R26
0005c7 3030      	CPI  R19,0
0005c8 f42c      	BRGE _0x200002E
0005c9 9531      	NEG  R19
0005ca 85a8      	LDD  R26,Y+8
0005cb 85b9      	LDD  R27,Y+8+1
0005cc e2ed      	LDI  R30,LOW(45)
0005cd c003      	RJMP _0x200010E
                 _0x200002E:
0005ce 85a8      	LDD  R26,Y+8
0005cf 85b9      	LDD  R27,Y+8+1
0005d0 e2eb      	LDI  R30,LOW(43)
                 _0x200010E:
0005d1 93ec      	ST   X,R30
0005d2 85e8      	LDD  R30,Y+8
0005d3 85f9      	LDD  R31,Y+8+1
0005d4 9631      	ADIW R30,1
0005d5 87e8      	STD  Y+8,R30
0005d6 87f9      	STD  Y+8+1,R31
0005d7 9631      	ADIW R30,1
0005d8 87e8      	STD  Y+8,R30
0005d9 87f9      	STD  Y+8+1,R31
0005da 9731      	SBIW R30,1
0005db 01bf      	MOVW R22,R30
0005dc 2fa3      	MOV  R26,R19
0005dd e0ea      	LDI  R30,LOW(10)
0005de d924      	RCALL __DIVB21
0005df 5de0      	SUBI R30,-LOW(48)
0005e0 01db      	MOVW R26,R22
0005e1 93ec      	ST   X,R30
0005e2 85e8      	LDD  R30,Y+8
0005e3 85f9      	LDD  R31,Y+8+1
0005e4 9631      	ADIW R30,1
0005e5 87e8      	STD  Y+8,R30
0005e6 87f9      	STD  Y+8+1,R31
0005e7 9731      	SBIW R30,1
0005e8 01bf      	MOVW R22,R30
0005e9 2fa3      	MOV  R26,R19
0005ea e0ea      	LDI  R30,LOW(10)
0005eb d959      	RCALL __MODB21
0005ec 5de0      	SUBI R30,-LOW(48)
0005ed 01db      	MOVW R26,R22
0005ee 93ec      	ST   X,R30
0005ef 85a8      	LDD  R26,Y+8
0005f0 85b9      	LDD  R27,Y+8+1
0005f1 e0e0      	LDI  R30,LOW(0)
0005f2 93ec      	ST   X,R30
                 _0x20A0007:
0005f3 d9c8      	RCALL __LOADLOCR4
0005f4 9660      	ADIW R28,16
0005f5 9508      	RET
                 __print_G100:
0005f6 93ba      	ST   -Y,R27
0005f7 93aa      	ST   -Y,R26
0005f8 97ef      	SBIW R28,63
0005f9 9761      	SBIW R28,17
0005fa d9b8      	RCALL __SAVELOCR6
0005fb e010      	LDI  R17,0
                +
0005fc 01fe     +MOVW R30 , R28
0005fd 5ae8     +SUBI R30 , LOW ( - 88 )
0005fe 4fff     +SBCI R31 , HIGH ( - 88 )
0005ff 9001     +LD R0 , Z +
000600 81f0     +LD R31 , Z
000601 2de0     +MOV R30 , R0
                 	__GETW1SX 88
000602 87e8      	STD  Y+8,R30
000603 87f9      	STD  Y+8+1,R31
                +
000604 01fe     +MOVW R30 , R28
000605 5aea     +SUBI R30 , LOW ( - 86 )
000606 4fff     +SBCI R31 , HIGH ( - 86 )
000607 9001     +LD R0 , Z +
000608 81f0     +LD R31 , Z
000609 2de0     +MOV R30 , R0
                 	__GETW1SX 86
00060a 83ee      	STD  Y+6,R30
00060b 83ff      	STD  Y+6+1,R31
00060c 81ae      	LDD  R26,Y+6
00060d 81bf      	LDD  R27,Y+6+1
00060e e0e0      	LDI  R30,LOW(0)
00060f e0f0      	LDI  R31,HIGH(0)
000610 93ed      	ST   X+,R30
000611 93fc      	ST   X,R31
                 _0x2000030:
000612 01de      	MOVW R26,R28
000613 5aa4      	SUBI R26,LOW(-(92))
000614 4fbf      	SBCI R27,HIGH(-(92))
000615 91ed      	LD   R30,X+
000616 91fd      	LD   R31,X+
000617 9631      	ADIW R30,1
000618 93fe      	ST   -X,R31
000619 93ee      	ST   -X,R30
00061a 9731      	SBIW R30,1
00061b 91e4      	LPM  R30,Z
00061c 2f2e      	MOV  R18,R30
00061d 30e0      	CPI  R30,0
00061e f409      	BRNE PC+2
00061f c2a4      	RJMP _0x2000032
000620 2fe1      	MOV  R30,R17
000621 30e0      	CPI  R30,0
000622 f459      	BRNE _0x2000036
000623 3225      	CPI  R18,37
000624 f411      	BRNE _0x2000037
000625 e011      	LDI  R17,LOW(1)
000626 c006      	RJMP _0x2000038
                 _0x2000037:
000627 932a      	ST   -Y,R18
000628 81af      	LDD  R26,Y+7
000629 85b8      	LDD  R27,Y+7+1
00062a 85e9      	LDD  R30,Y+9
00062b 85fa      	LDD  R31,Y+9+1
00062c 9509      	ICALL
                 _0x2000038:
00062d c295      	RJMP _0x2000035
                 _0x2000036:
00062e 30e1      	CPI  R30,LOW(0x1)
00062f f4e1      	BRNE _0x2000039
000630 3225      	CPI  R18,37
000631 f439      	BRNE _0x200003A
000632 932a      	ST   -Y,R18
000633 81af      	LDD  R26,Y+7
000634 85b8      	LDD  R27,Y+7+1
000635 85e9      	LDD  R30,Y+9
000636 85fa      	LDD  R31,Y+9+1
000637 9509      	ICALL
000638 c289      	RJMP _0x200010F
                 _0x200003A:
000639 e012      	LDI  R17,LOW(2)
00063a e0e0      	LDI  R30,LOW(0)
00063b 8bed      	STD  Y+21,R30
00063c e000      	LDI  R16,LOW(0)
00063d 322d      	CPI  R18,45
00063e f411      	BRNE _0x200003B
00063f e001      	LDI  R16,LOW(1)
000640 c282      	RJMP _0x2000035
                 _0x200003B:
000641 322b      	CPI  R18,43
000642 f419      	BRNE _0x200003C
000643 e2eb      	LDI  R30,LOW(43)
000644 8bed      	STD  Y+21,R30
000645 c27d      	RJMP _0x2000035
                 _0x200003C:
000646 3220      	CPI  R18,32
000647 f419      	BRNE _0x200003D
000648 e2e0      	LDI  R30,LOW(32)
000649 8bed      	STD  Y+21,R30
00064a c278      	RJMP _0x2000035
                 _0x200003D:
00064b c002      	RJMP _0x200003E
                 _0x2000039:
00064c 30e2      	CPI  R30,LOW(0x2)
00064d f439      	BRNE _0x200003F
                 _0x200003E:
00064e e050      	LDI  R21,LOW(0)
00064f e013      	LDI  R17,LOW(3)
000650 3320      	CPI  R18,48
000651 f411      	BRNE _0x2000040
000652 6800      	ORI  R16,LOW(128)
000653 c26f      	RJMP _0x2000035
                 _0x2000040:
000654 c002      	RJMP _0x2000041
                 _0x200003F:
000655 30e3      	CPI  R30,LOW(0x3)
000656 f491      	BRNE _0x2000042
                 _0x2000041:
000657 3320      	CPI  R18,48
000658 f010      	BRLO _0x2000044
000659 332a      	CPI  R18,58
00065a f008      	BRLO _0x2000045
                 _0x2000044:
00065b c007      	RJMP _0x2000043
                 _0x2000045:
00065c e0aa      	LDI  R26,LOW(10)
00065d 9f5a      	MUL  R21,R26
00065e 2d50      	MOV  R21,R0
00065f 2fe2      	MOV  R30,R18
000660 53e0      	SUBI R30,LOW(48)
000661 0f5e      	ADD  R21,R30
000662 c260      	RJMP _0x2000035
                 _0x2000043:
000663 e040      	LDI  R20,LOW(0)
000664 322e      	CPI  R18,46
000665 f411      	BRNE _0x2000046
000666 e014      	LDI  R17,LOW(4)
000667 c25b      	RJMP _0x2000035
                 _0x2000046:
000668 c00f      	RJMP _0x2000047
                 _0x2000042:
000669 30e4      	CPI  R30,LOW(0x4)
00066a f499      	BRNE _0x2000049
00066b 3320      	CPI  R18,48
00066c f010      	BRLO _0x200004B
00066d 332a      	CPI  R18,58
00066e f008      	BRLO _0x200004C
                 _0x200004B:
00066f c008      	RJMP _0x200004A
                 _0x200004C:
000670 6200      	ORI  R16,LOW(32)
000671 e0aa      	LDI  R26,LOW(10)
000672 9f4a      	MUL  R20,R26
000673 2d40      	MOV  R20,R0
000674 2fe2      	MOV  R30,R18
000675 53e0      	SUBI R30,LOW(48)
000676 0f4e      	ADD  R20,R30
000677 c24b      	RJMP _0x2000035
                 _0x200004A:
                 _0x2000047:
000678 362c      	CPI  R18,108
000679 f419      	BRNE _0x200004D
00067a 6002      	ORI  R16,LOW(2)
00067b e015      	LDI  R17,LOW(5)
00067c c246      	RJMP _0x2000035
                 _0x200004D:
00067d c003      	RJMP _0x200004E
                 _0x2000049:
00067e 30e5      	CPI  R30,LOW(0x5)
00067f f009      	BREQ PC+2
000680 c242      	RJMP _0x2000035
                 _0x200004E:
000681 2fe2      	MOV  R30,R18
000682 36e3      	CPI  R30,LOW(0x63)
000683 f4a1      	BRNE _0x2000053
                +
000684 01fe     +MOVW R30 , R28
000685 5ae6     +SUBI R30 , LOW ( - 90 )
000686 4fff     +SBCI R31 , HIGH ( - 90 )
000687 9001     +LD R0 , Z +
000688 81f0     +LD R31 , Z
000689 2de0     +MOV R30 , R0
                 	__GETW1SX 90
00068a 9734      	SBIW R30,4
                +
00068b 01de     +MOVW R26 , R28
00068c 5aa6     +SUBI R26 , LOW ( - 90 )
00068d 4fbf     +SBCI R27 , HIGH ( - 90 )
00068e 93ed     +ST X + , R30
00068f 93fc     +ST X , R31
                 	__PUTW1SX 90
000690 81a4      	LDD  R26,Z+4
000691 93aa      	ST   -Y,R26
000692 81af      	LDD  R26,Y+7
000693 85b8      	LDD  R27,Y+7+1
000694 85e9      	LDD  R30,Y+9
000695 85fa      	LDD  R31,Y+9+1
000696 9509      	ICALL
000697 c22a      	RJMP _0x2000054
                 _0x2000053:
000698 34e5      	CPI  R30,LOW(0x45)
000699 f011      	BREQ _0x2000057
00069a 36e5      	CPI  R30,LOW(0x65)
00069b f409      	BRNE _0x2000058
                 _0x2000057:
00069c c003      	RJMP _0x2000059
                 _0x200