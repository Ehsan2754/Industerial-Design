
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
	.DEF _CurrentPayLoad=R5
	.DEF _rx_wr_index=R4
	.DEF _rx_rd_index=R7
	.DEF _rx_counter=R6

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
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _usart_rx_isr
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

_0x5A:
	.DB  0xE7,0xE7,0xE7,0xE7,0xE7
_0x5B:
	.DB  0xD7,0xD7,0xD7,0xD7,0xD7
_0x5F:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
_0x0:
	.DB  0x4E,0x52,0x46,0x20,0x43,0x6F,0x6E,0x66
	.DB  0x69,0x67,0x20,0x73,0x74,0x61,0x72,0x74
	.DB  0x2E,0x2E,0x2E,0x0,0x50,0x69,0x6E,0x73
	.DB  0x20,0x67,0x65,0x74,0x20,0x63,0x6F,0x6E
	.DB  0x66,0x69,0x67,0x65,0x64,0x20,0x2E,0x2E
	.DB  0x2E,0x0,0x50,0x61,0x79,0x6C,0x6F,0x61
	.DB  0x64,0x20,0x4C,0x65,0x6E,0x20,0x45,0x72
	.DB  0x72,0x6F,0x72,0x0,0x52,0x32,0x54,0x20
	.DB  0x44,0x65,0x62,0x75,0x67,0x67,0x65,0x72
	.DB  0x20,0x57,0x69,0x72,0x65,0x6C,0x65,0x73
	.DB  0x73,0x20,0x4C,0x69,0x6E,0x6B,0x20,0x69
	.DB  0x6E,0x69,0x74,0x2E,0x2E,0x2E,0x0,0x57
	.DB  0x69,0x66,0x69,0x4C,0x69,0x6E,0x6B,0x20
	.DB  0x41,0x64,0x64,0x72,0x65,0x73,0x73,0x3A
	.DB  0x30,0x78,0x44,0x37,0x2C,0x30,0x78,0x44
	.DB  0x37,0x2C,0x30,0x78,0x44,0x37,0x2C,0x30
	.DB  0x78,0x44,0x37,0x2C,0x30,0x78,0x44,0x37
	.DB  0x0,0x57,0x69,0x66,0x69,0x4C,0x69,0x6E
	.DB  0x6B,0x20,0x43,0x68,0x61,0x6E,0x6E,0x65
	.DB  0x6C,0x3A,0x25,0x64,0x23,0x0,0x3C,0x3E
	.DB  0x2D,0x2D,0x2D,0x2D,0x2D,0x57,0x69,0x66
	.DB  0x69,0x4C,0x69,0x6E,0x6B,0x20,0x69,0x73
	.DB  0x20,0x61,0x63,0x74,0x69,0x76,0x61,0x74
	.DB  0x65,0x64,0x20,0x61,0x6E,0x64,0x20,0x72
	.DB  0x65,0x61,0x64,0x79,0x2D,0x2D,0x2D,0x2D
	.DB  0x2D,0x3C,0x3E,0x0,0x52,0x58,0x50,0x61
	.DB  0x79,0x6C,0x6F,0x61,0x64,0x20,0x6C,0x65
	.DB  0x6E,0x67,0x74,0x68,0x20,0x45,0x72,0x72
	.DB  0x6F,0x72,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x05
	.DW  _tx_address
	.DW  _0x5A*2

	.DW  0x05
	.DW  _rx_address
	.DW  _0x5B*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

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
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.3 Standard
;Automatic Program Generator
;© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 9/8/2013
;Author  : PerTic@n
;Company : If You Like This Software,Buy It
;Comments:
;
;
;Chip type               : ATmega8
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
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
;#include <stdlib.h>
;#include <string.h>
;#include <spi.h>
;
;/* NRF24L01+ Module */
;#define NRF_CE       PORTC.1
;#define NRF_CE_DDR   DDRC.1
;#define NRF_CSN      PORTC.0
;#define NRF_CSN_DDR  DDRC.0
;#include <R2T\hjnrf24l01p.h>
;#include <R2T\hjnrf24l01p.c>
;
;#ifndef __hjnrf24l01p_c_included__
;#define __hjnrf24l01p_c_included__
;#include <R2T_Debug.h>

	.CSEG
;	str -> Y+2
;	i -> R17
;	len -> R16
_SendDataNFixed:
	ST   -Y,R26
	RCALL __SAVELOCR2
;	str -> Y+3
;	fixedlen -> Y+2
;	i -> R17
;	len -> R16
	LDD  R16,Y+2
	LDI  R17,LOW(0)
_0x7:
	CP   R17,R16
	BRSH _0x8
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	RCALL SUBOPT_0x0
	RCALL _putchar
	SUBI R17,-1
	RJMP _0x7
_0x8:
	RCALL __LOADLOCR2
	ADIW R28,5
	RET
_SendData:
	RCALL SUBOPT_0x1
	RCALL __SAVELOCR2
;	i -> R17
;	len -> R16
	RCALL SUBOPT_0x2
	RCALL _strlenf
	MOV  R16,R30
	LDI  R17,LOW(0)
_0xA:
	CP   R17,R16
	BRSH _0xB
	RCALL SUBOPT_0x3
	LPM  R26,Z
	RCALL _putchar
	RCALL SUBOPT_0x4
	SUBI R17,-1
	RJMP _0xA
_0xB:
	LDI  R26,LOW(35)
	RCALL _putchar
	RCALL __LOADLOCR2
	RJMP _0x20C0003
_PcDbg:
	RCALL SUBOPT_0x1
	LDI  R26,LOW(47)
	RCALL _putchar
	LDI  R26,LOW(47)
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	RCALL _SendData
	LDI  R26,LOW(10)
	LDI  R27,0
	RCALL _delay_ms
	RJMP _0x20C0006
;#include <R2T\nrf24l01.h>
;#include <spi.h>
;       // Config SPI bus with these options
;      // SPI Type: Master
;      // SPI Clock Rate: 2000.000 kHz
;      // SPI Clock Phase: Cycle Start
;      // SPI Clock Polarity: Low
;      // SPI Data Order: MSB First
;
;char CurrentPayLoad;
;void nrf24_config(char channel)
; 0000 0025 {
_nrf24_config:
;    PcDbg("NRF Config start...");
	ST   -Y,R26
;	channel -> Y+0
	__POINTW2FN _0x0,0
	RCALL _PcDbg
;
;    NRF_CE = 0;       // Set CE Pin Low
	CBI  0x15,1
;    NRF_CE_DDR = 1;    //Set CE Pin as output
	SBI  0x14,1
;
;    NRF_CSN = 1;      // Set Chip Select High so it is not selected , if we want to write sth then we should set it LOW
	SBI  0x15,0
;    NRF_CSN_DDR = 1;  // Set CSN Pin as output
	SBI  0x14,0
;    PcDbg("Pins get configed ...");
	__POINTW2FN _0x0,20
	RCALL _PcDbg
;
;
;//------ MyNRF Configuration --------
;//TODO : nrf24_configRegister(CONFIG,((1<<EN_CRC)|(1<<CRCO)|(1<<RX_DR)|(1<<TX_DS))); // CRC Enabled , 2 Byte CRC,RX and TX Intrrupt OFF <>
;      nrf24_configRegister(CONFIG,((1<<EN_CRC)|(1<<CRCO)));
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(12)
	RCALL _nrf24_configRegister
;      nrf24_configRegister(EN_AA,(1<<ENAA_P0)|(1<<ENAA_P1)|(0<<ENAA_P2)|(0<<ENAA_P3)|(0<<ENAA_P4)|(0<<ENAA_P5)); // Enable Enhanced ShockBrust Auto Acknowledgement by ENAA_Px = 1
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x5
;      nrf24_configRegister(EN_RXADDR,(1<<ERX_P0)|(1<<ERX_P1)|(0<<ERX_P2)|(0<<ERX_P3)|(0<<ERX_P4)|(0<<ERX_P5));
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x5
;      nrf24_configRegister(SETUP_AW,0x03); // Default 5byte Address write , its removable if it was 0x03
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x5
;      nrf24_configRegister(SETUP_RETR,(0x05<<ARD)|(0x0E<<ARC));  // Delay between each AutoReTransmit is 1500us , 14 Retransmit
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R26,LOW(94)
	RCALL _nrf24_configRegister
;      nrf24_configRegister(RF_CH,channel);
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDD  R26,Y+1
	RCALL _nrf24_configRegister
;      nrf24_configRegister(RF_SETUP,(0<<RF_DR)|(3<<RF_PWR)); // Set RF_DR_High to 00 means 1Mbs <> RF_PWR Register set to 11 that means 0dbm at TX ouput
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R26,LOW(6)
	RCALL _nrf24_configRegister
;      nrf24_configRegister(RX_PW_P0, 0x00); // Auto-ACK pipe
	LDI  R30,LOW(17)
	RCALL SUBOPT_0x6
;      nrf24_configRegister(RX_PW_P1, 32); // Pipe length set to 20 however it not usable in DynamicPayload mode
	LDI  R30,LOW(18)
	ST   -Y,R30
	LDI  R26,LOW(32)
	RCALL _nrf                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
	RCALL _nrf24_rxFifoEmpty
	RCALL __LNEGB1
	RJMP _0x20C0004
;}
;/* Checks if receive FIFO is empty or not */
;char nrf24_rxFifoEmpty()
;{
_nrf24_rxFifoEmpty:
;    char fifoStatus;
;
;    nrf24_readRegister(FIFO_STATUS,&fifoStatus,1);
	ST   -Y,R17
;	fifoStatus -> R17
	LDI  R30,LOW(23)
	ST   -Y,R30
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x9
	PUSH R17
	LDI  R26,LOW(1)
	RCALL _nrf24_readRegister
	POP  R17
;
;    return (fifoStatus & (1 << RX_EMPTY));
	MOV  R30,R17
	ANDI R30,LOW(0x1)
	RJMP _0x20C0004
;}
;/* Reads payload bytes into data array */
;void nrf24_getData(char *data)
;{
_nrf24_getData:
;    /* Pull down chip select */
;    NRF_CSN = 0;
	RCALL SUBOPT_0x1
;	*data -> Y+0
	CBI  0x15,0
;
;    /* Send cmd to read rx payload */
;    spi(R_RX_PAYLOAD);
	LDI  R26,LOW(97)
	RCALL _spi
;
;    /* Read payload */
;    nrf24_transferSync(data,data,CurrentPayLoad);
	LD   R30,Y
	LDD  R31,Y+1
	RCALL SUBOPT_0x9
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	RCALL SUBOPT_0x9
	MOV  R26,R5
	RCALL _nrf24_transferSync
;
;    /* Pull up chip select */
;    NRF_CSN = 1;
	SBI  0x15,0
;
;    /* Reset status register */
;    nrf24_configRegister(STATUS,(1<<RX_DR));
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(64)
	RCALL _nrf24_configRegister
;}
_0x20C0006:
	ADIW R28,2
	RET
;// Sends a data package to the default address. Be sure to send the correct
;// amount of bytes as configured as payload on the receiver.
;void nrf24_send(char *value)
;{
;    /* Go to Standby-I first */
;    NRF_CE = 0;
;	*value -> Y+0
;
;    /* Set to transmitter mode , Power up if needed */
;    nrf24_powerUpTx();
;
;    /* Do we really need to flush TX fifo each time ? */
;    #if 1
;        /* Pull down chip select */
;        NRF_CSN = 0;
;        /* Write cmd to flush transmit FIFO */
;        spi(FLUSH_TX);
;        /* Pull up chip select */
;        NRF_CSN = 1;
;    #endif
;
;    /* Pull down chip select */
;     NRF_CSN = 0;
;    /* Write cmd to write payload */
;    spi(W_TX_PAYLOAD);
;    /* Write payload */
;    nrf24_transmitSync(value,strlen(value));
;   if(strlen(value) == 0 ) PcDbg("Payload Len Error");
;    /* Pull up chip select */
;    NRF_CSN = 1;
;    /* Start the transmission */
;    NRF_CE = 1;
;}
;char nrf24_isSending()
;{
;    char status;
;
;    /* read the current status */
;    status = nrf24_getStatus();
;	status -> R17
;
;    /* if sending successful (TX_DS) or max retries exceded (MAX_RT). */
;    if((status & ((1 << TX_DS)  | (1 << MAX_RT))))
;    {
;        return 0; /* false */
;    }
;
;    return 1; /* true */
;
;}
;char nrf24_getStatus()
;{
_nrf24_getStatus:
;    char rv;
;    NRF_CSN = 0;
	ST   -Y,R17
;	rv -> R17
	CBI  0x15,0
;    rv = spi(NOP);
_0x20C0005:
	LDI  R26,LOW(255)
	RCALL _spi
	MOV  R17,R30
;    NRF_CSN = 1;
	SBI  0x15,0
;    return rv;
	MOV  R30,R17
_0x20C0004:
	LD   R17,Y+
	RET
;}
;char nrf24_lastMessageStatus()
;{
;    char rv;
;
;    rv = nrf24_getStatus();
;	rv -> R17
;
;    /* Transmission went OK */
;    if((rv & ((1 << TX_DS))))
;    {
;        return NRF24_TRANSMISSON_OK;
;    }
;    /* Maximum retransmission count is reached */
;    /* Last message probably went missing ... */
;    else if((rv & ((1 << MAX_RT))))
;    {
;        return NRF24_MESSAGE_LOST;
;    }
;    /* Probably still sending ... */
;    else
;    {
;        return 0xFF;
;    }
;}
;void nrf24_powerUpRx()
;{
_nrf24_powerUpRx:
;    NRF_CSN = 0;
	CBI  0x15,0
;    spi(FLUSH_RX); // Clear NRF FiFo
	LDI  R26,LOW(226)
	RCALL _spi
;    NRF_CSN = 1;
	SBI  0x15,0
;    nrf24_configRegister(STATUS,(1<<RX_DR)|(1<<TX_DS)|(1<<MAX_RT));  // Disable the RX Fifo interuppt , TX Sent Intreuppt Flag , and maximum tried of sending intreuppt flag
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(112)
	RCALL _nrf24_configRegister
;    NRF_CE = 0;
	CBI  0x15,1
;    nrf24_configRegister(CONFIG,nrf24_CONFIG|((1<<PWR_UP)|(1<<PRIM_RX))); // Powerup the device and set it to PRX mode
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(11)
	RCALL _nrf24_configRegister
;    NRF_CE = 1;
	SBI  0x15,1
;}
	RET
;void nrf24_powerUpTx()
;{
;    nrf24_configRegister(STATUS,(1<<RX_DR)|(1<<TX_DS)|(1<<MAX_RT));
;
;    nrf24_configRegister(CONFIG,nrf24_CONFIG|((1<<PWR_UP)|(0<<PRIM_RX)));
;}
;/* Returns the number of retransmissions occured for the last message */
;char nrf24_retransmissionCount()
;{
;    char rv;
;    nrf24_readRegister(OBSERVE_TX,&rv,1);
;	rv -> R17
;    rv = rv & 0x0F;
;    return rv;
;}
;void nrf24_powerDown()
;{
;    NRF_CE = 0;
;    nrf24_configRegister(CONFIG,nrf24_CONFIG);
;}
;/* send and receive multiple bytes over SPI */
;void nrf24_transferSync(char *dataout,char *datain,char len)
;{
_nrf24_transferSync:
;    char i;
;
;    for(i=0;i<len;i++)
	ST   -Y,R26
	ST   -Y,R17
;	*dataout -> Y+4
;	*datain -> Y+2
;	len -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0x46:
	LDD  R30,Y+1
	CP   R17,R30
	BRSH _0x47
;    {
;        datain[i] = spi(dataout[i]);
	RCALL SUBOPT_0x3
	PUSH R31
	PUSH R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL SUBOPT_0x0
	RCALL _spi
	POP  R26
	POP  R27
	ST   X,R30
;    }
	SUBI R17,-1
	RJMP _0x46
_0x47:
;
;}
	LDD  R17,Y+0
	ADIW R28,6
	RET
;/* send multiple bytes over SPI */
;void nrf24_transmitSync(char *dataout,char len)
;{
_nrf24_transmitSync:
;   char i;
;
;    for(i=0;i<len;i++)
	ST   -Y,R26
	ST   -Y,R17
;	*dataout -> Y+2
;	len -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0x49:
	LDD  R30,Y+1
	CP   R17,R30
	BRSH _0x4A
;    {
;        spi(dataout[i]);
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x0
	RCALL _spi
;    }
	SUBI R17,-1
	RJMP _0x49
_0x4A:
;
;}
	LDD  R17,Y+0
	RJMP _0x20C0003
;/* Read multiple bytes from spi */
;void nrf24_readRegister(char reg, char *value, char len)
;{
_nrf24_readRegister:
;    NRF_CSN = 0;
	ST   -Y,R26
;	reg -> Y+3
;	*value -> Y+1
;	len -> Y+0
	CBI  0x15,0
;    spi(R_REGISTER | (REGISTER_MASK & reg));
	LDD  R30,Y+3
	ANDI R30,LOW(0x1F)
	MOV  R26,R30
	RCALL _spi
;    nrf24_transferSync(value,value,len);
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	RCALL SUBOPT_0x9
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	RCALL SUBOPT_0x9
	LDD  R26,Y+4
	RCALL _nrf24_transferSync
;    NRF_CSN = 1;
	RJMP _0x20C0002
;}
;/* Write to a single register of nrf24 */
;void nrf24_writeRegister(char reg, char *value, char len)
;{
_nrf24_writeRegister:
;    NRF_CSN = 0;
	ST   -Y,R26
;	reg -> Y+3
;	*value -> Y+1
;	len -> Y+0
	CBI  0x15,0
;    spi(W_REGISTER | (REGISTER_MASK & reg)); // Send Register addr
	LDD  R30,Y+3
	RCALL SUBOPT_0x8
;    nrf24_transmitSync(value,len);           // Send Data
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	RCALL SUBOPT_0x9
	LDD  R26,Y+2
	RCALL _nrf24_transmitSync
;    NRF_CSN = 1;
_0x20C0002:
	SBI  0x15,0
;}
_0x20C0003:
	ADIW R28,4
	RET
;#endif
;#include <R2T\nrf24l01.h>
;#include <R2T_Debug.h>
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;
;#ifndef TXB8
;#define TXB8 0
;#endif
;
;#ifndef UPE
;#define UPE 2
;#endif
;
;#ifndef DOR
;#define DOR 3
;#endif
;
;#ifndef FE
;#define FE 4
;#endif
;
;#ifndef UDRE
;#define UDRE 5
;#endif
;
;#ifndef RXC
;#define RXC 7
;#endif
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 8
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <= 256
;unsigned char rx_wr_index,rx_rd_index,rx_counter;
;#else
;unsigned int rx_wr_index,rx_rd_index,rx_counter;
;#endif
;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 005A {
_usart_rx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 005B char status,data;
; 0000 005C status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 005D data=UDR;
	IN   R16,12
; 0000 005E if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x53
; 0000 005F    {
; 0000 0060    rx_buffer[rx_wr_index++]=data;
	MOV  R30,R4
	INC  R4
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0000 0061 #if RX_BUFFER_SIZE == 256
; 0000 0062    // special case for receiver buffer size=256
; 0000 0063    if (++rx_counter == 0) rx_buffer_overflow=1;
; 0000 0064 #else
; 0000 0065    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDI  R30,LOW(8)
	CP   R30,R4
	BRNE _0x54
	CLR  R4
; 0000 0066    if (++rx_counter == RX_BUFFER_SIZE)
_0x54:
	INC  R6
	LDI  R30,LOW(8)
	CP   R30,R6
	BRNE _0x55
; 0000 0067       {
; 0000 0068       rx_counter=0;
	CLR  R6
; 0000 0069       rx_buffer_overflow=1;
	SET
	BLD  R2,0
; 0000 006A       }
; 0000 006B #endif
; 0000 006C    }
_0x55:
; 0000 006D }
_0x53:
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0074 {
; 0000 0075 char data;
; 0000 0076 while (rx_counter==0);
;	data -> R17
; 0000 0077 data=rx_buffer[rx_rd_index++];
; 0000 0078 #if RX_BUFFER_SIZE != 256
; 0000 0079 if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0000 007A #endif
; 0000 007B #asm("cli")
; 0000 007C --rx_counter;
; 0000 007D #asm("sei")
; 0000 007E return data;
; 0000 007F }
;#pragma used-
;#endif
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// SPI functions
;#include <spi.h>
;
;// Declare your global variables here
;char tx_address[5] = {0xE7,0xE7,0xE7,0xE7,0xE7};

	.DSEG
;char rx_address[5] = {0xD7,0xD7,0xD7,0xD7,0xD7};
;void init()
; 0000 008D {

	.CSEG
_init:
; 0000 008E // Declare your local variables here
; 0000 008F 
; 0000 0090 // Input/Output Ports initialization
; 0000 0091 // Port B initialization
; 0000 0092 // Func7=In Func6=In Func5=Out Func4=In Func3=Out Func2=Out Func1=In Func0=In
; 0000 0093 // State7=T State6=T State5=0 State4=T State3=0 State2=0 State1=T State0=T
; 0000 0094 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0095 DDRB=0x2C;
	LDI  R30,LOW(44)
	OUT  0x17,R30
; 0000 0096 
; 0000 0097 // Port C initialization
; 0000 0098 // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=Out
; 0000 0099 // State6=T State5=T State4=T State3=T State2=T State1=0 State0=0
; 0000 009A PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 009B DDRC=0x03;
	LDI  R30,LOW(3)
	OUT  0x14,R30
; 0000 009C 
; 0000 009D // Port D initialization
; 0000 009E // Func7=In Func6=In Func5=In Func4=Out Func3=Out Func2=In Func1=In Func0=In
; 0000 009F // State7=T State6=T State5=T State4=0 State3=0 State2=T State1=T State0=T
; 0000 00A0 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 00A1 DDRD=0x18;
	LDI  R30,LOW(24)
	OUT  0x11,R30
; 0000 00A2 
; 0000 00A3 // Timer/Counter 0 initialization
; 0000 00A4 // Clock source: System Clock
; 0000 00A5 // Clock value: Timer 0 Stopped
; 0000 00A6 TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 00A7 TCNT0=0x00;
	OUT  0x32,R30
; 0000 00A8 
; 0000 00A9 // Timer/Counter 1 initialization
; 0000 00AA // Clock source: System Clock
; 0000 00AB // Clock value: Timer1 Stopped
; 0000 00AC // Mode: Normal top=0xFFFF
; 0000 00AD // OC1A output: Discon.
; 0000 00AE // OC1B output: Discon.
; 0000 00AF // Noise Canceler: Off
; 0000 00B0 // Input Capture on Falling Edge
; 0000 00B1 // Timer1 Overflow Interrupt: Off
; 0000 00B2 // Input Capture Interrupt: Off
; 0000 00B3 // Compare A Match Interrupt: Off
; 0000 00B4 // Compare B Match Interrupt: Off
; 0000 00B5 TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 00B6 TCCR1B=0x00;
	OUT  0x2E,R30
; 0000 00B7 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 00B8 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 00B9 ICR1H=0x00;
	OUT  0x27,R30
; 0000 00BA ICR1L=0x00;
	OUT  0x26,R30
; 0000 00BB OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00BC OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00BD OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00BE OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00BF 
; 0000 00C0 // Timer/Counter 2 initialization
; 0000 00C1 // Clock source: System Clock
; 0000 00C2 // Clock value: Timer2 Stopped
; 0000 00C3 // Mode: Normal top=0xFF
; 0000 00C4 // OC2 output: Disconnected
; 0000 00C5 ASSR=0x00;
	OUT  0x22,R30
; 0000 00C6 TCCR2=0x00;
	OUT  0x25,R30
; 0000 00C7 TCNT2=0x00;
	OUT  0x24,R30
; 0000 00C8 OCR2=0x00;
	OUT  0x23,R30
; 0000 00C9 
; 0000 00CA // External Interrupt(s) initialization
; 0000 00CB // INT0: Off
; 0000 00CC // INT1: Off
; 0000 00CD MCUCR=0x00;
	OUT  0x35,R30
; 0000 00CE 
; 0000 00CF // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00D0 TIMSK=0x00;
	OUT  0x39,R30
; 0000 00D1 
; 0000 00D2 //// USART initialization
; 0000 00D3 //// Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00D4 //// USART Receiver: On
; 0000 00D5 //// USART Transmitter: On
; 0000 00D6 //// USART Mode: Asynchronous
; 0000 00D7 //// USART Baud Rate: 115200
; 0000 00D8 //UCSRA=0x00;
; 0000 00D9 //UCSRB=0x98;
; 0000 00DA //UCSRC=0x86;
; 0000 00DB //UBRRH=0x00;
; 0000 00DC //UBRRL=0x03;
; 0000 00DD // USART initialization
; 0000 00DE // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00DF // USART Receiver: On
; 0000 00E0 // USART Transmitter: On
; 0000 00E1 // USART Mode: Asynchronous
; 0000 00E2 // USART Baud Rate: 9600
; 0000 00E3 UCSRA=0x00;
	OUT  0xB,R30
; 0000 00E4 UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 00E5 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 00E6 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 00E7 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 00E8 // Analog Comparator initialization
; 0000 00E9 // Analog Comparator: Off
; 0000 00EA // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 00EB ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00EC SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00ED 
; 0000 00EE // ADC initialization
; 0000 00EF // ADC disabled
; 0000 00F0 ADCSRA=0x00;
	OUT  0x6,R30
; 0000 00F1 
; 0000 00F2 // SPI initialization
; 0000 00F3 // SPI Type: Master
; 0000 00F4 // SPI Clock Rate: 2000.000 kHz
; 0000 00F5 // SPI Clock Phase: Cycle Start
; 0000 00F6 // SPI Clock Polarity: Low
; 0000 00F7 // SPI Data Order: MSB First
; 0000 00F8 SPCR=0x50;
	LDI  R30,LOW(80)
	OUT  0xD,R30
; 0000 00F9 SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0000 00FA 
; 0000 00FB // TWI initialization
; 0000 00FC // TWI disabled
; 0000 00FD TWCR=0x00;
	OUT  0x36,R30
; 0000 00FE 
; 0000 00FF // Global enable interrupts
; 0000 0100 #asm("sei")
	sei
; 0000 0101 }
	RET
;void main(void)
; 0000 0103 {
_main:
; 0000 0104       init();
	RCALL _init
; 0000 0105       PcDbg("R2T Debugger Wireless Link init...");
	__POINTW2FN _0x0,60
	RCALL _PcDbg
; 0000 0106       nrf24_config(DebugChannel);
	LDI  R26,LOW(1)
	RCALL _nrf24_config
; 0000 0107       nrf24_tx_address(tx_address);
	LDI  R26,LOW(_tx_address)
	LDI  R27,HIGH(_tx_address)
	RCALL _nrf24_tx_address
; 0000 0108       nrf24_rx_address(rx_address);
	LDI  R26,LOW(_rx_address)
	LDI  R27,HIGH(_rx_address)
	RCALL _nrf24_rx_address
; 0000 0109       PcDbg("WifiLink Address:0xD7,0xD7,0xD7,0xD7,0xD7");
	__POINTW2FN _0x0,95
	RCALL _PcDbg
; 0000 010A       printf("WifiLink Channel:%d#");
	__POINTW1FN _0x0,137
	RCALL SUBOPT_0x9
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
; 0000 010B       PcDbg("<>-----WifiLink is activated and ready-----<>");
	__POINTW2FN _0x0,158
	RCALL _PcDbg
; 0000 010C 
; 0000 010D while (1)
_0x5C:
; 0000 010E       {
; 0000 010F       // Place your code here
; 0000 0110         char str[32] = "";
; 0000 0111         if(nrf24_dataReady())
	SBIW R28,32
	LDI  R24,32
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x5F*2)
	LDI  R31,HIGH(_0x5F*2)
	RCALL __INITLOCB
;	str -> Y+0
	RCALL _nrf24_dataReady
	CPI  R30,0
	BREQ _0x60
; 0000 0112         {
; 0000 0113          PORTD.3 = 1;
	SBI  0x12,3
; 0000 0114          CurrentPayLoad = nrf24_dynamicpayload_length();
	RCALL _nrf24_dynamicpayload_length
	MOV  R5,R30
; 0000 0115          if(CurrentPayLoad > 32)PcDbg("RXPayload length Error");
	LDI  R30,LOW(32)
	CP   R30,R5
	BRSH _0x63
	__POINTW2FN _0x0,204
	RCALL _PcDbg
; 0000 0116          nrf24_getData(str);
_0x63:
	MOVW R26,R28
	RCALL _nrf24_getData
; 0000 0117          SendDataNFixed(str,CurrentPayLoad);
	MOVW R30,R28
	RCALL SUBOPT_0x9
	MOV  R26,R5
	RCALL _SendDataNFixed
; 0000 0118          PORTD.3 = 0;
	CBI  0x12,3
; 0000 0119         }
; 0000 011A         nrf24_powerUpRx();
_0x60:
	RCALL _nrf24_powerUpRx
; 0000 011B         delay_ms(1);
	RCALL SUBOPT_0x4
; 0000 011C         PORTD.4 = 1;
	SBI  0x12,4
; 0000 011D 
; 0000 011E //        /* Automatically goes to TX mode */
; 0000 011F //        nrf24_send(str);
; 0000 0120 //
; 0000 0121 //        /* Wait for transmission to end */
; 0000 0122 //        while(nrf24_isSending());
; 0000 0123 //
; 0000 0124 //        //ToDO : NRF_CE = 0;
; 0000 0125 //        /* Make analysis on last tranmission attempt */
; 0000 0126 //        temp = nrf24_lastMessageStatus();
; 0000 0127 //
; 0000 0128 //        if(temp == NRF24_TRANSMISSON_OK)
; 0000 0129 //        {
; 0000 012A //            PcDbg("Transmision done.");
; 0000 012B //        }
; 0000 012C //        else if(temp == NRF24_MESSAGE_LOST)
; 0000 012D //        {
; 0000 012E //            PcDbg("Message is lost.");
; 0000 012F //        }
; 0000 0130 //
; 0000 0131 //		/* Retranmission count indicates the tranmission quality */
; 0000 0132 //		temp = nrf24_retransmissionCount();
; 0000 0133 //		if (temp > 0) printf("> Retranmission count: %d#",temp);
; 0000 0134 //
; 0000 0135 //		/* Optionally, go back to RX mode ... */
; 0000 0136 //		//nrf24_powerUpRx();
; 0000 0137 //
; 0000 0138 //		/* Or you might want to power down after TX */
; 0000 0139 //		// nrf24_powerDown();
; 0000 013A //
; 0000 013B //		/* Wait a little ... */
; 0000 013C //		delay_ms(100);
; 0000 013D       }
	ADIW R28,32
	RJMP _0x5C
; 0000 013E }
_0x68:
	RJMP _0x68
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
_putchar:
	ST   -Y,R26
putchar0:
     sbis usr,udre
     rjmp putchar0
     ld   r30,y
     out  udr,r30
	RJMP _0x20C0001
_put_usart_G100:
	RCALL SUBOPT_0x1
	LDD  R26,Y+2
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	ADIW R28,3
	RET
__print_G100:
	RCALL SUBOPT_0x1
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
	RCALL SUBOPT_0xA
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	RCALL SUBOPT_0xA
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
	RJMP _0x200001Bn d o w s   I n s t a l l e r .   D u   m Â s t e   i n s t a l l e r a   e t t   W i n d o w s   S e r v i c e   P a c k   s o m   i n n e h Â l l e r   e n   n y a r e   v e r s i o n   a v   t j ‰ n s t e n   W i n d o w s   I n s t a l l e r .         y E t t   a n n a t   p r o g r a m   i n s t a l l e r a s .   V ‰ n t a   t i l l s   a t t   i n s t a l l a t i o n e n   ‰ r   s l u t f ˆ r d   o c h   f ˆ r s ˆ k   s e d a n   i n s t a l l e r a   d e t t a   p r o g r a m   i g e n .   I n s t a l l a t i o n s p a k e t e t   k u n d e   i n t e   ˆ p p n a s .   B e k r ‰ f t a   a t t   p a k e t e t   f i n n s   o c h   a t t   d u   k a n   k o m m a   Â t   d e t ,   e l l e r   k o n t a k t a   p r o g r a m v a r u f ˆ r s ‰ l j a r e n   f ˆ r   a t t   b e k r ‰ f t a   a t t   d e t   ‰ r   e t t   g i l t i g t   p a k e t   f ˆ r   W i n d o w s   I n s t a l l e r . å I n s t a l l a t i o n s p a k e t e t   k u n d e   i n t e   ˆ p p n a s .   K o n t a k t a   p r o g r a m v a r u f ˆ r s ‰ l j a r e n   f ˆ r   a t t   b e k r ‰ f t a   a t t   d e t   ‰ r   e t t   g i l t i g t   p a k e t   f ˆ r   W i n d o w s   I n s t a l l e r . q D e t   u p p s t o d   e t t   f e l   d Â   a n v ‰ n d a r g r ‰ n s s n i t t e t   f ˆ r   t j ‰ n s t e n   W i n d o w s   I n s t a l l e r   s t a r t a d e s .   K o n t a k t a   s u p p o r t p e r s o n a l e n . î D e t   u p p s t o d   e t t   f e l   d Â   l o g g f i l e n   f ˆ r   i n s t a l l a t i o n e n   ˆ p p n a d e s .   B e k r ‰ f t a   a t t   d e n   a n g i v n a   p l a t s e n   f ˆ r   l o g g f i l e n   f i n n s   o c h   a t t   d e n   i n t e   ‰ r   s k r i v s k y d d a d . 6 I n s t a l l a t i o n s p a k e t e t s   s p r Â k   s t ˆ d s   i n t e   a v   d i t t   s y s t e m . m D e t   u p p s t o d   e t t   f e l   d Â   t r a n s f o r m a t i o n e r   a n v ‰ n d e s .   B e k r ‰ f t a   a t t   d e n   a n g i v n a   t r a n s f o r m a t i o n s s ˆ k v ‰ g e n   ‰ r   g i l t i g . T S y s t e m a d m i n i s t r a t ˆ r e n   h a r   a n g e t t   s y s t e m p r i n c i p e r   s o m   h i n d r a r   d e n   h ‰ r   i n s t a l l a t i o n e n .           J T j ‰ n s t e n   W i n d o w s   I n s t a l l e r   k u n d e   i n t e   s t a r t a s .   K o n t a k t a   s u p p o r t p e r s o n a l e n . PAò T e m p - m a p p e n   f i n n s   p Â   e n   e n h e t   s o m   ‰ r   f u l l   e l l e r   s o m   i n t e   k a n   n Â s .   F r i g ˆ r   u t r y m m e   p Â   e n h e t e n   e l l e r   k o n t r o l l e r a   a t t   d u   h a r   s k r i v r ‰ t t i g h e t e r   i   T e m p - m a p p e n . c I n s t a l l a t i o n s p a k e t e t   s t ˆ d s   i n t e   a v   d e n   h ‰ r   p r o c e s s o r t y p e n .   K o n t a k t a   Â t e r f ˆ r s ‰ l j a r e n   a v   m a s k i n v a r a n .   – K o r r i g e r i n g s p a k e t e t   k u n d e   i n t e   ˆ p p n a s .   B e k r ‰ f t a   a t t   d e t   f i n n s   o c h   a t t   d u   k a n   k o m m a   Â t   d e t   e l l e r   k o n t a k t a   p r o g r a m v a r u f ˆ r s ‰ l j a r e n   f ˆ r   a t t   b e k r ‰ f t a   a t t   d e t   ‰ r   e t t   g i l t i g t   k o r r i g e r i n g s p a k e t   f ˆ r   W i n d o w s   I n s t a l l e r . ô K o r r i g e r i n g s p a k e t e t   k u n d e   i n t e   ˆ p p n a s .   K o n t a k t a   p r o g r a m v a r u f ˆ r s ‰ l j a r e n   f ˆ r   a t t   b e k r ‰ f t a   a t t   d e t t a   ‰ r   e t t   g i l t i g t   k o r r i g e r i n g s p a k e t   f ˆ r   W i n d o w s   I n s t a l l e r . µ D e t   h ‰ r   k o r r i g e r i n g s p a k e t e t   k a n   i n t e   k ˆ r a s   a v   t j ‰ n s t e n   W i n d o w s   I n s t a l l e r .   D u   m Â s t e   i n s t a l l e r a   e t t   W i n d o w s   S e r v i c e   P a c k   s o m   i n n e h Â l l e r   e n   n y a r e   v e r s i o n   a v   t j ‰ n s t e n   W i n d o w s   I n s t a l l e r . ¸ E n   a n n a n   v e r s i o n   a v   d e t   h ‰ r   p r o g r a m m e t   ‰ r   r e d a n   i n s t a l l e r a d .   I n s t a l l a t i o n e n   a v   d e n   h ‰ r   v e r s i o n e n   k a n   i n t e   f o r t s ‰ t t a .   O m   d u   v i l l   k o n f i g u r e r a   e l l e r   t a   b o r t   d e n   b e f i n t l i g a   v e r s i o n e n   a v   p r o d u k t e n   k a n   d u   a n v ‰ n d a   L ‰ g g   t i l l / t a   b o r t   p r o g r a m   p Â   K o n t r o l l p a n e l e n . d O g i l t i g t   k o m m a d o r a d s a r g u m e n t .   M e r   i n f o r m a t i o n   o m   k o m m a n d o r a d s a r g u m e n t   f i n n s   i   W i n d o w s   I n s t a l l e r   S D K . Û E n d a s t   a d m i n i s t r a t ˆ r e r   h a r   b e h ˆ r i g h e t   a t t   l ‰ g g a   t i l l ,   t a   b o r t   e l l e r   k o n f i g u r e r a   s e r v e r p r o g r a m v a r a   u n d e r   e n   T e r m i n a l   S e r v i c e s - f j ‰ r r s e s s i o n .   K o n t a k t a   n ‰ t v e r k s a d m i n i s t r a t ˆ r e n   o m   d u   v i l l   i n s t a l l e r a   e l l e r   k o n f i g u r e r a   p r o g r a m v a r a   p Â   d e n   h ‰ r   s e r v e r n .   ,D e t   g Â r   i n t e   a t t   i n s t a l l e r a   k o r r i g e r i n g s f i l e n   f ˆ r   u p p g r a d e r i n g   p Â   g r u n d   a v   a t t   p r o g r a m m e t   s o m   s k a   u p p g r a d e r a s   k a n s k e   s a k n a s   e l l e r   o c k s Â   h a r   k o r r i g e r i n g s f i l e n   s k a p a t s   f ˆ r   e n   a n n a n   v e r s i o n   a v   p r o g r a m m e t .   K o n t r o l l e r a   a t t   p r o g r a m m e t   s o m   s k a   u p p g r a d e r a s   ‰ r   i n s t a l l e r a t   o c h   a t t   d u   h a r   r ‰ t t   k o r r i g e r i n g s f i l . A K o r r i g e r i n g s p a k e t e t   t i l l Â t s   i n t e   a v   p r o g r a m b e g r ‰ n s n i n g s p r i n c i p e n . H E n   e l l e r   f l e r   a n p a s s n i n g a r   t i l l Â t s   i n t e   a v   p r o g r a m b e g r ‰ n s n i n g s p r i n c i p e n . R T h e   W i n d o w s   I n s t a l l e r   t i l l Â t e r   i n t e   i n s t a l l a t i o n   v i a   e n   f j ‰ r r s k r i v b o r d s a n s l u t n i n g . % K o r r i g e r i n g e n   k a n   i n t e   a v i n s t a l l e r a s . 3 K o r r i g e r i n g e n   ‰ r   i n t e   a v s e d d   f ˆ r   d e n   h ‰ r   p r o d u k t e n . PA2 I n g e n   g i l t i g   s e k v e n s   h i t t a d e s   f ˆ r   k o r r i g e r i n g a r n a . 1 E n   p r i n c i p   f ˆ r h i n d r a r   a t t   k o r r i g e r i n g e n   t a s   b o r t . & X M L - d a t a   o m   k o r r i g e r i n g e n   ‰ r   f e l a k t i g . ß W i n d o w s   I n s t a l l e r   t i l l Â t e r   i n t e   a t t   h a n t e r a d e ,   a n n o n s e r a d e   p r o d u k t e r   k o r r i g e r a s .   M i n s t   e n   f u n k t i o n   i   p r o d u k t e n   m Â s t e   i n s t a l l e r a s   i n n a n   d u   k a n   i n s t a l l e r a   k o r r i g e r i n g e n . Õ T j ‰ n s t e n   W i n d o w s   I n s t a l l e r   ‰ r   i n t e   t i l l g ‰ n g l i g   i   s ‰ k e r t   l ‰ g e .   F ˆ r s ˆ k   i g e n   n ‰ r   d a t o r n   i n t e   ‰ r   i   s ‰ k e r t   l ‰ g e   e l l e r   a n v ‰ n d   S y s t e m Â t e r s t ‰ l l n i n g   f ˆ r   a t t   Â t e r s t ‰ l l a   d a t o r n   t i l l   e t t   t i d i g a r e   f u n g e r a n d e   t i l l s t Â n d . A F l e r p a k e t s t r a n s a k t i o n e r   k a n   i n t e   k ˆ r a s   o m   Â n g r i n g   ‰ r   a v a k t i v e r a d .                        Ë  Ì  $  Ô    Ù  Ù      '  '  ¸-  0'  1'  .  ]+  ]+  ,.  %,  H,  <.  â,  í,  |0  Ï,  Ô,  1  Q-  X-  \1  µ-  ‘-  ‹1  .  .  ‹3  }.  ¢.  L4   N  7N  ¨6  @N  AN  8>  mR  mR  ?  5S  XS  @  ôS  ¢S  l\  ¸S  ˇS   i  aT  kT  Ùm  ≈T  ÂT  Ë{  )U  /U  ‘ö  çU  ≤U  †  1u  wu  ê∆    % 1  
     ƒ  I d e n t i f i e r i n g e n   a v   p r o d u k t e n   % 1 ,   f u n k t i o n e n   % 2   m i s s l y c k a d e s   u n d e r   b e g ‰ r a n   f ˆ r   k o m p o n e n t e n   % 3  
     ¥  E t t   o v ‰ n t a t   v ‰ r d e   h i t t a d e s   e l l e r   e t t   v ‰ r d e   ( n a m n :   % 1 ,   v ‰ r d e :   % 2 )   s a k n a s   i   n y c k e l n   % 3  
     ®  E n   o v ‰ n t a d   u n d e r n y c k e l   h i t t a d e s   e l l e r   o c k s Â   s a k n a s   u n d e r n y c k e l n   % 1   i   n y c k e l n   % 2  
   ÿ  I d e n t i f i e r i n g e n   a v   p r o d u k t e n   % 1 ,   f u n k t i o n e n   % 2   o c h   k o m p o n e n t e n   % 3   m i s s l y c k a d e s .   R e s u r s e n   % 4   f i n n s   i n t e .  
   »  W i n d o w s   I n s t a l l e r   b e g ‰ r d e   e n   o m s t a r t   a v   d a t o r n   f ˆ r   a t t   s l u t f ˆ r a   e l l e r   f o r t s ‰ t t a   k o n f i g u r e r a   % 1 .  
   Ï I n s t a l l a t i o n e n   a v   % 1   t i l l Â t s   i n t e   a v   e n   p r o g r a m b e g r ‰ n s n i n g s p r i n c i p .   W i n d o w s   I n s t a l l e r   t i l l Â t e r   e n d a s t   a t t   o b e g r ‰ n s a d e   o b j e k t   i n s t a l l e r a s .   D e n   a u k t o r i s e r i n g s n i v Â   s o m   r e t u r n e r a d e s   a v   p r o g r a m b e g r ‰ n s n i n g s p r i n c i p e n   a v   % 2   ( r e t u r n e r a d   s t a t u s :   % 3 ) .  
     4 I n s t a l l a t i o n e n   a v   % 1   t i l l Â t s   i n t e   p Â   g r u n d   a v   a t t   e t t   f e l   u p p s t o d   n ‰ r   p r o g r a m b e g r ‰ n s n i n g s p r i n c i p e n   b e h a n d l a d e s .   O b j e k t e t   k a n   i n t e   a n s e s   v a r a   b e t r o t t .  
     D e n   h ‰ r   W i n d o w s - v e r s i o n e n   s t ˆ d e r   i n t e   a t t   6 4 - b i t a r s p a k e t   d i s t r i b u e r a s .   S k r i p t e t   % 1   ‰ r   a v s e t t   f ˆ r   e t t   6 4 - b i t a r s p a k e t  
     % 1  
     î  P r o x y i n f o r m a t i o n   f ˆ r   W i n d o w s   I n s t a l l e r   h a r   i n t e   r e g i s t r e r a t s   k o r r e k t  
     h  D e t   g i c k   i n t e   a t t   a n s l u t a   t i l l   s e r v e r n .   F e l :   % 1  
   d D e t   g i c k   i n t e   a t t   t a   b o r t   p r o d u k t e n   % 