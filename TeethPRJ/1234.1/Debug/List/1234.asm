
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega64A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega64A
	#pragma AVRPART MEMORY PROG_FLASH 65536
	#pragma AVRPART MEMORY EEPROM 2048
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _k=R4
	.DEF _k_msb=R5
	.DEF _z=R6
	.DEF _z_msb=R7
	.DEF _q=R8
	.DEF _q_msb=R9
	.DEF _p=R10
	.DEF _p_msb=R11
	.DEF _j=R12
	.DEF _j_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_no:
	.DB  0x3,0x9F,0x25,0xD,0x99,0x49,0x41,0x1F
	.DB  0x1,0x9,0xFF,0xFD,0x91

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0

_0x3:
	.DB  0xA,0x0,0xA,0x0,0xA,0x0,0xA

__GLOBAL_INI_TBL:
	.DW  0x08
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x07
	.DW  _digit
	.DW  _0x3*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : TeethRadiology Project
;Version : 5.1
;Date    : 7/7/2017
;Author  : Ehsan Shaghaei
;Company : EHP
;Comments:
;
;
;Chip type               : ATmega64A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 1024
;*******************************************************/
;
;#include <mega64a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#define C0  1
;#define C1  1
;#define C2  1
;#define C3  1
;#define C4  1
;#define C5  1
;#define C6  1
;#define C7  1
;#define Buzzer       PORTB.0
;#define Ssr          PORTB.2
;#define Timer_LED    PORTB.1
;#define heat_time    200
;#define startup_time 1000
;
;#define Expose_LED_ON  PORTG|=(1<<4)
;#define Expose_LED_OFF PORTG&= ~(1<<4)
;
;#define A0         PORTA.0
;#define A1         PORTA.1
;#define A2         PORTA.2
;#define A3         PORTA.3
;#define A4         PORTA.4
;#define A5         PORTA.5
;#define A6         PORTA.6
;#define A7         PORTA.7
;
;#define D0         PIND.7
;#define D1         PIND.6
;#define D2         PIND.5
;#define D3         PIND.4
;
;#define RVG_SW       PINE.6
;#define Timer_SW     PINE.7
;#define Expose_SW    PIND.2
;#define Up_SW        PINE.4
;#define Down_SW      PIND.0
;
;#define Set_Segments PORTF
;
;
;// Declare your global variables here
;//flash int  time [16] = {800,750,700,600,550,500,450,400,350,400,450,550,650,700,800,800};
;flash char no   [13] = {0b00000011,0b10011111,0b00100101,0b00001101,0b10011001,0b01001001,0b01000001,0b00011111,0b000000 ...
;eeprom unsigned int l = 800;
;int digit [4] = {10,10,10,10};

	.DSEG
;unsigned int k = 0,z=0;
;unsigned int q,p=0 ;
;int j;
;char timer_flag = 0;
;void beep ();
;void Display_Number (unsigned int arg);
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 004F {

	.CSEG
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0050 // Place your code here
; 0000 0051 
; 0000 0052     z = k%4;
	MOVW R30,R4
	ANDI R30,LOW(0x3)
	ANDI R31,HIGH(0x3)
	MOVW R6,R30
; 0000 0053      k++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 0054     switch(z)
	MOVW R30,R6
; 0000 0055     {
; 0000 0056     case 0:
	SBIW R30,0
	BRNE _0x7
; 0000 0057     PORTG &=~(1<<1);PORTG &=~(1<<2);PORTG &=~(1<<3);
	RCALL SUBOPT_0x0
	RCALL SUBOPT_0x1
; 0000 0058     Set_Segments =  no[digit[0]] & 0xfe;
	LDS  R30,_digit
	LDS  R31,_digit+1
	SUBI R30,LOW(-_no*2)
	SBCI R31,HIGH(-_no*2)
	LPM  R30,Z
	ANDI R30,0xFE
	RCALL SUBOPT_0x2
; 0000 0059     PORTG|=(1<<0);
	ORI  R30,1
	STS  101,R30
; 0000 005A     //delay_ms(1);
; 0000 005B     break;
	RJMP _0x6
; 0000 005C     case 1:
_0x7:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x8
; 0000 005D     PORTG &=~(1<<0);PORTG &=~(1<<2);PORTG &=~(1<<3);
	LDS  R30,101
	ANDI R30,0xFE
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x1
; 0000 005E     Set_Segments =  no[digit[1]] ;
	__GETW1MN _digit,2
	RCALL SUBOPT_0x4
; 0000 005F     PORTG|=(1<<1);
	ORI  R30,2
	STS  101,R30
; 0000 0060     //delay_ms(1);
; 0000 0061     break;
	RJMP _0x6
; 0000 0062     case 2:
_0x8:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x9
; 0000 0063     PORTG &=~(1<<1);PORTG &=~(1<<0);PORTG &=~(1<<3);
	RCALL SUBOPT_0x0
	ANDI R30,0xFE
	RCALL SUBOPT_0x3
	ANDI R30,0XF7
	STS  101,R30
; 0000 0064     Set_Segments = no[digit[2]];
	__GETW1MN _digit,4
	RCALL SUBOPT_0x4
; 0000 0065     PORTG|=(1<<2);
	ORI  R30,4
	STS  101,R30
; 0000 0066     //delay_ms(1);
; 0000 0067     break;
	RJMP _0x6
; 0000 0068     case 3:
_0x9:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x6
; 0000 0069     PORTG &=~(1<<1);PORTG &=~(1<<2);PORTG &=~(1<<0);
	RCALL SUBOPT_0x0
	ANDI R30,0xFB
	RCALL SUBOPT_0x3
	ANDI R30,0xFE
	STS  101,R30
; 0000 006A     Set_Segments = no[digit[3]];
	__GETW1MN _digit,6
	RCALL SUBOPT_0x4
; 0000 006B     PORTG|=(1<<3);
	ORI  R30,8
	STS  101,R30
; 0000 006C     k=0;
	CLR  R4
	CLR  R5
; 0000 006D     //delay_ms(1);
; 0000 006E     break;
; 0000 006F     }
_0x6:
; 0000 0070 
; 0000 0071 
; 0000 0072       //  #asm ("sei")
; 0000 0073 
; 0000 0074 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0077 {
_main:
; .FSTART _main
; 0000 0078 // Declare your local variables here
; 0000 0079 {
; 0000 007A // Input/Output Ports initialization
; 0000 007B // Port A initialization
; 0000 007C // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 007D DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 007E // State: Bit7=1 Bit6=1 Bit5=1 Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 007F PORTA=(1<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (1<<PORTA3) | (1<<PORTA2) | (1<<PORTA1) | (1<<PORTA0);
	OUT  0x1B,R30
; 0000 0080 
; 0000 0081 // Port B initialization
; 0000 0082 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0083 DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	OUT  0x17,R30
; 0000 0084 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0085 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0086 
; 0000 0087 // Port C initialization
; 0000 0088 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0089 DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 008A // State: Bit7=1 Bit6=1 Bit5=1 Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 008B PORTC=(1<<PORTC7) | (1<<PORTC6) | (1<<PORTC5) | (1<<PORTC4) | (1<<PORTC3) | (1<<PORTC2) | (1<<PORTC1) | (1<<PORTC0);
	OUT  0x15,R30
; 0000 008C 
; 0000 008D // Port D initialization
; 0000 008E // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 008F DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(0)
	OUT  0x11,R30
; 0000 0090 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 0091 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (1<<PORTD1) | (1<<PORTD0);
	LDI  R30,LOW(15)
	OUT  0x12,R30
; 0000 0092 
; 0000 0093 // Port E initialization
; 0000 0094 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=Out Bit1=Out Bit0=Out
; 0000 0095 DDRE=(0<<DDE7) | (0<<DDE6) | (0<<DDE5) | (0<<DDE4) | (0<<DDE3) | (1<<DDE2) | (1<<DDE1) | (1<<DDE0);
	LDI  R30,LOW(7)
	OUT  0x2,R30
; 0000 0096 // State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=T Bit2=0 Bit1=0 Bit0=0
; 0000 0097 PORTE=(1<<PORTE7) | (1<<PORTE6) | (1<<PORTE5) | (1<<PORTE4) | (0<<PORTE3) | (0<<PORTE2) | (0<<PORTE1) | (0<<PORTE0);
	LDI  R30,LOW(240)
	OUT  0x3,R30
; 0000 0098 
; 0000 0099 // Port F initialization
; 0000 009A // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 009B DDRF=(1<<DDF7) | (1<<DDF6) | (1<<DDF5) | (1<<DDF4) | (1<<DDF3) | (1<<DDF2) | (1<<DDF1) | (1<<DDF0);
	LDI  R30,LOW(255)
	STS  97,R30
; 0000 009C // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 009D PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF3) | (0<<PORTF2) | (0<<PORTF1) | (0<<PORTF0);
	LDI  R30,LOW(0)
	STS  98,R30
; 0000 009E 
; 0000 009F // Port G initialization
; 0000 00A0 // Function: Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 00A1 DDRG=(1<<DDG4) | (1<<DDG3) | (1<<DDG2) | (1<<DDG1) | (1<<DDG0);
	LDI  R30,LOW(31)
	STS  100,R30
; 0000 00A2 // State: Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 00A3 PORTG=(0<<PORTG4) | (0<<PORTG3) | (0<<PORTG2) | (0<<PORTG1) | (0<<PORTG0);
	LDI  R30,LOW(0)
	STS  101,R30
; 0000 00A4 
; 0000 00A5 // Timer/Counter 0 initialization
; 0000 00A6 // Clock source: System Clock
; 0000 00A7 // Clock value: 125.000 kHz
; 0000 00A8 // Mode: Normal top=0xFF
; 0000 00A9 // OC0 output: Disconnected
; 0000 00AA // Timer Period: 2.048 ms
; 0000 00AB //ASSR=0<<AS0;
; 0000 00AC //TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (0<<CS00);
; 0000 00AD //TCNT0=0x00;
; 0000 00AE //OCR0=0x00;
; 0000 00AF   // Timer/Counter 0 initialization
; 0000 00B0 // Clock source: System Clock
; 0000 00B1 // Clock value: 250.000 kHz
; 0000 00B2 // Mode: Normal top=0xFF
; 0000 00B3 // OC0 output: Disconnected
; 0000 00B4 // Timer Period: 1.024 ms
; 0000 00B5 ASSR=0<<AS0;
	OUT  0x30,R30
; 0000 00B6 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
	LDI  R30,LOW(3)
	OUT  0x33,R30
; 0000 00B7 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 00B8 OCR0=0x00;
	OUT  0x31,R30
; 0000 00B9 // Timer/Counter 1 initialization
; 0000 00BA // Clock source: System Clock
; 0000 00BB // Clock value: Timer1 Stopped
; 0000 00BC // Mode: Normal top=0xFFFF
; 0000 00BD // OC1A output: Disconnected
; 0000 00BE // OC1B output: Disconnected
; 0000 00BF // OC1C output: Disconnected
; 0000 00C0 // Noise Canceler: Off
; 0000 00C1 // Input Capture on Falling Edge
; 0000 00C2 // Timer1 Overflow Interrupt: Off
; 0000 00C3 // Input Capture Interrupt: Off
; 0000 00C4 // Compare A Match Interrupt: Off
; 0000 00C5 // Compare B Match Interrupt: Off
; 0000 00C6 // Compare C Match Interrupt: Off
; 0000 00C7 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 00C8 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 00C9 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 00CA TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 00CB ICR1H=0x00;
	OUT  0x27,R30
; 0000 00CC ICR1L=0x00;
	OUT  0x26,R30
; 0000 00CD OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00CE OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00CF OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00D0 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00D1 OCR1CH=0x00;
	STS  121,R30
; 0000 00D2 OCR1CL=0x00;
	STS  120,R30
; 0000 00D3 
; 0000 00D4 // Timer/Counter 2 initialization
; 0000 00D5 // Clock source: System Clock
; 0000 00D6 // Clock value: Timer2 Stopped
; 0000 00D7 // Mode: Normal top=0xFF
; 0000 00D8 // OC2 output: Disconnected
; 0000 00D9 TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 00DA TCNT2=0x00;
	OUT  0x24,R30
; 0000 00DB OCR2=0x00;
	OUT  0x23,R30
; 0000 00DC 
; 0000 00DD // Timer/Counter 3 initialization
; 0000 00DE // Clock source: System Clock
; 0000 00DF // Clock value: Timer3 Stopped
; 0000 00E0 // Mode: Normal top=0xFFFF
; 0000 00E1 // OC3A output: Disconnected
; 0000 00E2 // OC3B output: Disconnected
; 0000 00E3 // OC3C output: Disconnected
; 0000 00E4 // Noise Canceler: Off
; 0000 00E5 // Input Capture on Falling Edge
; 0000 00E6 // Timer3 Overflow Interrupt: Off
; 0000 00E7 // Input Capture Interrupt: Off
; 0000 00E8 // Compare A Match Interrupt: Off
; 0000 00E9 // Compare B Match Interrupt: Off
; 0000 00EA // Compare C Match Interrupt: Off
; 0000 00EB TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
	STS  139,R30
; 0000 00EC TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
	STS  138,R30
; 0000 00ED TCNT3H=0x00;
	STS  137,R30
; 0000 00EE TCNT3L=0x00;
	STS  136,R30
; 0000 00EF ICR3H=0x00;
	STS  129,R30
; 0000 00F0 ICR3L=0x00;
	STS  128,R30
; 0000 00F1 OCR3AH=0x00;
	STS  135,R30
; 0000 00F2 OCR3AL=0x00;
	STS  134,R30
; 0000 00F3 OCR3BH=0x00;
	STS  133,R30
; 0000 00F4 OCR3BL=0x00;
	STS  132,R30
; 0000 00F5 OCR3CH=0x00;
	STS  131,R30
; 0000 00F6 OCR3CL=0x00;
	STS  130,R30
; 0000 00F7 
; 0000 00F8 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00F9 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(1)
	OUT  0x37,R30
; 0000 00FA ETIMSK=(0<<TICIE3) | (0<<OCIE3A) | (0<<OCIE3B) | (0<<TOIE3) | (0<<OCIE3C) | (0<<OCIE1C);
	LDI  R30,LOW(0)
	STS  125,R30
; 0000 00FB 
; 0000 00FC // External Interrupt(s) initialization
; 0000 00FD // INT0: Off
; 0000 00FE // INT1: Off
; 0000 00FF // INT2: Off
; 0000 0100 // INT3: Off
; 0000 0101 // INT4: Off
; 0000 0102 // INT5: Off
; 0000 0103 // INT6: Off
; 0000 0104 // INT7: Off
; 0000 0105 EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  106,R30
; 0000 0106 EICRB=(0<<ISC71) | (0<<ISC70) | (0<<ISC61) | (0<<ISC60) | (0<<ISC51) | (0<<ISC50) | (0<<ISC41) | (0<<ISC40);
	OUT  0x3A,R30
; 0000 0107 EIMSK=(0<<INT7) | (0<<INT6) | (0<<INT5) | (0<<INT4) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x39,R30
; 0000 0108 
; 0000 0109 // USART0 initialization
; 0000 010A // USART0 disabled
; 0000 010B UCSR0B=(0<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (0<<RXEN0) | (0<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
	OUT  0xA,R30
; 0000 010C 
; 0000 010D // USART1 initialization
; 0000 010E // USART1 disabled
; 0000 010F UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	STS  154,R30
; 0000 0110 
; 0000 0111 // Analog Comparator initialization
; 0000 0112 // Analog Comparator: Off
; 0000 0113 // The Analog Comparator's positive input is
; 0000 0114 // connected to the AIN0 pin
; 0000 0115 // The Analog Comparator's negative input is
; 0000 0116 // connected to the AIN1 pin
; 0000 0117 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0118 SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0119 
; 0000 011A // ADC initialization
; 0000 011B // ADC disabled
; 0000 011C ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADFR) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 011D 
; 0000 011E // SPI initialization
; 0000 011F // SPI disabled
; 0000 0120 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 0121 
; 0000 0122 // TWI initialization
; 0000 0123 // TWI disabled
; 0000 0124 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	STS  116,R30
; 0000 0125 
; 0000 0126  }
; 0000 0127 // Global enable interrupts
; 0000 0128 #asm("sei")
	sei
; 0000 0129 
; 0000 012A 
; 0000 012B digit [0] = 11;
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	RCALL SUBOPT_0x5
; 0000 012C digit [1] = 12;
	__POINTW1MN _digit,2
	LDI  R26,LOW(12)
	LDI  R27,HIGH(12)
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 012D digit [2] = 1;
	__POINTW1MN _digit,4
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 012E digit [3] = 11;
	__POINTW1MN _digit,6
	LDI  R26,LOW(11)
	LDI  R27,HIGH(11)
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 012F PORTA = 0x00;
	RCALL SUBOPT_0x6
; 0000 0130 PORTC = 0x00;
; 0000 0131 beep();
	RCALL SUBOPT_0x7
; 0000 0132 delay_ms(200);
; 0000 0133 beep();
	RCALL SUBOPT_0x7
; 0000 0134 delay_ms(200);
; 0000 0135 beep();
	RCALL _beep
; 0000 0136 
; 0000 0137 //PORTA.0 = 1;
; 0000 0138 delay_ms(startup_time);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 0139 
; 0000 013A 
; 0000 013B //         q=1543;
; 0000 013C //        for (j=3;j>=0;j--)
; 0000 013D //        {
; 0000 013E //        digit [j] = q%10;
; 0000 013F //        q = q/10;
; 0000 0140 //        }
; 0000 0141 //        for (j=3;j>=0;j--)
; 0000 0142 //        {
; 0000 0143 //        digit [j] = q%10;
; 0000 0144 //        q = q/10;
; 0000 0145 //        }
; 0000 0146 //            j=3;
; 0000 0147 //            q=6543;
; 0000 0148 //            while (j >= 0 && j <= 3)
; 0000 0149 //            {
; 0000 014A //               digit [j] = q%10;
; 0000 014B //               q = q/10;
; 0000 014C //               j--;
; 0000 014D //            }
; 0000 014E         A0 = C0; A1 = C1; A2 = C2; A3 = C3; A4 = C4; A5 = C5; A6 = C6; A7 = C7;
	SBI  0x1B,0
	SBI  0x1B,1
	SBI  0x1B,2
	SBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
; 0000 014F         while (1)
_0x1B:
; 0000 0150            {
; 0000 0151                  Display_Number(l);
	RCALL SUBOPT_0x8
	MOVW R26,R30
	RCALL _Display_Number
; 0000 0152 
; 0000 0153                 if(Expose_SW == 0)
	SBIC 0x10,2
	RJMP _0x1E
; 0000 0154                 {
; 0000 0155                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 0156                 if(timer_flag)
	LDS  R30,_timer_flag
	CPI  R30,0
	BREQ _0x1F
; 0000 0157                 {
; 0000 0158                 Display_Number(8888);
	RCALL SUBOPT_0xA
; 0000 0159                 Buzzer = 1;
; 0000 015A 
; 0000 015B                 for(p=0;p<9;p++)
_0x23:
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	CP   R10,R30
	CPC  R11,R31
	BRSH _0x24
; 0000 015C                 {
; 0000 015D                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 015E                 Buzzer = ~ Buzzer;
	SBIS 0x18,0
	RJMP _0x25
	CBI  0x18,0
	RJMP _0x26
_0x25:
	SBI  0x18,0
_0x26:
; 0000 015F                 }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x23
_0x24:
; 0000 0160                 Buzzer = 0;
	CBI  0x18,0
; 0000 0161                 delay_ms (500);
	RCALL SUBOPT_0x9
; 0000 0162                 }
; 0000 0163                 Expose_LED_ON;
_0x1F:
	RCALL SUBOPT_0xB
; 0000 0164                 digit[0]= digit [1] = digit [2] = digit [3] = 11;
; 0000 0165                 Buzzer = 1;
; 0000 0166                 Ssr    = 1;
; 0000 0167                 delay_ms(l+heat_time);
	RCALL SUBOPT_0xC
; 0000 0168                 Ssr    = 0;
; 0000 0169                 Buzzer = 0;
; 0000 016A                 Expose_LED_OFF;
; 0000 016B                 digit[0]= digit [1] = digit [2] = digit [3] = 12;
; 0000 016C                 delay_ms(15000);
; 0000 016D                 Display_Number(l);
	MOVW R26,R30
	RCALL _Display_Number
; 0000 016E                 }
; 0000 016F                 if(Down_SW == 0){
_0x1E:
	SBIC 0x10,0
	RJMP _0x31
; 0000 0170                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 0171                 if (l<=30){l=30;beep();}
	RCALL SUBOPT_0x8
	SBIW R30,31
	BRSH _0x32
	RCALL SUBOPT_0xD
	RCALL _beep
; 0000 0172                 else if (l<=100){l=l-10;}
	RJMP _0x33
_0x32:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRSH _0x34
	RCALL SUBOPT_0x8
	SBIW R30,10
	RJMP _0x9E
; 0000 0173                 else if (l>100) {l=l-50;}
_0x34:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRLO _0x36
	RCALL SUBOPT_0x8
	SBIW R30,50
_0x9E:
	LDI  R26,LOW(_l)
	LDI  R27,HIGH(_l)
	CALL __EEPROMWRW
; 0000 0174                 }
_0x36:
_0x33:
; 0000 0175                 if(Up_SW == 0){
_0x31:
	SBIC 0x1,4
	RJMP _0x37
; 0000 0176                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 0177                 if (l>=3000){l=3000;beep();}
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0xBB8)
	LDI  R26,HIGH(0xBB8)
	CPC  R31,R26
	BRLO _0x38
	RCALL SUBOPT_0xE
; 0000 0178                 else if (l <100){l = l+10;}
	RJMP _0x39
_0x38:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x64)
	LDI  R26,HIGH(0x64)
	CPC  R31,R26
	BRSH _0x3A
	RCALL SUBOPT_0x8
	ADIW R30,10
	RJMP _0x9F
; 0000 0179                 else if (l>=100){l=l+50;}
_0x3A:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x64)
	LDI  R26,HIGH(0x64)
	CPC  R31,R26
	BRLO _0x3C
	RCALL SUBOPT_0x8
	ADIW R30,50
_0x9F:
	LDI  R26,LOW(_l)
	LDI  R27,HIGH(_l)
	CALL __EEPROMWRW
; 0000 017A                 }
_0x3C:
_0x39:
; 0000 017B                 if (RVG_SW == 0 )
_0x37:
	SBIC 0x1,6
	RJMP _0x3D
; 0000 017C                 {
; 0000 017D                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 017E                 l = 30;
	RCALL SUBOPT_0xD
; 0000 017F                 }
; 0000 0180                 if (Timer_SW == 0)
_0x3D:
	SBIC 0x1,7
	RJMP _0x3E
; 0000 0181                 {
; 0000 0182                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 0183                 Timer_LED  = ~ Timer_LED;
	SBIS 0x18,1
	RJMP _0x3F
	CBI  0x18,1
	RJMP _0x40
_0x3F:
	SBI  0x18,1
_0x40:
; 0000 0184                 timer_flag = ~ timer_flag;
	LDS  R30,_timer_flag
	COM  R30
	STS  _timer_flag,R30
; 0000 0185                 }
; 0000 0186                  else if(D0 == 1)
	RJMP _0x41
_0x3E:
	SBIS 0x10,7
	RJMP _0x42
; 0000 0187                 {
; 0000 0188                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 0189                 l = 30;
	RCALL SUBOPT_0xD
; 0000 018A                 }
; 0000 018B                else if(D1 == 1)
	RJMP _0x43
_0x42:
	SBIS 0x10,6
	RJMP _0x44
; 0000 018C                 {
; 0000 018D                 delay_ms(500);         //up
	RCALL SUBOPT_0x9
; 0000 018E                 if (l>=3000){l=3000;beep();}
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0xBB8)
	LDI  R26,HIGH(0xBB8)
	CPC  R31,R26
	BRLO _0x45
	RCALL SUBOPT_0xE
; 0000 018F                 else if (l <100){l = l+10;}
	RJMP _0x46
_0x45:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x64)
	LDI  R26,HIGH(0x64)
	CPC  R31,R26
	BRSH _0x47
	RCALL SUBOPT_0x8
	ADIW R30,10
	RJMP _0xA0
; 0000 0190                 else if (l>=100){l=l+50;}
_0x47:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x64)
	LDI  R26,HIGH(0x64)
	CPC  R31,R26
	BRLO _0x49
	RCALL SUBOPT_0x8
	ADIW R30,50
_0xA0:
	LDI  R26,LOW(_l)
	LDI  R27,HIGH(_l)
	CALL __EEPROMWRW
; 0000 0191                 }
_0x49:
_0x46:
; 0000 0192 
; 0000 0193                else if(D2 == 1)
	RJMP _0x4A
_0x44:
	SBIS 0x10,5
	RJMP _0x4B
; 0000 0194                 {
; 0000 0195                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 0196                 if(timer_flag)
	LDS  R30,_timer_flag
	CPI  R30,0
	BREQ _0x4C
; 0000 0197                 {
; 0000 0198                 Display_Number(8888);
	RCALL SUBOPT_0xA
; 0000 0199                 Buzzer = 1;
; 0000 019A 
; 0000 019B                 for(p=0;p<9;p++)
_0x50:
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	CP   R10,R30
	CPC  R11,R31
	BRSH _0x51
; 0000 019C                 {
; 0000 019D                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 019E                 Buzzer = ~ Buzzer;
	SBIS 0x18,0
	RJMP _0x52
	CBI  0x18,0
	RJMP _0x53
_0x52:
	SBI  0x18,0
_0x53:
; 0000 019F                 }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x50
_0x51:
; 0000 01A0                 Buzzer = 0;
	CBI  0x18,0
; 0000 01A1                 delay_ms (500);
	RCALL SUBOPT_0x9
; 0000 01A2                 }
; 0000 01A3                 Expose_LED_ON;
_0x4C:
	RCALL SUBOPT_0xB
; 0000 01A4                 digit[0]= digit [1] = digit [2] = digit [3] = 11;
; 0000 01A5                 Buzzer = 1;
; 0000 01A6                 Ssr    = 1;
; 0000 01A7                 delay_ms(l+heat_time);
	RCALL SUBOPT_0xC
; 0000 01A8                 Ssr    = 0;
; 0000 01A9                 Buzzer = 0;
; 0000 01AA                 Expose_LED_OFF;
; 0000 01AB                 digit[0]= digit [1] = digit [2] = digit [3] = 12;
; 0000 01AC                 delay_ms(15000);
; 0000 01AD                 Display_Number(l);
	MOVW R26,R30
	RCALL _Display_Number
; 0000 01AE                 }
; 0000 01AF                else if(D3 == 1)
	RJMP _0x5E
_0x4B:
	SBIS 0x10,4
	RJMP _0x5F
; 0000 01B0                 {
; 0000 01B1 
; 0000 01B2                 delay_ms(500);
	RCALL SUBOPT_0x9
; 0000 01B3                 if (l<=30){l=30;beep();}
	RCALL SUBOPT_0x8
	SBIW R30,31
	BRSH _0x60
	RCALL SUBOPT_0xD
	RCALL _beep
; 0000 01B4                 else if (l<=100){l=l-10;}
	RJMP _0x61
_0x60:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRSH _0x62
	RCALL SUBOPT_0x8
	SBIW R30,10
	RJMP _0xA1
; 0000 01B5                 else if (l>100) {l=l-50;}
_0x62:
	RCALL SUBOPT_0x8
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRLO _0x64
	RCALL SUBOPT_0x8
	SBIW R30,50
_0xA1:
	LDI  R26,LOW(_l)
	LDI  R27,HIGH(_l)
	CALL __EEPROMWRW
; 0000 01B6                 }
_0x64:
_0x61:
; 0000 01B7                 else{};
_0x5F:
_0x5E:
_0x4A:
_0x43:
_0x41:
; 0000 01B8                 PORTA = 0x00;
	RCALL SUBOPT_0x6
; 0000 01B9                 PORTC = 0x00;
; 0000 01BA                 switch(l)
	RCALL SUBOPT_0x8
; 0000 01BB                 {
; 0000 01BC                 case 800 :
	CPI  R30,LOW(0x320)
	LDI  R26,HIGH(0x320)
	CPC  R31,R26
	BRNE _0x69
; 0000 01BD                 PORTA.0 = 1;
	SBI  0x1B,0
; 0000 01BE                 PORTC.0 = 1;
	SBI  0x15,0
; 0000 01BF                 PORTC.1 = 1;
	SBI  0x15,1
; 0000 01C0                 break;
	RJMP _0x68
; 0000 01C1                 case 750 :
_0x69:
	CPI  R30,LOW(0x2EE)
	LDI  R26,HIGH(0x2EE)
	CPC  R31,R26
	BRNE _0x70
; 0000 01C2                 PORTA.1 = 1;
	SBI  0x1B,1
; 0000 01C3                 break;
	RJMP _0x68
; 0000 01C4                 case 700 :
_0x70:
	CPI  R30,LOW(0x2BC)
	LDI  R26,HIGH(0x2BC)
	CPC  R31,R26
	BRNE _0x73
; 0000 01C5                 PORTA.2 = 1;
	SBI  0x1B,2
; 0000 01C6                 PORTC.2 = 1;
	SBI  0x15,2
; 0000 01C7                 break;
	RJMP _0x68
; 0000 01C8                 case 650 :
_0x73:
	CPI  R30,LOW(0x28A)
	LDI  R26,HIGH(0x28A)
	CPC  R31,R26
	BRNE _0x78
; 0000 01C9                 PORTC.3 = 1;
	SBI  0x15,3
; 0000 01CA                 break;
	RJMP _0x68
; 0000 01CB                 case 600 :
_0x78:
	CPI  R30,LOW(0x258)
	LDI  R26,HIGH(0x258)
	CPC  R31,R26
	BRNE _0x7B
; 0000 01CC                 PORTA.3 = 1;
	SBI  0x1B,3
; 0000 01CD                 break;
	RJMP _0x68
; 0000 01CE                 case 550 :
_0x7B:
	CPI  R30,LOW(0x226)
	LDI  R26,HIGH(0x226)
	CPC  R31,R26
	BRNE _0x7E
; 0000 01CF                 PORTC.4 = 1;
	SBI  0x15,4
; 0000 01D0                 PORTA.4 = 1;
	SBI  0x1B,4
; 0000 01D1                 break;
	RJMP _0x68
; 0000 01D2                 case 500 :
_0x7E:
	CPI  R30,LOW(0x1F4)
	LDI  R26,HIGH(0x1F4)
	CPC  R31,R26
	BRNE _0x83
; 0000 01D3                 PORTA.5 = 1;
	SBI  0x1B,5
; 0000 01D4                 break;
	RJMP _0x68
; 0000 01D5                 case 450 :
_0x83:
	CPI  R30,LOW(0x1C2)
	LDI  R26,HIGH(0x1C2)
	CPC  R31,R26
	BRNE _0x86
; 0000 01D6                 PORTA.6 = 1;
	SBI  0x1B,6
; 0000 01D7                 PORTC.5 = 1;
	SBI  0x15,5
; 0000 01D8                 break;
	RJMP _0x68
; 0000 01D9                 case 400 :
_0x86:
	CPI  R30,LOW(0x190)
	LDI  R26,HIGH(0x190)
	CPC  R31,R26
	BRNE _0x8B
; 0000 01DA                 PORTA.7 = 1;
	SBI  0x1B,7
; 0000 01DB                 PORTC.6 = 1;
	SBI  0x15,6
; 0000 01DC                 break;
	RJMP _0x68
; 0000 01DD                 case 350 :
_0x8B:
	CPI  R30,LOW(0x15E)
	LDI  R26,HIGH(0x15E)
	CPC  R31,R26
	BRNE _0x93
; 0000 01DE                 PORTC.7 = 1;
	SBI  0x15,7
; 0000 01DF                 break;
	RJMP _0x68
; 0000 01E0                 default :
_0x93:
; 0000 01E1                 PORTA = 0x00;
	RCALL SUBOPT_0x6
; 0000 01E2                 PORTC = 0x00;
; 0000 01E3                 break;
; 0000 01E4                 }
_0x68:
; 0000 01E5 
; 0000 01E6 
; 0000 01E7            }
	RJMP _0x1B
; 0000 01E8 }
_0x94:
	RJMP _0x94
; .FEND
;void Display_Number (unsigned int arg)
; 0000 01EA {
_Display_Number:
; .FSTART _Display_Number
; 0000 01EB       j=3;
	ST   -Y,R27
	ST   -Y,R26
;	arg -> Y+0
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	MOVW R12,R30
; 0000 01EC             q= arg;
	__GETWRS 8,9,0
; 0000 01ED             while (j >= 0 && j <= 3)
_0x95:
	CLR  R0
	CP   R12,R0
	CPC  R13,R0
	BRLT _0x98
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R12
	CPC  R31,R13
	BRGE _0x99
_0x98:
	RJMP _0x97
_0x99:
; 0000 01EE             {
; 0000 01EF                digit [j] = q%10;
	MOVW R30,R12
	LDI  R26,LOW(_digit)
	LDI  R27,HIGH(_digit)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	MOVW R26,R8
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	MOVW R26,R22
	ST   X+,R30
	ST   X,R31
; 0000 01F0                q = q/10;
	MOVW R26,R8
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	MOVW R8,R30
; 0000 01F1                j--;
	MOVW R30,R12
	SBIW R30,1
	MOVW R12,R30
; 0000 01F2             }
	RJMP _0x95
_0x97:
; 0000 01F3 }
	ADIW R28,2
	RET
; .FEND
;void beep ()
; 0000 01F5 {
_beep:
; .FSTART _beep
; 0000 01F6 Buzzer = 1;
	SBI  0x18,0
; 0000 01F7 delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 01F8 Buzzer= 0;
	CBI  0x18,0
; 0000 01F9 }
	RET
; .FEND

	.ESEG
_l:
	.DB  0x20,0x3

	.DSEG
_digit:
	.BYTE 0x8
_timer_flag:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x0:
	LDS  R30,101
	ANDI R30,0xFD
	STS  101,R30
	LDS  R30,101
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	ANDI R30,0xFB
	STS  101,R30
	LDS  R30,101
	ANDI R30,0XF7
	STS  101,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	STS  98,R30
	LDS  R30,101
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	STS  101,R30
	LDS  R30,101
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	SUBI R30,LOW(-_no*2)
	SBCI R31,HIGH(-_no*2)
	LPM  R30,Z
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5:
	STS  _digit,R30
	STS  _digit+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(0)
	OUT  0x1B,R30
	OUT  0x15,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	RCALL _beep
	LDI  R26,LOW(200)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 26 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(_l)
	LDI  R27,HIGH(_l)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(8888)
	LDI  R27,HIGH(8888)
	RCALL _Display_Number
	SBI  0x18,0
	CLR  R10
	CLR  R11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0xB:
	LDS  R30,101
	ORI  R30,0x10
	STS  101,R30
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	__PUTW1MN _digit,6
	__PUTW1MN _digit,4
	__PUTW1MN _digit,2
	RCALL SUBOPT_0x5
	SBI  0x18,0
	SBI  0x18,2
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0xC:
	SUBI R30,LOW(-200)
	SBCI R31,HIGH(-200)
	MOVW R26,R30
	CALL _delay_ms
	CBI  0x18,2
	CBI  0x18,0
	LDS  R30,101
	ANDI R30,0xEF
	STS  101,R30
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	__PUTW1MN _digit,6
	__PUTW1MN _digit,4
	__PUTW1MN _digit,2
	RCALL SUBOPT_0x5
	LDI  R26,LOW(15000)
	LDI  R27,HIGH(15000)
	CALL _delay_ms
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(_l)
	LDI  R27,HIGH(_l)
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	CALL __EEPROMWRW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDI  R26,LOW(_l)
	LDI  R27,HIGH(_l)
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	CALL __EEPROMWRW
	RJMP _beep


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

;END OF CODE MARKER
__END_OF_CODE:
