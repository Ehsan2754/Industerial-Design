ET
                 
                 ;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
                 SUBOPT_0x63:
00190e 81ae      	LDD  R26,Y+6
00190f 81bf      	LDD  R27,Y+6+1
001910 9611      	ADIW R26,1
001911 83ae      	STD  Y+6,R26
001912 83bf      	STD  Y+6+1,R27
001913 9711      	SBIW R26,1
001914 9508      	RET
                 
                 ;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
                 SUBOPT_0x64:
001915 dfc7      	RCALL SUBOPT_0x5A
                +
001916 85a9     +LDD R26 , Y + 9
001917 85ba     +LDD R27 , Y + 9 + 1
001918 858b     +LDD R24 , Y + 9 + 2
001919 859c     +LDD R25 , Y + 9 + 3
                 	__GETD2S 9
00191a 9508      	RET
                 
                 ;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
                 SUBOPT_0x65:
                +
00191b 85a9     +LDD R26 , Y + 9
00191c 85ba     +LDD R27 , Y + 9 + 1
00191d 858b     +LDD R24 , Y + 9 + 2
00191e 859c     +LDD R25 , Y + 9 + 3
                 	__GETD2S 9
00191f 9508      	RET
                 
                 
                 	.CSEG
                 	.equ __sda_bit=5
                 	.equ __scl_bit=4
                 	.equ __i2c_port=0x12 ;PORTD
                 	.equ __i2c_dir=__i2c_port-1
                 	.equ __i2c_pin=__i2c_port-2
                 
                 _i2c_init:
001920 9894      	cbi  __i2c_port,__scl_bit
001921 9895      	cbi  __i2c_port,__sda_bit
001922 9a8c      	sbi  __i2c_dir,__scl_bit
001923 988d      	cbi  __i2c_dir,__sda_bit
001924 c015      	rjmp __i2c_delay2
                 _i2c_start:
001925 988d      	cbi  __i2c_dir,__sda_bit
001926 988c      	cbi  __i2c_dir,__scl_bit
001927 27ee      	clr  r30
001928 0000      	nop
001929 9b85      	sbis __i2c_pin,__sda_bit
00192a 9508      	ret
00192b 9b84      	sbis __i2c_pin,__scl_bit
00192c 9508      	ret
00192d d004      	rcall __i2c_delay1
00192e 9a8d      	sbi  __i2c_dir,__sda_bit
00192f d002      	rcall __i2c_delay1
001930 9a8c      	sbi  __i2c_dir,__scl_bit
001931 e0e1      	ldi  r30,1
                 __i2c_delay1:
001932 e16b      	ldi  r22,27
001933 c007      	rjmp __i2c_delay2l
                 _i2c_stop:
001934 9a8d      	sbi  __i2c_dir,__sda_bit
001935 9a8c      	sbi  __i2c_dir,__scl_bit
001936 d003      	rcall __i2c_delay2
001937 988c      	cbi  __i2c_dir,__scl_bit
001938 dff9      	rcall __i2c_delay1
001939 988d      	cbi  __i2c_dir,__sda_bit
                 __i2c_delay2:
00193a e365      	ldi  r22,53
                 __i2c_delay2l:
00193b 956a      	dec  r22
00193c f7f1      	brne __i2c_delay2l
00193d 9508      	ret
                 _i2c_read:
00193e e078      	ldi  r23,8
                 __i2c_read0:
00193f 988c      	cbi  __i2c_dir,__scl_bit
001940 dff1      	rcall __i2c_delay1
                 __i2c_read3:
001941 9b84      	sbis __i2c_pin,__scl_bit
001942 cffe      	rjmp __i2c_read3
001943 dfee      	rcall __i2c_delay1
001944 9488      	clc
001945 9985      	sbic __i2c_pin,__sda_bit
001946 9408      	sec
001947 9a8c      	sbi  __i2c_dir,__scl_bit
001948 dff1      	rcall __i2c_delay2
001949 1fee      	rol  r30
00194a 957a      	dec  r23
00194b f799      	brne __i2c_read0
00194c 2f7a      	mov  r23,r26
00194d 2377      	tst  r23
00194e f411      	brne __i2c_read1
00194f 988d      	cbi  __i2c_dir,__sda_bit
001950 c001      	rjmp __i2c_read2
                 __i2c_read1:
001951 9a8d      	sbi  __i2c_dir,__sda_bit
                 __i2c_read2:
001952 dfdf      	rcall __i2c_delay1
001953 988c      	cbi  __i2c_dir,__scl_bit
001954 dfe5      	rcall __i2c_delay2
001955 9a8c      	sbi  __i2c_dir,__scl_bit
001956 dfdb      	rcall __i2c_delay1
001957 988d      	cbi  __i2c_dir,__sda_bit
001958 cfd9      	rjmp __i2c_delay1
                 
                 _i2c_write:
001959 e078      	ldi  r23,8
                 __i2c_write0:
00195a 0faa      	lsl  r26
00195b f410      	brcc __i2c_write1
00195c 988d      	cbi  __i2c_dir,__sda_bit
00195d c001      	rjmp __i2c_write2
                 __i2c_write1:
00195e 9a8d      	sbi  __i2c_dir,__sda_bit
                 __i2c_write2:
00195f dfda      	rcall __i2c_delay2
001960 988c      	cbi  __i2c_dir,__scl_bit
001961 dfd0      	rcall __i2c_delay1
                 __i2c_write3:
001962 9b84      	sbis __i2c_pin,__scl_bit
001963 cffe      	rjmp __i2c_write3
001964 dfcd      	rcall __i2c_delay1
001965 9a8c      	sbi  __i2c_dir,__scl_bit
001966 957a      	dec  r23
001967 f791      	brne __i2c_write0
001968 988d      	cbi  __i2c_dir,__sda_bit
001969 dfc8      	rcall __i2c_delay1
00196a 988c      	cbi  __i2c_dir,__scl_bit
00196b dfce      	rcall __i2c_delay2
00196c e0e1      	ldi  r30,1
00196d 9985      	sbic __i2c_pin,__sda_bit
00196e 27ee      	clr  r30
00196f 9a8c      	sbi  __i2c_dir,__scl_bit
001970 cfc1      	rjmp __i2c_delay1
                 
                 _delay_ms:
001971 9610      	adiw r26,0
001972 f039      	breq __delay_ms1
                 __delay_ms0:
                +
001973 ea80     +LDI R24 , LOW ( 0xFA0 )
001974 e09f     +LDI R25 , HIGH ( 0xFA0 )
                +__DELAY_USW_LOOP :
001975 9701     +SBIW R24 , 1
001976 f7f1     +BRNE __DELAY_USW_LOOP
                 	__DELAY_USW 0xFA0
001977 95a8      	wdr
001978 9711      	sbiw r26,1
001979 f7c9      	brne __delay_ms0
                 __delay_ms1:
00197a 9508      	ret
                 
                 _frexp:
00197b 91e9      	LD   R30,Y+
00197c 91f9      	LD   R31,Y+
00197d 9169      	LD   R22,Y+
00197e 9179      	LD   R23,Y+
00197f fb77      	BST  R23,7
001980 0f66      	LSL  R22
001981 1f77      	ROL  R23
001982 2788      	CLR  R24
001983 577e      	SUBI R23,0x7E
001984 0b88      	SBC  R24,R24
001985 937d      	ST   X+,R23
001986 938c      	ST   X,R24
001987 e77e      	LDI  R23,0x7E
001988 9576      	LSR  R23
001989 9567      	ROR  R22
00198a f06e      	BRTS __ANEGF1
00198b 9508      	RET
                 
                 _ldexp:
00198c 91e9      	LD   R30,Y+
00198d 91f9      	LD   R31,Y+
00198e 9169      	LD   R22,Y+
00198f 9179      	LD   R23,Y+
001990 fb77      	BST  R23,7
001991 0f66      	LSL  R22
001992 1f77      	ROL  R23
001993 0f7a      	ADD  R23,R26
001994 9576      	LSR  R23
001995 9567      	ROR  R22
001996 f00e      	BRTS __ANEGF1
001997 9508      	RET
                 
                 __ANEGF1:
001998 9730      	SBIW R30,0
001999 4060      	SBCI R22,0
00199a 4070      	SBCI R23,0
00199b f009      	BREQ __ANEGF10
00199c 5870      	SUBI R23,0x80
                 __ANEGF10:
00199d 9508      	RET
                 
                 __ROUND_REPACK:
00199e 2355      	TST  R21
00199f f442      	BRPL __REPACK
0019a0 3850      	CPI  R21,0x80
0019a1 f411      	BRNE __ROUND_REPACK0
0019a2 ffe0      	SBRS R30,0
0019a3 c004      	RJMP __REPACK
                 __ROUND_REPACK0:
0019a4 9631      	ADIW R30,1
0019a5 1f69      	ADC  R22,R25
0019a6 1f79      	ADC  R23,R25
0019a7 f06b      	BRVS __REPACK1
                 
                 __REPACK:
0019a8 e850      	LDI  R21,0x80
0019a9 2757      	EOR  R21,R23
0019aa f411      	BRNE __REPACK0
0019ab 935f      	PUSH R21
0019ac c0cf      	RJMP __ZERORES
                 __REPACK0:
0019ad 3f5f      	CPI  R21,0xFF
0019ae f031      	BREQ __REPACK1
0019af 0f66      	LSL  R22
0019b0 0c00      	LSL  R0
0019b1 9557      	ROR  R21
0019b2 9567      	ROR  R22
0019b3 2f75      	MOV  R23,R21
0019b4 9508      	RET
                 __REPACK1:
0019b5 935f      	PUSH R21
0019b6 2000      	TST  R0
0019b7 f00a      	BRMI __REPACK2
0019b8 c0cf      	RJMP __MAXRES
                 __REPACK2:
0019b9 c0c8      	RJMP __MINRES
                 
                 __UNPACK:
0019ba e850      	LDI  R21,0x80
0019bb 2e19      	MOV  R1,R25
0019bc 2215      	AND  R1,R21
0019bd 0f88      	LSL  R24
0019be 1f99      	ROL  R25
0019bf 2795      	EOR  R25,R21
0019c0 0f55      	LSL  R21
0019c1 9587      	ROR  R24
                 
                 __UNPACK1:
0019c2 e850      	LDI  R21,0x80
0019c3 2e07      	MOV  R0,R23
0019c4 2205      	AND  R0,R21
0019c5 0f66      	LSL  R22
0019c6 1f77      	ROL  R23
0019c7 2775      	EOR  R23,R21
0019c8 0f55      	LSL  R21
0019c9 9567      	ROR  R22
0019ca 9508      	RET
                 
                 __CFD1U:
0019cb 9468      	SET
0019cc c001      	RJMP __CFD1U0
                 __CFD1:
0019cd 94e8      	CLT
                 __CFD1U0:
0019ce 935f      	PUSH R21
0019cf dff2      	RCALL __UNPACK1
0019d0 3870      	CPI  R23,0x80
0019d1 f018      	BRLO __CFD10
0019d2 3f7f      	CPI  R23,0xFF
0019d3 f408      	BRCC __CFD10
0019d4 c0a7      	RJMP __ZERORES
                 __CFD10:
0019d5 e156      	LDI  R21,22
0019d6 1b57      	SUB  R21,R23
0019d7 f4aa      	BRPL __CFD11
0019d8 9551      	NEG  R21
0019d9 3058      	CPI  R21,8
0019da f40e      	BRTC __CFD19
0019db 3059      	CPI  R21,9
                 __CFD19:
0019dc f030      	BRLO __CFD17
0019dd efef      	SER  R30
0019de efff      	SER  R31
0019df ef6f      	SER  R22
0019e0 e77f      	LDI  R23,0x7F
0019e1 f977      	BLD  R23,7
0019e2 c01a      	RJMP __CFD15
                 __CFD17:
0019e3 2777      	CLR  R23
0019e4 2355      	TST  R21
0019e5 f0b9      	BREQ __CFD15
                 __CFD18:
0019e6 0fee      	LSL  R30
0019e7 1fff      	ROL  R31
0019e8 1f66      	ROL  R22
0019e9 1f77      	ROL  R23
0019ea 955a      	DEC  R21
0019eb f7d1      	BRNE __CFD18
0019ec c010      	RJMP __CFD15
                 __CFD11:
0019ed 2777      	CLR  R23
                 __CFD12:
0019ee 3058      	CPI  R21,8
0019ef f028      	BRLO __CFD13
0019f0 2fef      	MOV  R30,R31
0019f1 2ff6      	MOV  R31,R22
0019f2 2f67      	MOV  R22,R23
0019f3 5058      	SUBI R21,8
0019f4 cff9      	RJMP __CFD12
                 __CFD13:
0019f5 2355      	TST  R21
0019f6 f031      	BREQ __CFD15
                 __CFD14:
0019f7 9576      	LSR  R23
0019f8 9567      	ROR  R22
0019f9 95f7      	ROR  R31
0019fa 95e7      	ROR  R30
0019fb 955a      	DEC  R21
0019fc f7d1      	BRNE __CFD14
                 __CFD15:
0019fd 2000      	TST  R0
0019fe f40a      	BRPL __CFD16
0019ff d180      	RCALL __ANEGD1
                 __CFD16:
001a00 915f      	POP  R21
001a01 9508      	RET
                 
                 __CDF1U:
001a02 9468      	SET
001a03 c001      	RJMP __CDF1U0
                 __CDF1:
001a04 94e8      	CLT
                 __CDF1U0:
001a05 9730      	SBIW R30,0
001a06 4060      	SBCI R22,0
001a07 4070      	SBCI R23,0
001a08 f0b1      	BREQ __CDF10
001a09 2400      	CLR  R0
001a0a f026      	BRTS __CDF11
001a0b 2377      	TST  R23
001a0c f412      	BRPL __CDF11
001a0d 9400      	COM  R0
001a0e d171      	RCALL __ANEGD1
                 __CDF11:
001a0f 2e17      	MOV  R1,R23
001a10 e17e      	LDI  R23,30
001a11 2011      	TST  R1
                 __CDF12:
001a12 f032      	BRMI __CDF13
001a13 957a      	DEC  R23
001a14 0fee      	LSL  R30
001a15 1fff      	ROL  R31
001a16 1f66      	ROL  R22
001a17 1c11      	ROL  R1
001a18 cff9      	RJMP __CDF12
                 __CDF13:
001a19 2fef      	MOV  R30,R31
001a1a 2ff6      	MOV  R31,R22
001a1b 2d61      	MOV  R22,R1
001a1c 935f      	PUSH R21
001a1d df8a      	RCALL __REPACK
001a1e 915f      	POP  R21
                 __CDF10:
001a1f 9508      	RET
                 
                 __SWAPACC:
001a20 934f      	PUSH R20
001a21 01af      	MOVW R20,R30
001a22 01fd      	MOVW R30,R26
001a23 01da      	MOVW R26,R20
001a24 01ab      	MOVW R20,R22
001a25 01bc      	MOVW R22,R24
001a26 01ca      	MOVW R24,R20
001a27 2d40      	MOV  R20,R0
001a28 2c01      	MOV  R0,R1
001a29 2e14      	MOV  R1,R20
001a2a 914f      	POP  R20
001a2b 9508      	RET
                 
                 __UADD12:
001a2c 0fea      	ADD  R30,R26
001a2d 1ffb      	ADC  R31,R27
001a2e 1f68      	ADC  R22,R24
001a2f 9508      	RET
                 
                 __NEGMAN1:
001a30 95e0      	COM  R30
001a31 95f0      	COM  R31
001a32 9560      	COM  R22
001a33 5fef      	SUBI R30,-1
001a34 4fff      	SBCI R31,-1
001a35 4f6f      	SBCI R22,-1
001a36 9508      	RET
                 
                 __SUBF12:
001a37 935f      	PUSH R21
001a38 df81      	RCALL __UNPACK
001a39 3890      	CPI  R25,0x80
001a3a f171      	BREQ __ADDF129
001a3b e850      	LDI  R21,0x80
001a3c 2615      	EOR  R1,R21
                 
001a3d c004      	RJMP __ADDF120
                 
                 __ADDF12:
001a3e 935f      	PUSH R21
001a3f df7a      	RCALL __UNPACK
001a40 3890      	CPI  R25,0x80
001a41 f139      	BREQ __ADDF129
                 
                 __ADDF120:
001a42 3870      	CPI  R23,0x80
001a43 f121      	BREQ __ADDF128
                 __ADDF121:
001a44 2f57      	MOV  R21,R23
001a45 1b59      	SUB  R21,R25
001a46 f12b      	BRVS __ADDF1211
001a47 f412      	BRPL __ADDF122
001a48 dfd7      	RCALL __SWAPACC
001a49 cffa      	RJMP __ADDF121
                 __ADDF122:
001a4a 3158      	CPI  R21,24
001a4b f018      	BRLO __ADDF123
001a4c 27aa      	CLR  R26
001a4d 27bb      	CLR  R27
001a4e 2788      	CLR  R24
                 __ADDF123:
001a4f 3058      	CPI  R21,8
001a50 f028      	BRLO __ADDF124
001a51 2fab      	MOV  R26,R27
001a52 2fb8      	MOV  R27,R24
001a53 2788      	CLR  R24
001a54 5058      	SUBI R21,8
001a55 cff9      	RJMP __ADDF123
                 __ADDF124:
001a56 2355      	TST  R21
001a57 f029      	BREQ __ADDF126
                 __ADDF125:
001a58 9586      	LSR  R24
001a59 95b7      	ROR  R27
001a5a 95a7      	ROR  R26
001a5b 955a      	DEC  R21
001a5c f7d9      	BRNE __ADDF125
                 __ADDF126:
001a5d 2d50      	MOV  R21,R0
001a5e 2551      	EOR  R21,R1
001a5f f072      	BRMI __ADDF127
001a60 dfcb      	RCALL __UADD12
001a61 f438      	BRCC __ADDF129
001a62 9567      	ROR  R22
001a63 95f7      	ROR  R31
001a64 95e7      	ROR  R30
001a65 9573      	INC  R23
001a66 f413      	BRVC __ADDF129
001a67 c020      	RJMP __MAXRES
                 __ADDF128:
001a68 dfb7      	RCALL __SWAPACC
                 __ADDF129:
001a69 df3e      	RCALL __REPACK
001a6a 915f      	POP  R21
001a6b 9508      	RET
                 __ADDF1211:
001a6c f7d8      	BRCC __ADDF128
001a6d cffb      	RJMP __ADDF129
                 __ADDF127:
001a6e 1bea      	SUB  R30,R26
001a6f 0bfb      	SBC  R31,R27
001a70 0b68      	SBC  R22,R24
001a71 f051      	BREQ __ZERORES
001a72 f410      	BRCC __ADDF1210
001a73 9400      	COM  R0
001a74 dfbb      	RCALL __NEGMAN1
                 __ADDF1210:
001a75 2366      	TST  R22
001a76 f392      	BRMI __ADDF129
001a77 0fee      	LSL  R30
001a78 1fff      	ROL  R31
001a79 1f66      	ROL  R22
001a7a 957a      	DEC  R23
001a7b f7cb      	BRVC __ADDF1210
                 
                 __ZERORES:
001a7c 27ee      	CLR  R30
001a7d 27ff      	CLR  R31
001a7e 2766      	CLR  R22
001a7f 2777      	CLR  R23
001a80 915f      	POP  R21
001a81 9508      	RET
                 
                 __MINRES:
001a82 efef      	SER  R30
001a83 efff      	SER  R31
001a84 e76f      	LDI  R22,0x7F
001a85 ef7f      	SER  R23
001a86 915f      	POP  R21
001a87 9508      	RET
                 
                 __MAXRES:
001a88 efef      	SER  R30
001a89 efff      	SER  R31
001a8a e76f      	LDI  R22,0x7F
001a8b e77f      	LDI  R23,0x7F
001a8c 915f      	POP  R21
001a8d 9508      	RET
                 
                 __MULF12:
001a8e 935f      	PUSH R21
001a8f df2a      	RCALL __UNPACK
001a90 3870      	CPI  R23,0x80
001a91 f351      	BREQ __ZERORES
001a92 3890      	CPI  R25,0x80
001a93 f341      	BREQ __ZERORES
001a94 2401      	EOR  R0,R1
001a95 9408      	SEC
001a96 1f79      	ADC  R23,R25
001a97 f423      	BRVC __MULF124
001a98 f31c      	BRLT __ZERORES
                 __MULF125:
001a99 2000      	TST  R0
001a9a f33a      	BRMI __MINRES
001a9b cfec      	RJMP __MAXRES
                 __MULF124:
001a9c 920f      	PUSH R0
001a9d 931f      	PUSH R17
001a9e 932f      	PUSH R18
001a9f 933f      	PUSH R19
001aa0 934f      	PUSH R20
001aa1 2711      	CLR  R17
001aa2 2722      	CLR  R18
001aa3 2799      	CLR  R25
001aa4 9f68      	MUL  R22,R24
001aa5 01a0      	MOVW R20,R0
001aa6 9f8f      	MUL  R24,R31
001aa7 2d30      	MOV  R19,R0
001aa8 0d41      	ADD  R20,R1
001aa9 1f59      	ADC  R21,R25
001aaa 9f6b      	MUL  R22,R27
001aab 0d30      	ADD  R19,R0
001aac 1d41      	ADC  R20,R1
001aad 1f59      	ADC  R21,R25
001aae 9f8e      	MUL  R24,R30
001aaf d027      	RCALL __MULF126
001ab0 9fbf      	MUL  R27,R31
001ab1 d025      	RCALL __MULF126
001ab2 9f6a      	MUL  R22,R26
001ab3 d023      	RCALL __MULF126
001ab4 9fbe      	MUL  R27,R30
001ab5 d01d      	RCALL __MULF127
001ab6 9faf      	MUL  R26,R31
001ab7 d01b      	RCALL __MULF127
001ab8 9fae      	MUL  R26,R30
001ab9 0d11      	ADD  R17,R1
001aba 1f29      	ADC  R18,R25
001abb 1f39      	ADC  R19,R25
001abc 1f49      	ADC  R20,R25
001abd 1f59      	ADC  R21,R25
001abe 2fe3      	MOV  R30,R19
001abf 2ff4      	MOV  R31,R20
001ac0 2f65      	MOV  R22,R21
001ac1 2f52      	MOV  R21,R18
001ac2 914f      	POP  R20
001ac3 913f      	POP  R19
001ac4 912f      	POP  R18
001ac5 911f      	POP  R17
001ac6 900f      	POP  R0
001ac7 2366      	TST  R22
001ac8 f02a      	BRMI __MULF122
001ac9 0f55      	LSL  R21
001aca 1fee      	ROL  R30
001acb 1fff      	ROL  R31
001acc 1f66      	ROL  R22
001acd c002      	RJMP __MULF123
                 __MULF122:
001ace 9573      	INC  R23
001acf f24b      	BRVS __MULF125
                 __MULF123:
001ad0 decd      	RCALL __ROUND_REPACK
001ad1 915f      	POP  R21
001ad2 9508      	RET
                 
                 __MULF127:
001ad3 0d10      	ADD  R17,R0
001ad4 1d21      	ADC  R18,R1
001ad5 1f39      	ADC  R19,R25
001ad6 c002      	RJMP __MULF128
                 __MULF126:
001ad7 0d20      	ADD  R18,R0
001ad8 1d31      	ADC  R19,R1
                 __MULF128:
001ad9 1f49      	ADC  R20,R25
001ada 1f59      	ADC  R21,R25
001adb 9508      	RET
                 
                 __DIVF21:
001adc 935f      	PUSH R21
001add dedc      	RCALL __UNPACK
001ade 3870      	CPI  R23,0x80
001adf f421      	BRNE __DIVF210
001ae0 2011      	TST  R1
                 __DIVF211:
001ae1 f40a      	BRPL __DIVF219
001ae2 cf9f      	RJMP __MINRES
                 __DIVF219:
001ae3 cfa4      	RJMP __MAXRES
                 __DIVF210:
001ae4 3890      	CPI  R25,0x80
001ae5 f409      	BRNE __DIVF218
                 __DIVF217:
001ae6 cf95      	RJMP __ZERORES
                 __DIVF218:
001ae7 2401      	EOR  R0,R1
001ae8 9408      	SEC
001ae9 0b97      	SBC  R25,R23
001aea f41b      	BRVC __DIVF216
001aeb f3d4      	BRLT __DIVF217
001aec 2000      	TST  R0
001aed cff3      	RJMP __DIVF211
                 __DIVF216:
001aee 2f79      	MOV  R23,R25
001aef 931f      	PUSH R17
001af0 932f      	PUSH R18
001af1 933f      	PUSH R19
001af2 934f      	PUSH R20
001af3 2411      	CLR  R1
001af4 2711      	CLR  R17
001af5 2722      	CLR  R18
001af6 2733      	CLR  R19
001af7 2744      	CLR  R20
001af8 2755      	CLR  R21
001af9 e290      	LDI  R25,32
                 __DIVF212:
001afa 17ae      	CP   R26,R30
001afb 07bf      	CPC  R27,R31
001afc 0786      	CPC  R24,R22
001afd 0741      	CPC  R20,R17
001afe f030      	BRLO __DIVF213
001aff 1bae      	SUB  R26,R30
001b00 0bbf      	SBC  R27,R31
001b01 0b86      	SBC  R24,R22
001b02 0b41      	SBC  R20,R17
001b03 9408      	SEC
001b04 c001      	RJMP __DIVF214
                 __DIVF213:
001b05 9488      	CLC
                 __DIVF214:
001b06 1f55      	ROL  R21
001b07 1f22      	ROL  R18
001b08 1f33      	ROL  R19
001b09 1c11      	ROL  R1
001b0a 1faa      	ROL  R26
001b0b 1fbb      	ROL  R27
001b0c 1f88      	ROL  R24
001b0d 1f44      	ROL  R20
001b0e 959a      	DEC  R25
001b0f f751      	BRNE __DIVF212
001b10 01f9      	MOVW R30,R18
001b11 2d61      	MOV  R22,R1
001b12 914f      	POP  R20
001b13 913f      	POP  R19
001b14 912f      	POP  R18
001b15 911f      	POP  R17
001b16 2366      	TST  R22
001b17 f032      	BRMI __DIVF215
001b18 0f55      	LSL  R21
001b19 1fee      	ROL  R30         [               strncatf                                                                    и               strncmp                                                                                    strncmpf                                                                    ї               strncpy                                                                     	               strncpyf                                                                    
               strlcpy                                                                     П
               strlcpyf                                                                    2               strpbrk                                                                     з               strpbrkf                                                                    Q               strpos                                                                      і               strrchr                                                                     #               strrpbrk                                                                    o               strrpbrkf                                                                   ц                strrpos                                                                       !             strstr                                                                      м  "             strstrf                                                                     X  #             strspn                                                                         $             strspnf                                                                     n  %             strtok                                                                      ы  &             p_S1020026000                                                          џџџџ  xэ  &                                                                                                                                                                                                                                      	                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         !                        "                        #                        $                        %                        &                      %        "          ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # рн 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # ћн 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # о 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # 1о 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # Lо 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # gо 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # о 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # о 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # Ио 	     " 	        Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # го 	     " 
        С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # юо 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # 	п 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # $п 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # ?п 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # Zп 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # uп 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # п 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # Ћп 	     "         Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # Цп 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # сп 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # ќп 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # р 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # 2р 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # Mр 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # hр 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # р 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # р 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # Йр 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # др 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # яр 	     "         С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # 
с 	     "         ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # %с 	     "          ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # @с 	     " !        С         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         # [с 	     " "        ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # vс 	     " #        ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # с 	     " $        ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # Ќс 	     " %        ђ          Т         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A         @        A         @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     @џџџџ     A                  0         # Чс 	     " &        ђ          Т                 c        $         8      T '        $         8      |                           0                T '        ћ                c        Н         o         %        o                  ћ         o        W          #         8      ^         `'        |                           0                c        Н         o                         $         9              Ћ        Ж        ^                         ї'                c                         0         # тс 	     