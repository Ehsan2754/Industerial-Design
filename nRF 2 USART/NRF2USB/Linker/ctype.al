
AVRASM ver. 2.1.30  D:\MyProjects\SelfBalanceRobot\List\1.asm Sat Mar 09 07:33:57 2013

D:\MyProjects\SelfBalanceRobot\List\1.asm(1070): warning: Register r4 already defined by the .DEF directive
D:\MyProjects\SelfBalanceRobot\List\1.asm(1071): warning: Register r7 already defined by the .DEF directive
D:\MyProjects\SelfBalanceRobot\List\1.asm(1072): warning: Register r6 already defined by the .DEF directive
D:\MyProjects\SelfBalanceRobot\List\1.asm(1073): warning: Register r8 already defined by the .DEF directive
D:\MyProjects\SelfBalanceRobot\List\1.asm(1074): warning: Register r10 already defined by the .DEF directive
D:\MyProjects\SelfBalanceRobot\List\1.asm(1075): warning: Register r13 already defined by the .DEF directive
D:\MyProjects\SelfBalanceRobot\List\1.asm(1076): warning: Register r12 already defined by the .DEF directive
                 
                 
                 ;CodeVisionAVR C Compiler V2.05.3 Standard
                 ;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
                 ;http://www.hpinfotech.com
                 
                 ;Chip type                : ATmega8
                 ;Program type             : Application
                 ;Clock frequency          : 8.000000 MHz
                 ;Memory model             : Small
                 ;Optimize for             : Speed
                 ;(s)printf features       : float, width, precision
                 ;(s)scanf features        : int, width
                 ;External RAM size        : 0
                 ;Data Stack size          : 512 byte(s)
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
                 	.EQU __DSTACK_SIZE=0x0200
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
           
001b1a 1fff      	ROL  R31
001b1b 1f66      	ROL  R22
001b1c 957a      	DEC  R23
001b1d f243      	BRVS __DIVF217
                 __DIVF215:
001b1e de7f      	RCALL __ROUND_REPACK
001b1f 915f      	POP  R21
001b20 9508      	RET
                 
                 __CMPF12:
001b21 2399      	TST  R25
001b22 f09a      	BRMI __CMPF120
001b23 2377      	TST  R23
001b24 f042      	BRMI __C