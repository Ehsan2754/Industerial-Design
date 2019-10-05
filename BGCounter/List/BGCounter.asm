
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega8
;Program type             : Application
;Clock frequency          : 8.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1119
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

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
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

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

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
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
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
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
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	.DEF _FirstVal=R5
	.DEF _SecondVal=R4
	.DEF _ThirdVal=R7
	.DEF _ForthVal=R6
	.DEF _TimeFlag=R9
	.DEF _DecimalPoint=R8
	.DEF _CounterINTFlag=R11
	.DEF _AnimSegFrame=R10
	.DEF _MainCounter=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer1_ovf_isr
	RJMP _timer0_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x3:
	.DB  0x5,0x7D,0x46,0x54,0x3C,0x94,0x84,0x5D
	.DB  0x4,0x14,0xFF,0xFE
_0x4:
	.DB  0xDF,0xBF,0xEF,0xF7,0xFD,0x7F
_0x5:
	.DB  0xDF,0x9F,0x8F,0x87,0x85,0x5,0x25,0x65
	.DB  0x75,0x7D,0x7F,0xFF,0x86
_0xEF:
	.DB  0x0,0x0,0x0,0x0,0x0,0x1,0x0,0x0
	.DB  0x0,0x0
_0x0:
	.DB  0x25,0x34,0x64,0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0C
	.DW  _Segments
	.DW  _0x3*2

	.DW  0x0D
	.DW  _AnimSeg
	.DW  _0x5*2

	.DW  0x0A
	.DW  0x04
	.DW  _0xEF*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

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
	LDI  R26,__SRAM_START
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

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;
;#include <mega8.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <stdio.h>
;
;//--------------------------------
;#define ADC_VREF_TYPE    0x00
;#define LED              PORTC.5
;#define Buzzer           PORTC.1
;#define FirstSeg         PORTB.3
;#define SecondSeg        PORTB.0
;#define ThirdSeg         PORTB.1
;#define ForthSeg         PORTB.2
;#define SWRST            PINC.4
;#define SWSEL            PINC.3
;#define EncoderSyncValue 9
;#define SW_RST           4
;#define SW_RST_VAL       400
;#define SW_SEL           3
;#define SW_SEL_VAL       150
;#define DelayForBlinking 500
;#define SegOFF           10
;#define RelayOut         PORTC.0
;//--------------------------------
;      //0b10000110;
;      //--BFAEDPCG
;
;char Segments[12]        = {0b00000101,0b01111101,0b01000110,0b01010100,0b00111100,0b10010100,0b10000100,0b01011101,0b00000100,0b00010100,0b11111111,0b11111110};

	.DSEG
;char AnimSeg1[6]         = {0b11011111,0b10111111,0b11101111,0b11110111,0b11111101,0b01111111};
;char AnimSeg[13]         = {0b11011111,0b10011111,0b10001111,0b10000111,0b10000101,0b00000101,0b00100101,0b01100101,0b01110101,0b01111101,0b01111111,0b11111111,0b10000110};
;
;char FirstVal            = 0;
;char SecondVal           = 0;
;char ThirdVal            = 0;
;char ForthVal            = 0;
;char TimeFlag            = 1;
;char DecimalPoint        = 0;
;char CounterINTFlag      = 0;
;bit  AnimSegFlag         = 0;
;char AnimSegFrame        = 0;
;int MainCounter          = 0;
;char CheckCounterValue   = 0;
;bit  AnimationIsOn       = 0;
;eeprom long int TotalCounter  = 0;
;eeprom int CounterValue  = 0;
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 002F {

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0030 switch(TimeFlag)
	MOV  R30,R9
	RCALL SUBOPT_0x0
; 0000 0031 {
; 0000 0032  case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x9
; 0000 0033       FirstSeg  = 1;
	SBI  0x18,3
; 0000 0034       SecondSeg = 0;
	CBI  0x18,0
; 0000 0035       ThirdSeg  = 0;
	CBI  0x18,1
; 0000 0036       ForthSeg  = 0;
	CBI  0x18,2
; 0000 0037       PORTD = Segments[FirstVal];
	MOV  R30,R5
	RCALL SUBOPT_0x1
; 0000 0038 
; 0000 0039       TimeFlag = 2;
	LDI  R30,LOW(2)
	RJMP _0xEC
; 0000 003A  break;
; 0000 003B  case 2:
_0x9:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x12
; 0000 003C       PORTD = Segments[SecondVal];
	MOV  R30,R4
	RCALL SUBOPT_0x1
; 0000 003D       FirstSeg  = 0;
	CBI  0x18,3
; 0000 003E       SecondSeg = 1;
	SBI  0x18,0
; 0000 003F       ThirdSeg  = 0;
	CBI  0x18,1
; 0000 0040       ForthSeg  = 0;
	CBI  0x18,2
; 0000 0041       if(DecimalPoint == 1) PORTD.2 = 0;
	LDI  R30,LOW(1)
	CP   R30,R8
	BRNE _0x1B
	CBI  0x12,2
; 0000 0042       TimeFlag = 3;
_0x1B:
	LDI  R30,LOW(3)
	RJMP _0xEC
; 0000 0043  break;
; 0000 0044  case 3:
_0x12:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1E
; 0000 0045       PORTD = Segments[ThirdVal];
	MOV  R30,R7
	RCALL SUBOPT_0x1
; 0000 0046       FirstSeg  = 0;
	CBI  0x18,3
; 0000 0047       SecondSeg = 0;
	CBI  0x18,0
; 0000 0048       ThirdSeg  = 1;
	SBI  0x18,1
; 0000 0049       ForthSeg  = 0;
	CBI  0x18,2
; 0000 004A       TimeFlag = 4;
	LDI  R30,LOW(4)
	RJMP _0xEC
; 0000 004B  break;
; 0000 004C  case 4:
_0x1E:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x8
; 0000 004D  if(AnimSegFlag == 0)
	SBRC R2,0
	RJMP _0x28
; 0000 004E  {
; 0000 004F       PORTD = Segments[ForthVal];
	MOV  R30,R6
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_Segments)
	SBCI R31,HIGH(-_Segments)
	RJMP _0xED
; 0000 0050  }
; 0000 0051  else
_0x28:
; 0000 0052  {
; 0000 0053       PORTD = AnimSeg[AnimSegFrame];
	MOV  R30,R10
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_AnimSeg)
	SBCI R31,HIGH(-_AnimSeg)
_0xED:
	LD   R30,Z
	OUT  0x12,R30
; 0000 0054  }
; 0000 0055       FirstSeg  = 0;
	CBI  0x18,3
; 0000 0056       SecondSeg = 0;
	CBI  0x18,0
; 0000 0057       ThirdSeg  = 0;
	CBI  0x18,1
; 0000 0058       ForthSeg  = 1;
	SBI  0x18,2
; 0000 0059       TimeFlag  = 1;
	LDI  R30,LOW(1)
_0xEC:
	MOV  R9,R30
; 0000 005A 
; 0000 005B 
; 0000 005C  break;
; 0000 005D }
_0x8:
; 0000 005E 
; 0000 005F }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 0061 {
_timer1_ovf_isr:
; 0000 0062 // Place your code here
; 0000 0063 
; 0000 0064 
; 0000 0065 }
	RETI
;unsigned int read_adc(unsigned char adc_input)
; 0000 0067 {
_read_adc:
; 0000 0068 ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	OUT  0x7,R30
; 0000 0069 // Delay needed for the stabilization of the ADC input voltage
; 0000 006A delay_us(10);
	__DELAY_USB 27
; 0000 006B // Start the AD conversion
; 0000 006C ADCSRA|=0x40;
	SBI  0x6,6
; 0000 006D // Wait for the AD conversion to complete
; 0000 006E while ((ADCSRA & 0x10)==0);
_0x32:
	SBIS 0x6,4
	RJMP _0x32
; 0000 006F ADCSRA|=0x10;
	SBI  0x6,4
; 0000 0070 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	RJMP _0x2060002
; 0000 0071 }
;void         init()
; 0000 0073 {
_init:
; 0000 0074 
; 0000 0075 // Input/Output Ports initialization
; 0000 0076 // Port B initialization
; 0000 0077 // Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0078 // State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0079 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 007A DDRB=0x3F;
	LDI  R30,LOW(63)
	OUT  0x17,R30
; 0000 007B 
; 0000 007C // Port C initialization
; 0000 007D // Func6=In Func5=Out Func4=In Func3=In Func2=In Func1=Out Func0=Out
; 0000 007E // State6=T State5=0 State4=T State3=T State2=T State1=0 State0=0
; 0000 007F PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0080 DDRC=0x23;
	LDI  R30,LOW(35)
	OUT  0x14,R30
; 0000 0081 
; 0000 0082 // Port D initialization
; 0000 0083 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0084 // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0085 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0086 DDRD=0xFF;
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 0087 
; 0000 0088 // Timer/Counter 0 initialization
; 0000 0089 // Clock source: System Clock
; 0000 008A // Clock value: 125.000 kHz
; 0000 008B TCCR0=0x03;
	LDI  R30,LOW(3)
	OUT  0x33,R30
; 0000 008C TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 008D 
; 0000 008E // Timer/Counter 1 initialization
; 0000 008F // Clock source: System Clock
; 0000 0090 // Clock value: 7.813 kHz
; 0000 0091 // Mode: Normal top=0xFFFF
; 0000 0092 // OC1A output: Discon.
; 0000 0093 // OC1B output: Discon.
; 0000 0094 // Noise Canceler: Off
; 0000 0095 // Input Capture on Falling Edge
; 0000 0096 // Timer1 Overflow Interrupt: On
; 0000 0097 // Input Capture Interrupt: Off
; 0000 0098 // Compare A Match Interrupt: Off
; 0000 0099 // Compare B Match Interrupt: Off
; 0000 009A TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 009B TCCR1B=0x05;
	LDI  R30,LOW(5)
	OUT  0x2E,R30
; 0000 009C TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 009D TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 009E ICR1H=0x00;
	OUT  0x27,R30
; 0000 009F ICR1L=0x00;
	OUT  0x26,R30
; 0000 00A0 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00A1 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00A2 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00A3 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00A4 
; 0000 00A5 // Timer/Counter 2 initialization
; 0000 00A6 // Clock source: System Clock
; 0000 00A7 // Clock value: Timer2 Stopped
; 0000 00A8 // Mode: Normal top=0xFF
; 0000 00A9 // OC2 output: Disconnected
; 0000 00AA ASSR=0x00;
	OUT  0x22,R30
; 0000 00AB TCCR2=0x00;
	OUT  0x25,R30
; 0000 00AC TCNT2=0x00;
	OUT  0x24,R30
; 0000 00AD OCR2=0x00;
	OUT  0x23,R30
; 0000 00AE 
; 0000 00AF // External Interrupt(s) initialization
; 0000 00B0 // INT0: Off
; 0000 00B1 // INT1: Off
; 0000 00B2 MCUCR=0x00;
	OUT  0x35,R30
; 0000 00B3 
; 0000 00B4 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00B5 TIMSK=0x05;
	LDI  R30,LOW(5)
	OUT  0x39,R30
; 0000 00B6 
; 0000 00B7 // USART initialization
; 0000 00B8 // USART disabled
; 0000 00B9 UCSRB=0x00;
	LDI  R30,LOW(0)
	OUT  0xA,R30
; 0000 00BA 
; 0000 00BB // Analog Comparator initialization
; 0000 00BC // Analog Comparator: Off
; 0000 00BD // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 00BE ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00BF SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00C0 
; 0000 00C1 // ADC initialization
; 0000 00C2 // ADC Clock frequency: 1000.000 kHz
; 0000 00C3 // ADC Voltage Reference: AREF pin
; 0000 00C4 ADMUX=ADC_VREF_TYPE & 0xff;
	OUT  0x7,R30
; 0000 00C5 ADCSRA=0x83;
	LDI  R30,LOW(131)
	OUT  0x6,R30
; 0000 00C6 
; 0000 00C7 // SPI initialization
; 0000 00C8 // SPI disabled
; 0000 00C9 SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 00CA 
; 0000 00CB // TWI initialization
; 0000 00CC // TWI disabled
; 0000 00CD TWCR=0x00;
	OUT  0x36,R30
; 0000 00CE 
; 0000 00CF 
; 0000 00D0 // Global enable interrupts
; 0000 00D1 
; 0000 00D2 #asm("sei")
	sei
; 0000 00D3 }
	RET
;int          Convert(char n)
; 0000 00D5 {
_Convert:
; 0000 00D6 switch (n)
	ST   -Y,R26
;	n -> Y+0
	LD   R30,Y
	RCALL SUBOPT_0x0
; 0000 00D7 {
; 0000 00D8 case '0':
	CPI  R30,LOW(0x30)
	LDI  R26,HIGH(0x30)
	CPC  R31,R26
	BRNE _0x38
; 0000 00D9 return 0;break;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x2060002
; 0000 00DA 
; 0000 00DB case '1':
_0x38:
	CPI  R30,LOW(0x31)
	LDI  R26,HIGH(0x31)
	CPC  R31,R26
	BRNE _0x39
; 0000 00DC return 1;break;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x2060002
; 0000 00DD 
; 0000 00DE case '2':
_0x39:
	CPI  R30,LOW(0x32)
	LDI  R26,HIGH(0x32)
	CPC  R31,R26
	BRNE _0x3A
; 0000 00DF return 2;break;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RJMP _0x2060002
; 0000 00E0 
; 0000 00E1 case '3':
_0x3A:
	CPI  R30,LOW(0x33)
	LDI  R26,HIGH(0x33)
	CPC  R31,R26
	BRNE _0x3B
; 0000 00E2 return 3;break;
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RJMP _0x2060002
; 0000 00E3 
; 0000 00E4 case '4':
_0x3B:
	CPI  R30,LOW(0x34)
	LDI  R26,HIGH(0x34)
	CPC  R31,R26
	BRNE _0x3C
; 0000 00E5 return 4;break;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RJMP _0x2060002
; 0000 00E6 
; 0000 00E7 case '5':
_0x3C:
	CPI  R30,LOW(0x35)
	LDI  R26,HIGH(0x35)
	CPC  R31,R26
	BRNE _0x3D
; 0000 00E8 return 5;break;
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RJMP _0x2060002
; 0000 00E9 
; 0000 00EA case '6':
_0x3D:
	CPI  R30,LOW(0x36)
	LDI  R26,HIGH(0x36)
	CPC  R31,R26
	BRNE _0x3E
; 0000 00EB return 6;break;
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	RJMP _0x2060002
; 0000 00EC 
; 0000 00ED case '7':
_0x3E:
	CPI  R30,LOW(0x37)
	LDI  R26,HIGH(0x37)
	CPC  R31,R26
	BRNE _0x3F
; 0000 00EE return 7;break;
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	RJMP _0x2060002
; 0000 00EF 
; 0000 00F0 
; 0000 00F1 case '8':
_0x3F:
	CPI  R30,LOW(0x38)
	LDI  R26,HIGH(0x38)
	CPC  R31,R26
	BRNE _0x40
; 0000 00F2 return 8;break;
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RJMP _0x2060002
; 0000 00F3 
; 0000 00F4 case '9':
_0x40:
	CPI  R30,LOW(0x39)
	LDI  R26,HIGH(0x39)
	CPC  R31,R26
	BRNE _0x41
; 0000 00F5 return 9;break;
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	RJMP _0x2060002
; 0000 00F6 
; 0000 00F7 case ' ':
_0x41:
	CPI  R30,LOW(0x20)
	LDI  R26,HIGH(0x20)
	CPC  R31,R26
	BRNE _0x42
; 0000 00F8 return 10;break;
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RJMP _0x2060002
; 0000 00F9 
; 0000 00FA case '-':
_0x42:
	CPI  R30,LOW(0x2D)
	LDI  R26,HIGH(0x2D)
	CPC  R31,R26
	BRNE _0x37
; 0000 00FB return 11;break;
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
; 0000 00FC }
_0x37:
; 0000 00FD }
_0x2060002:
	ADIW R28,1
	RET
;void         Display(signed int value)
; 0000 00FF {
_Display:
; 0000 0100 char DispSeg[4];
; 0000 0101 sprintf(DispSeg,"%4d",value);
	RCALL SUBOPT_0x2
	SBIW R28,4
;	value -> Y+4
;	DispSeg -> Y+0
	MOVW R30,R28
	RCALL SUBOPT_0x3
	__POINTW1FN _0x0,0
	RCALL SUBOPT_0x3
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	RCALL __CWD1
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _sprintf
	ADIW R28,8
; 0000 0102 //if(DispSeg[3] == '1')ThirdVal = 1;
; 0000 0103 //else ThirdVal = 0;
; 0000 0104 FirstVal  = Convert(DispSeg[3]);
	LDD  R26,Y+3
	RCALL _Convert
	MOV  R5,R30
; 0000 0105 SecondVal = Convert(DispSeg[2]);
	LDD  R26,Y+2
	RCALL _Convert
	MOV  R4,R30
; 0000 0106 ThirdVal  = Convert(DispSeg[1]);
	LDD  R26,Y+1
	RCALL _Convert
	MOV  R7,R30
; 0000 0107 ForthVal  = Convert(DispSeg[0]);
	LD   R26,Y
	RCALL _Convert
	MOV  R6,R30
; 0000 0108 
; 0000 0109 }
	ADIW R28,6
	RET
;char         IncValue(char BaseValue,char WhichSeg)
; 0000 010B {
_IncValue:
; 0000 010C  char VirVal = BaseValue;
; 0000 010D  while(read_adc(SW_RST) > SW_RST_VAL)
	ST   -Y,R26
	ST   -Y,R17
;	BaseValue -> Y+2
;	WhichSeg -> Y+1
;	VirVal -> R17
	LDD  R17,Y+2
_0x44:
	RCALL SUBOPT_0x4
	BRLO _0x46
; 0000 010E  {
; 0000 010F   switch(WhichSeg)
	LDD  R30,Y+1
	RCALL SUBOPT_0x0
; 0000 0110   {
; 0000 0111    case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x4A
; 0000 0112    if(VirVal == 9) {VirVal = 0;} else {VirVal++;}
	CPI  R17,9
	BRNE _0x4B
	LDI  R17,LOW(0)
	RJMP _0x4C
_0x4B:
	SUBI R17,-1
_0x4C:
; 0000 0113    FirstVal = VirVal;
	MOV  R5,R17
; 0000 0114    break;
	RJMP _0x49
; 0000 0115    case 2:
_0x4A:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x4D
; 0000 0116    if(VirVal == 9) {VirVal = 0;} else {VirVal++;}
	CPI  R17,9
	BRNE _0x4E
	LDI  R17,LOW(0)
	RJMP _0x4F
_0x4E:
	SUBI R17,-1
_0x4F:
; 0000 0117    SecondVal = VirVal;
	MOV  R4,R17
; 0000 0118    break;
	RJMP _0x49
; 0000 0119    case 3:
_0x4D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x50
; 0000 011A    if(VirVal == 1) {VirVal = 0;} else {VirVal++;}
	CPI  R17,1
	BRNE _0x51
	LDI  R17,LOW(0)
	RJMP _0x52
_0x51:
	SUBI R17,-1
_0x52:
; 0000 011B    ThirdVal = VirVal;
	MOV  R7,R17
; 0000 011C    break;
	RJMP _0x49
; 0000 011D    case 4:
_0x50:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x49
; 0000 011E    ForthVal = VirVal;
	MOV  R6,R17
; 0000 011F    break;
; 0000 0120   }
_0x49:
; 0000 0121   delay_ms(300);
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
; 0000 0122  }
	RJMP _0x44
_0x46:
; 0000 0123  return VirVal;
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,3
	RET
; 0000 0124 }
;void         SetValue()
; 0000 0126 {
_SetValue:
; 0000 0127  //Display
; 0000 0128  int i=0;
; 0000 0129  char VirVal = 0;
; 0000 012A  DecimalPoint = 1 ;
	RCALL __SAVELOCR4
;	i -> R16,R17
;	VirVal -> R19
	RCALL SUBOPT_0x5
	LDI  R19,0
	LDI  R30,LOW(1)
	MOV  R8,R30
; 0000 012B  ForthVal = 10;
	RCALL SUBOPT_0x6
; 0000 012C  ThirdVal = 10;
	RCALL SUBOPT_0x7
; 0000 012D  SecondVal = 10;
	RCALL SUBOPT_0x8
; 0000 012E  FirstVal = 0;
	CLR  R5
; 0000 012F  Display(CounterValue);
	RCALL SUBOPT_0x9
	RCALL __EEPROMRDW
	RCALL SUBOPT_0xA
; 0000 0130  while(1)
_0x54:
; 0000 0131  {
; 0000 0132       //FirstVal
; 0000 0133       while(1)
_0x57:
; 0000 0134       {
; 0000 0135        if(FirstVal < 10) {VirVal = FirstVal;}else{VirVal = 0;}
	LDI  R30,LOW(10)
	CP   R5,R30
	BRSH _0x5A
	MOV  R19,R5
	RJMP _0x5B
_0x5A:
	LDI  R19,LOW(0)
_0x5B:
; 0000 0136        i=0;
	RCALL SUBOPT_0x5
; 0000 0137        while(i < DelayForBlinking)
_0x5C:
	RCALL SUBOPT_0xB
	BRGE _0x5E
; 0000 0138        {
; 0000 0139         FirstVal = SegOFF;
	LDI  R30,LOW(10)
	MOV  R5,R30
; 0000 013A         delay_ms(1); i++;
	RCALL SUBOPT_0xC
; 0000 013B         if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,1);}
	BRLO _0x5F
	RCALL SUBOPT_0xD
; 0000 013C         if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetSecondVal;}
_0x5F:
	RCALL SUBOPT_0xE
	BRSH _0x61
; 0000 013D        }
	RJMP _0x5C
_0x5E:
; 0000 013E 
; 0000 013F        i=0;
	RCALL SUBOPT_0x5
; 0000 0140        while(i < DelayForBlinking)
_0x62:
	RCALL SUBOPT_0xB
	BRGE _0x64
; 0000 0141        {
; 0000 0142         FirstVal = VirVal;
	MOV  R5,R19
; 0000 0143         delay_ms(1);i++;
	RCALL SUBOPT_0xC
; 0000 0144         if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,1);}
	BRLO _0x65
	RCALL SUBOPT_0xD
; 0000 0145         if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetSecondVal;}
_0x65:
	RCALL SUBOPT_0xE
	BRSH _0x61
; 0000 0146        }
	RJMP _0x62
_0x64:
; 0000 0147       }
	RJMP _0x57
; 0000 0148       //SecondVal
; 0000 0149       SetSecondVal :
_0x61:
; 0000 014A       FirstVal = VirVal;
	MOV  R5,R19
; 0000 014B       i = 0;
	RCALL SUBOPT_0x5
; 0000 014C       while(read_adc(SW_SEL) > SW_SEL_VAL)
_0x67:
	RCALL SUBOPT_0xE
	BRLO _0x69
; 0000 014D       {
; 0000 014E        delay_ms(1);
	RCALL SUBOPT_0xF
; 0000 014F        i++;
; 0000 0150        if(i > 500)
	__CPWRN 16,17,501
	BRLT _0x6A
; 0000 0151        {
; 0000 0152         goto End;
	RJMP _0x6B
; 0000 0153        }
; 0000 0154       }
_0x6A:
	RJMP _0x67
_0x69:
; 0000 0155 
; 0000 0156       Buzzer=1;
	RCALL SUBOPT_0x10
; 0000 0157       delay_ms(80);
; 0000 0158       Buzzer=0;
; 0000 0159       while(1)
_0x70:
; 0000 015A       {
; 0000 015B        if(SecondVal < 10) {VirVal = SecondVal;}else{VirVal = 0;}
	LDI  R30,LOW(10)
	CP   R4,R30
	BRSH _0x73
	MOV  R19,R4
	RJMP _0x74
_0x73:
	LDI  R19,LOW(0)
_0x74:
; 0000 015C        i=0;
	RCALL SUBOPT_0x5
; 0000 015D        while(i < DelayForBlinking)
_0x75:
	RCALL SUBOPT_0xB
	BRGE _0x77
; 0000 015E        {
; 0000 015F         SecondVal = SegOFF;
	RCALL SUBOPT_0x8
; 0000 0160         delay_ms(1); i++;
	RCALL SUBOPT_0xC
; 0000 0161         if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,2);}
	BRLO _0x78
	RCALL SUBOPT_0x11
; 0000 0162         if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetThirdVal;}
_0x78:
	RCALL SUBOPT_0xE
	BRSH _0x7A
; 0000 0163        }
	RJMP _0x75
_0x77:
; 0000 0164 
; 0000 0165        i=0;
	RCALL SUBOPT_0x5
; 0000 0166        while(i < DelayForBlinking)
_0x7B:
	RCALL SUBOPT_0xB
	BRGE _0x7D
; 0000 0167        {
; 0000 0168         SecondVal = VirVal;
	MOV  R4,R19
; 0000 0169         delay_ms(1);i++;
	RCALL SUBOPT_0xC
; 0000 016A         if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,2);}
	BRLO _0x7E
	RCALL SUBOPT_0x11
; 0000 016B         if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetThirdVal;}
_0x7E:
	RCALL SUBOPT_0xE
	BRSH _0x7A
; 0000 016C        }
	RJMP _0x7B
_0x7D:
; 0000 016D       }
	RJMP _0x70
; 0000 016E       //ThirdVal
; 0000 016F       SetThirdVal :
_0x7A:
; 0000 0170       SecondVal = VirVal;
	MOV  R4,R19
; 0000 0171       i = 0;
	RCALL SUBOPT_0x5
; 0000 0172       while(read_adc(SW_SEL) > SW_SEL_VAL)
_0x80:
	RCALL SUBOPT_0xE
	BRLO _0x82
; 0000 0173       {
; 0000 0174        delay_ms(1);
	RCALL SUBOPT_0xF
; 0000 0175        i++;
; 0000 0176        if(i > 300)
	__CPWRN 16,17,301
	BRGE _0x6B
; 0000 0177        {
; 0000 0178         goto End;
; 0000 0179        }
; 0000 017A       }
	RJMP _0x80
_0x82:
; 0000 017B       Buzzer=1;
	RCALL SUBOPT_0x10
; 0000 017C       delay_ms(80);
; 0000 017D       Buzzer=0;
; 0000 017E       while(1)
_0x88:
; 0000 017F       {
; 0000 0180        if(ThirdVal < 10) {VirVal = ThirdVal;}else{VirVal = 0;}
	LDI  R30,LOW(10)
	CP   R7,R30
	BRSH _0x8B
	MOV  R19,R7
	RJMP _0x8C
_0x8B:
	LDI  R19,LOW(0)
_0x8C:
; 0000 0181        i=0;
	RCALL SUBOPT_0x5
; 0000 0182        while(i < DelayForBlinking)
_0x8D:
	RCALL SUBOPT_0xB
	BRGE _0x8F
; 0000 0183        {
; 0000 0184         ThirdVal = SegOFF;
	RCALL SUBOPT_0x7
; 0000 0185         delay_ms(1); i++;
	RCALL SUBOPT_0xC
; 0000 0186         if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,3);}
	BRLO _0x90
	RCALL SUBOPT_0x12
; 0000 0187         if(read_adc(SW_SEL) > SW_SEL_VAL) {goto Again;}
_0x90:
	RCALL SUBOPT_0xE
	BRSH _0x92
; 0000 0188        }
	RJMP _0x8D
_0x8F:
; 0000 0189 
; 0000 018A        i=0;
	RCALL SUBOPT_0x5
; 0000 018B        while(i < DelayForBlinking)
_0x93:
	RCALL SUBOPT_0xB
	BRGE _0x95
; 0000 018C        {
; 0000 018D         ThirdVal = VirVal;
	MOV  R7,R19
; 0000 018E         delay_ms(1);i++;
	RCALL SUBOPT_0xC
; 0000 018F         if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,3);}
	BRLO _0x96
	RCALL SUBOPT_0x12
; 0000 0190         if(read_adc(SW_SEL) > SW_SEL_VAL) {goto Again;}
_0x96:
	RCALL SUBOPT_0xE
	BRSH _0x92
; 0000 0191        }
	RJMP _0x93
_0x95:
; 0000 0192       }
	RJMP _0x88
; 0000 0193       Again:
_0x92:
; 0000 0194       ThirdVal = VirVal;
	MOV  R7,R19
; 0000 0195       i = 0;
	RCALL SUBOPT_0x5
; 0000 0196       while(read_adc(SW_SEL) > SW_SEL_VAL)
_0x98:
	RCALL SUBOPT_0xE
	BRLO _0x9A
; 0000 0197       {
; 0000 0198        delay_ms(1);
	RCALL SUBOPT_0xF
; 0000 0199        i++;
; 0000 019A        if(i > 300)
	__CPWRN 16,17,301
	BRGE _0x6B
; 0000 019B        {
; 0000 019C         goto End;
; 0000 019D        }
; 0000 019E       }
	RJMP _0x98
_0x9A:
; 0000 019F       Buzzer=1;
	RCALL SUBOPT_0x10
; 0000 01A0       delay_ms(80);
; 0000 01A1       Buzzer=0;
; 0000 01A2  }
	RJMP _0x54
; 0000 01A3  End:
_0x6B:
; 0000 01A4  CounterValue  =  FirstVal;
	MOV  R30,R5
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x0
	RCALL __EEPROMWRW
; 0000 01A5  if(SecondVal < 10) CounterValue += (SecondVal*10);
	LDI  R30,LOW(10)
	CP   R4,R30
	BRSH _0xA0
	RCALL SUBOPT_0x9
	RCALL __EEPROMRDW
	MOVW R22,R30
	MOV  R26,R4
	LDI  R30,LOW(10)
	RCALL SUBOPT_0x13
; 0000 01A6  if(ThirdVal  < 10) CounterValue += (ThirdVal*100);
_0xA0:
	LDI  R30,LOW(10)
	CP   R7,R30
	BRSH _0xA1
	RCALL SUBOPT_0x14
	MOVW R22,R30
	MOV  R26,R7
	LDI  R30,LOW(100)
	RCALL SUBOPT_0x13
; 0000 01A7  Buzzer = 1;
_0xA1:
	SBI  0x15,1
; 0000 01A8  Display(CounterValue);
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0xA
; 0000 01A9  delay_ms(150);
	RCALL SUBOPT_0x15
; 0000 01AA  Buzzer = 0;
	CBI  0x15,1
; 0000 01AB  delay_ms(150);
	RCALL SUBOPT_0x15
; 0000 01AC  Buzzer = 1;
	SBI  0x15,1
; 0000 01AD  delay_ms(150);
	RCALL SUBOPT_0x15
; 0000 01AE  Buzzer = 0;
	CBI  0x15,1
; 0000 01AF  delay_ms(150);
	RCALL SUBOPT_0x15
; 0000 01B0  Buzzer = 1;
	SBI  0x15,1
; 0000 01B1  delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01B2  Buzzer = 0;
	CBI  0x15,1
; 0000 01B3  CheckCounterValue = 1;
	LDI  R30,LOW(1)
	STS  _CheckCounterValue,R30
; 0000 01B4  AnimationIsOn = 1;
	SET
	BLD  R2,1
; 0000 01B5 
; 0000 01B6 }
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
;void         StartCounting()
; 0000 01B8 {
_StartCounting:
; 0000 01B9  char EncoderCounter = 0;
; 0000 01BA  unsigned int BuzzDelay = 0;
; 0000 01BB  unsigned int DelayCounter = 0;
; 0000 01BC  unsigned int AnimDelayCounter = 0;
; 0000 01BD  AnimationIsOn = 0;
	SBIW R28,2
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	RCALL __SAVELOCR6
;	EncoderCounter -> R17
;	BuzzDelay -> R18,R19
;	DelayCounter -> R20,R21
;	AnimDelayCounter -> Y+6
	LDI  R17,0
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	CLT
	BLD  R2,1
; 0000 01BE  MainCounter  = 0;
	CLR  R12
	CLR  R13
; 0000 01BF  DecimalPoint = 1;
	LDI  R30,LOW(1)
	MOV  R8,R30
; 0000 01C0  while(1)
_0xAE:
; 0000 01C1  {
; 0000 01C2      if(CounterINTFlag == 0)
	TST  R11
	BRNE _0xB1
; 0000 01C3      {
; 0000 01C4       if(read_adc(2) > 400)
	LDI  R26,LOW(2)
	RCALL _read_adc
	CPI  R30,LOW(0x191)
	LDI  R26,HIGH(0x191)
	CPC  R31,R26
	BRLO _0xB2
; 0000 01C5       {
; 0000 01C6         if(EncoderCounter == EncoderSyncValue)
	CPI  R17,9
	BRNE _0xB3
; 0000 01C7         {
; 0000 01C8       MainCounter++;
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
; 0000 01C9       TotalCounter++;
	RCALL SUBOPT_0x16
	__SUBD1N -1
	RCALL __EEPROMWRD
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
; 0000 01CA       EncoderCounter = 0;
	LDI  R17,LOW(0)
; 0000 01CB      }
; 0000 01CC        else
	RJMP _0xB4
_0xB3:
; 0000 01CD        {
; 0000 01CE       EncoderCounter++;
	SUBI R17,-1
; 0000 01CF      }
_0xB4:
; 0000 01D0        Display(MainCounter);
	MOVW R26,R12
	RCALL _Display
; 0000 01D1        DecimalPoint = 1 ;
	LDI  R30,LOW(1)
	MOV  R8,R30
; 0000 01D2        CounterINTFlag = 1;
	MOV  R11,R30
; 0000 01D3        //LED = 1;
; 0000 01D4        //delay_ms(10);
; 0000 01D5        //LED = 0;
; 0000 01D6       }
; 0000 01D7      }
_0xB2:
; 0000 01D8      if((MainCounter >= CounterValue) && (CheckCounterValue == 1))
_0xB1:
	RCALL SUBOPT_0x14
	CP   R12,R30
	CPC  R13,R31
	BRLT _0xB6
	RCALL SUBOPT_0x17
	BREQ _0xB7
_0xB6:
	RJMP _0xB5
_0xB7:
; 0000 01D9      {
; 0000 01DA      Buzzer = 1;
	SBI  0x15,1
; 0000 01DB      RelayOut = 1;
	SBI  0x15,0
; 0000 01DC      DelayCounter++;
	__ADDWRN 20,21,1
; 0000 01DD       if(DelayCounter > 30500)
	__CPWRN 20,21,30501
	BRLO _0xBC
; 0000 01DE       {
; 0000 01DF        DelayCounter = 0;
	__GETWRN 20,21,0
; 0000 01E0        CheckCounterValue = 0;
	LDI  R30,LOW(0)
	STS  _CheckCounterValue,R30
; 0000 01E1        AnimSegFrame = 11;
	LDI  R30,LOW(11)
	MOV  R10,R30
; 0000 01E2        Buzzer = 0;
	CBI  0x15,1
; 0000 01E3       }
; 0000 01E4      }
_0xBC:
; 0000 01E5      else if ((MainCounter > CounterValue - 6) && (CheckCounterValue == 1))
	RJMP _0xBF
_0xB5:
	RCALL SUBOPT_0x14
	SBIW R30,6
	CP   R30,R12
	CPC  R31,R13
	BRGE _0xC1
	RCALL SUBOPT_0x17
	BREQ _0xC2
_0xC1:
	RJMP _0xC0
_0xC2:
; 0000 01E6      {
; 0000 01E7        LED = 1;
	SBI  0x15,5
; 0000 01E8        if(BuzzDelay < (400+(CounterValue - MainCounter)*200))
	RCALL SUBOPT_0x14
	SUB  R30,R12
	SBC  R31,R13
	LDI  R26,LOW(200)
	LDI  R27,HIGH(200)
	RCALL __MULW12
	SUBI R30,LOW(-400)
	SBCI R31,HIGH(-400)
	CP   R18,R30
	CPC  R19,R31
	BRSH _0xC5
; 0000 01E9        {
; 0000 01EA        BuzzDelay++;
	__ADDWRN 18,19,1
; 0000 01EB        }
; 0000 01EC        else
	RJMP _0xC6
_0xC5:
; 0000 01ED        {
; 0000 01EE        if(Buzzer ==1) {Buzzer = 0;}
	SBIS 0x15,1
	RJMP _0xC7
	CBI  0x15,1
; 0000 01EF        else           {Buzzer=1;}
	RJMP _0xCA
_0xC7:
	SBI  0x15,1
_0xCA:
; 0000 01F0        BuzzDelay = 0;
	__GETWRN 18,19,0
; 0000 01F1        }
_0xC6:
; 0000 01F2      }
; 0000 01F3   if(read_adc(2) < 400 )
_0xC0:
_0xBF:
	LDI  R26,LOW(2)
	RCALL _read_adc
	CPI  R30,LOW(0x190)
	LDI  R26,HIGH(0x190)
	CPC  R31,R26
	BRSH _0xCD
; 0000 01F4   {
; 0000 01F5      CounterINTFlag = 0;
	CLR  R11
; 0000 01F6   }
; 0000 01F7   if(read_adc(4) > 400) {delay_ms(100);break;}
_0xCD:
	RCALL SUBOPT_0x4
	BRLO _0xCE
	LDI  R26,LOW(100)
	RCALL SUBOPT_0x18
	RJMP _0xB0
; 0000 01F8   if(read_adc(3) > 150)
_0xCE:
	RCALL SUBOPT_0xE
	BRLO _0xCF
; 0000 01F9   {
; 0000 01FA   FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 11 ;ForthVal = 11; delay_ms(500);
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(11)
	RCALL SUBOPT_0x1B
; 0000 01FB   SetValue();
	RCALL _SetValue
; 0000 01FC   Display(MainCounter);
	MOVW R26,R12
	RCALL _Display
; 0000 01FD   }
; 0000 01FE    if(AnimationIsOn == 1)
_0xCF:
	SBRS R2,1
	RJMP _0xD0
; 0000 01FF   {
; 0000 0200    AnimSegFlag = 1;
	SET
	BLD  R2,0
; 0000 0201    AnimDelayCounter++;
	RCALL SUBOPT_0x1C
	ADIW R30,1
	RCALL SUBOPT_0x1D
; 0000 0202    if(AnimDelayCounter == 1000)
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRNE _0xD1
; 0000 0203    {
; 0000 0204     if(CheckCounterValue == 1)
	RCALL SUBOPT_0x17
	BRNE _0xD2
; 0000 0205     {
; 0000 0206      AnimSegFrame++;
	INC  R10
; 0000 0207      AnimDelayCounter = 0;
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
; 0000 0208      if(AnimSegFrame == 12)
	LDI  R30,LOW(12)
	CP   R30,R10
	BRNE _0xD3
; 0000 0209      {
; 0000 020A       AnimSegFrame = 0;
	CLR  R10
; 0000 020B      }
; 0000 020C     }
_0xD3:
; 0000 020D     else
	RJMP _0xD4
_0xD2:
; 0000 020E     {
; 0000 020F       AnimDelayCounter = 0;
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
; 0000 0210       if(AnimSegFrame == 11)AnimSegFrame = 12;
	LDI  R30,LOW(11)
	CP   R30,R10
	BRNE _0xD5
	LDI  R30,LOW(12)
	RJMP _0xEE
; 0000 0211       else AnimSegFrame = 11;
_0xD5:
	LDI  R30,LOW(11)
_0xEE:
	MOV  R10,R30
; 0000 0212     }
_0xD4:
; 0000 0213    }
; 0000 0214   }
_0xD1:
; 0000 0215  }
_0xD0:
	RJMP _0xAE
_0xB0:
; 0000 0216  LED = 0;
	CBI  0x15,5
; 0000 0217 }
	RCALL __LOADLOCR6
	ADIW R28,8
	RET
;void main(void)
; 0000 0219 {
_main:
; 0000 021A // Declare your local variables here
; 0000 021B FirstVal = 10 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10;
	LDI  R30,LOW(10)
	MOV  R5,R30
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x6
; 0000 021C init();
	RCALL _init
; 0000 021D // DDRC.1 = 0;   Buzzer OFF
; 0000 021E if(CounterValue == -1) CounterValue = 0;
	RCALL SUBOPT_0x14
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0xD9
	RCALL SUBOPT_0x9
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RCALL __EEPROMWRW
; 0000 021F if(TotalCounter == -1) TotalCounter = 0;
_0xD9:
	RCALL SUBOPT_0x16
	__CPD1N 0xFFFFFFFF
	BRNE _0xDA
	RCALL SUBOPT_0x1E
; 0000 0220 AnimationIsOn = 0;
_0xDA:
	CLT
	BLD  R2,1
; 0000 0221 while (1)
_0xDB:
; 0000 0222       {
; 0000 0223       DecimalPoint = 0;
	CLR  R8
; 0000 0224       CheckCounterValue = 0;
	LDI  R30,LOW(0)
	STS  _CheckCounterValue,R30
; 0000 0225       RelayOut = 0;
	CBI  0x15,0
; 0000 0226       Buzzer = 0;
	CBI  0x15,1
; 0000 0227       AnimSegFlag = 0;
	CLT
	BLD  R2,0
; 0000 0228       FirstVal = 10 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10;
	LDI  R30,LOW(10)
	MOV  R5,R30
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x6
; 0000 0229       Buzzer = 1;
	SBI  0x15,1
; 0000 022A       delay_ms(200);
	LDI  R26,LOW(200)
	RCALL SUBOPT_0x18
; 0000 022B       Buzzer = 0;
	CBI  0x15,1
; 0000 022C       //999000 Is End OF Counter
; 0000 022D       if(TotalCounter/100 > 9990)
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1F
	__CPD1N 0x2707
	BRLT _0xE6
; 0000 022E       {
; 0000 022F        Display(TotalCounter/100);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0xA
; 0000 0230        Buzzer = 1;
	SBI  0x15,1
; 0000 0231        delay_ms(5000);
	LDI  R26,LOW(5000)
	LDI  R27,HIGH(5000)
	RCALL _delay_ms
; 0000 0232        TotalCounter = 0;
	RCALL SUBOPT_0x1E
; 0000 0233        Buzzer = 0;
	CBI  0x15,1
; 0000 0234       }
; 0000 0235       Display(TotalCounter/100); delay_ms(500);
_0xE6:
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x20
; 0000 0236       FirstVal = 11 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10; delay_ms(500);
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x20
; 0000 0237       Display(TotalCounter/100); delay_ms(500);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x20
; 0000 0238       FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 10 ;ForthVal = 10; delay_ms(500);
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x1A
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x20
; 0000 0239       Display(TotalCounter/100); delay_ms(500);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x20
; 0000 023A       FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 11 ;ForthVal = 10; delay_ms(500);
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(11)
	MOV  R7,R30
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x20
; 0000 023B       Display(TotalCounter/100); delay_ms(500);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x20
; 0000 023C       FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 11 ;ForthVal = 11; delay_ms(500);
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(11)
	RCALL SUBOPT_0x1B
; 0000 023D       FirstVal = 0 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10;
	CLR  R5
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x6
; 0000 023E       StartCounting();
	RCALL _StartCounting
; 0000 023F       }
	RJMP _0xDB
; 0000 0240 }
_0xEB:
	RJMP _0xEB
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G100:
	RCALL SUBOPT_0x2
	RCALL __SAVELOCR2
	RCALL SUBOPT_0x21
	ADIW R26,2
	RCALL __GETW1P
	SBIW R30,0
	BREQ _0x2000010
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x22
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000012
	__CPWRN 16,17,2
	BRLO _0x2000013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2000012:
	RCALL SUBOPT_0x21
	ADIW R26,2
	RCALL SUBOPT_0x23
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
	RCALL SUBOPT_0x21
	RCALL __GETW1P
	TST  R31
	BRMI _0x2000014
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x23
_0x2000014:
_0x2000013:
	RJMP _0x2000015
_0x2000010:
	RCALL SUBOPT_0x21
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2000015:
	RCALL __LOADLOCR2
	ADIW R28,5
	RET
__print_G100:
	RCALL SUBOPT_0x2
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	RCALL SUBOPT_0x24
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	RCALL SUBOPT_0x24
	RJMP _0x20000C9
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	RCALL SUBOPT_0x25
	RCALL SUBOPT_0x26
	RCALL SUBOPT_0x25
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x27
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x1D
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x1D
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	RCALL SUBOPT_0x2A
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	RCALL SUBOPT_0x2A
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x2B
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	RCALL __ANEGW1
	RCALL SUBOPT_0x2B
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x2B
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	RCALL SUBOPT_0x24
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	RCALL SUBOPT_0x1C
	LPM  R18,Z+
	RCALL SUBOPT_0x2A
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	RCALL SUBOPT_0x24
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	RCALL SUBOPT_0x1C
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	RCALL SUBOPT_0x1C
	ADIW R30,2
	RCALL SUBOPT_0x2A
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	RCALL SUBOPT_0x2B
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CA
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CA:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0x27
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	RCALL SUBOPT_0x24
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x27
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000C9:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL __GETW1P
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR4
	RCALL SUBOPT_0x2C
	SBIW R30,0
	BRNE _0x2000072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2060001
_0x2000072:
	MOVW R26,R28
	ADIW R26,6
	RCALL __ADDW2R15
	MOVW R16,R26
	RCALL SUBOPT_0x2C
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __ADDW2R15
	RCALL __GETW1P
	RCALL SUBOPT_0x3
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	RCALL SUBOPT_0x3
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2060001:
	RCALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET

	.CSEG

	.CSEG
_strlen:
	RCALL SUBOPT_0x2
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
	RCALL SUBOPT_0x2
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
_Segments:
	.BYTE 0xC
_AnimSeg:
	.BYTE 0xD
_CheckCounterValue:
	.BYTE 0x1

	.ESEG
_TotalCounter:
	.DB  0x0,0x0,0x0,0x0
_CounterValue:
	.DB  0x0,0x0

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x0:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1:
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_Segments)
	SBCI R31,HIGH(-_Segments)
	LD   R30,Z
	OUT  0x12,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	ST   -Y,R27
	ST   -Y,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(4)
	RCALL _read_adc
	CPI  R30,LOW(0x191)
	LDI  R26,HIGH(0x191)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5:
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(10)
	MOV  R6,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(10)
	MOV  R7,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(10)
	MOV  R4,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(_CounterValue)
	LDI  R27,HIGH(_CounterValue)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xA:
	MOVW R26,R30
	RJMP _Display

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xB:
	__CPWRN 16,17,500
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0xC:
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	__ADDWRN 16,17,1
	RJMP SUBOPT_0x4

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	ST   -Y,R19
	LDI  R26,LOW(1)
	RCALL _IncValue
	MOV  R19,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:34 WORDS
SUBOPT_0xE:
	LDI  R26,LOW(3)
	RCALL _read_adc
	CPI  R30,LOW(0x97)
	LDI  R26,HIGH(0x97)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	__ADDWRN 16,17,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x10:
	SBI  0x15,1
	LDI  R26,LOW(80)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x15,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	ST   -Y,R19
	LDI  R26,LOW(2)
	RCALL _IncValue
	MOV  R19,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	ST   -Y,R19
	LDI  R26,LOW(3)
	RCALL _IncValue
	MOV  R19,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	MUL  R30,R26
	MOVW R30,R0
	ADD  R30,R22
	ADC  R31,R23
	RCALL SUBOPT_0x9
	RCALL __EEPROMWRW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	RCALL SUBOPT_0x9
	RCALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x15:
	LDI  R26,LOW(150)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x16:
	LDI  R26,LOW(_TotalCounter)
	LDI  R27,HIGH(_TotalCounter)
	RCALL __EEPROMRDD
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x17:
	LDS  R26,_CheckCounterValue
	CPI  R26,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x19:
	LDI  R30,LOW(11)
	MOV  R5,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	LDI  R30,LOW(11)
	MOV  R4,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	MOV  R7,R30
	LDI  R30,LOW(11)
	MOV  R6,R30
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1D:
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1E:
	LDI  R26,LOW(_TotalCounter)
	LDI  R27,HIGH(_TotalCounter)
	__GETD1N 0x0
	RCALL __EEPROMWRD
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x1F:
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x64
	RCALL __DIVD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x20:
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x21:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x22:
	ADIW R26,4
	RCALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x23:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x24:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x25:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x26:
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x27:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	RCALL SUBOPT_0x25
	RJMP SUBOPT_0x26

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x29:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	RJMP SUBOPT_0x22

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2A:
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	MOVW R26,R28
	ADIW R26,12
	RCALL __ADDW2R15
	RCALL __GETW1P
	RET


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

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__EEPROMRDD:
	ADIW R26,2
	RCALL __EEPROMRDW
	MOVW R22,R30
	SBIW R26,2

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

__EEPROMWRD:
	RCALL __EEPROMWRW
	ADIW R26,2
	MOVW R0,R30
	MOVW R30,R22
	RCALL __EEPROMWRW
	MOVW R30,R0
	SBIW R26,2
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

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
