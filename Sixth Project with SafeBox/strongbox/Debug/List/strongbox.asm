
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 1.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

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
	.EQU __SRAM_END=0x085F
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
	.DEF _total_number=R4
	.DEF _total_number_msb=R5
	.DEF _a=R6
	.DEF _a_msb=R7
	.DEF _b=R8
	.DEF _b_msb=R9
	.DEF _c=R10
	.DEF _c_msb=R11
	.DEF _d=R12
	.DEF _d_msb=R13

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
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_Pattern:
	.DB  0xFE,0x0,0xFD,0x0,0xFB,0x0,0xF7,0x0
_key_number:
	.DB  0x7,0x0,0x8,0x0,0x9,0x0,0x4,0x0
	.DB  0x5,0x0,0x6,0x0,0x1,0x0,0x2,0x0
	.DB  0x3,0x0,0xB,0x0,0x0,0x0,0xA,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x1,0x0

_0x0:
	.DB  0x2A,0x0,0x2A,0x2A,0x0,0x2A,0x2A,0x2A
	.DB  0x0,0x2A,0x2A,0x2A,0x2A,0x0,0x79,0x6F
	.DB  0x75,0x72,0x20,0x70,0x61,0x73,0x73,0x20
	.DB  0x69,0x73,0x0,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x63,0x6F,0x72,0x72,0x65,0x63,0x74
	.DB  0x0,0x6F,0x70,0x65,0x6E,0x21,0x0,0x20
	.DB  0x20,0x20,0x20,0x69,0x6E,0x63,0x6F,0x72
	.DB  0x72,0x65,0x63,0x74,0x0,0x65,0x6E,0x74
	.DB  0x65,0x72,0x20,0x70,0x61,0x73,0x73,0x77
	.DB  0x6F,0x72,0x64,0x0,0x72,0x65,0x73,0x65
	.DB  0x74,0x20,0x70,0x61,0x73,0x73,0x0,0x65
	.DB  0x6E,0x74,0x65,0x72,0x20,0x6F,0x6C,0x64
	.DB  0x20,0x70,0x61,0x73,0x73,0x3A,0x0,0x70
	.DB  0x61,0x73,0x73,0x20,0x63,0x6F,0x72,0x72
	.DB  0x65,0x63,0x74,0x0,0x65,0x6E,0x74,0x65
	.DB  0x72,0x20,0x6E,0x65,0x77,0x20,0x70,0x61
	.DB  0x73,0x73,0x20,0x3A,0x0,0x6E,0x65,0x77
	.DB  0x20,0x70,0x61,0x73,0x73,0x20,0x69,0x73
	.DB  0x20,0x3A,0x20,0x0,0x70,0x61,0x73,0x73
	.DB  0x20,0x69,0x6E,0x63,0x6F,0x72,0x72,0x65
	.DB  0x63,0x74,0x0,0x70,0x6C,0x65,0x61,0x73
	.DB  0x65,0x20,0x72,0x65,0x70,0x65,0x61,0x74
	.DB  0x0,0x43,0x6C,0x6F,0x73,0x65,0x20,0x21
	.DB  0x0,0x45,0x6E,0x74,0x65,0x72,0x20,0x50
	.DB  0x61,0x73,0x73,0x77,0x6F,0x72,0x64,0x3A
	.DB  0x0
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x02
	.DW  _0x19
	.DW  _0x0*2

	.DW  0x03
	.DW  _0x19+2
	.DW  _0x0*2+2

	.DW  0x04
	.DW  _0x19+5
	.DW  _0x0*2+5

	.DW  0x05
	.DW  _0x19+9
	.DW  _0x0*2+9

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

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
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

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

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;
;Project : strongbox
;Date    : 12/20/2021
;Author  : Sadra.Termehbaf & Shervin Khalili
;
;
;Chip type               : ATmega32
;Program type            : Application
;AVR Core Clock frequency: 1.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32.h>
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
;#include <stdlib.h>
;// Alphanumeric LCD functions
;#include <alcd.h>
;
; //Declare your global variables here
;flash int Pattern[4]={0xFE, 0xFD, 0xFB, 0xF7};
;flash int key_number [4][3]={{7,8,9},{4,5,6},{1,2,3},{11,0,10}};
;int total_number=1 , a , b , c , d ;
;char password[4];
;int y11,y12,y13,y14,y15;
;int my_password=0000;
;int key(void)
; 0000 001E {

	.CSEG
_key:
; .FSTART _key
; 0000 001F     while(1)
_0x3:
; 0000 0020     {   int j, column = 3;
; 0000 0021 
; 0000 0022           for( j=0; j<4; j++)
	SBIW R28,4
	LDI  R30,LOW(3)
	ST   Y,R30
	LDI  R30,LOW(0)
	STD  Y+1,R30
;	j -> Y+2
;	column -> Y+0
	STD  Y+2,R30
	STD  Y+2+1,R30
_0x7:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,4
	BRGE _0x8
; 0000 0023           {
; 0000 0024              PORTD = Pattern[j];
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDI  R26,LOW(_Pattern*2)
	LDI  R27,HIGH(_Pattern*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	LPM  R0,Z
	OUT  0x12,R0
; 0000 0025 
; 0000 0026              if (PIND.4 == 0)
	SBIC 0x10,4
	RJMP _0x9
; 0000 0027              {
; 0000 0028                column  = 0;
	LDI  R30,LOW(0)
	STD  Y+0,R30
	STD  Y+0+1,R30
; 0000 0029                while (PIND.4 == 0) {};
_0xA:
	SBIS 0x10,4
	RJMP _0xA
; 0000 002A                break;
	RJMP _0x8
; 0000 002B              }
; 0000 002C              else
_0x9:
; 0000 002D                  if (PIND.5 == 0)
	SBIC 0x10,5
	RJMP _0xE
; 0000 002E                  {
; 0000 002F                    column  = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0030                    while (PIND.5 == 0) {};
_0xF:
	SBIS 0x10,5
	RJMP _0xF
; 0000 0031                    break;
	RJMP _0x8
; 0000 0032                  }
; 0000 0033                  else
_0xE:
; 0000 0034                      if (PIND.6 == 0)
	SBIC 0x10,6
	RJMP _0x13
; 0000 0035                      {
; 0000 0036                        column  = 2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0037                        while (PIND.6 == 0) {};
_0x14:
	SBIS 0x10,6
	RJMP _0x14
; 0000 0038                        break;
	RJMP _0x8
; 0000 0039                      }
; 0000 003A 
; 0000 003B              }
_0x13:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
	RJMP _0x7
_0x8:
; 0000 003C 
; 0000 003D               if (column != 3)
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,3
	BREQ _0x17
; 0000 003E                   return key_number[j][column];
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(6)
	CALL __MULB1W2U
	SUBI R30,LOW(-_key_number*2)
	SBCI R31,HIGH(-_key_number*2)
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETW1PF
	ADIW R28,4
	RET
; 0000 003F 
; 0000 0040 
; 0000 0041     }
_0x17:
	ADIW R28,4
	RJMP _0x3
; 0000 0042 }
; .FEND
;void amaliat (int y)
; 0000 0044 {
_amaliat:
; .FSTART _amaliat
; 0000 0045     if(total_number==1)
	ST   -Y,R27
	ST   -Y,R26
;	y -> Y+0
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x18
; 0000 0046     {
; 0000 0047         y11=y;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _y11,R30
	STS  _y11+1,R31
; 0000 0048         total_number++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 0049         a = y ;
	__GETWRS 6,7,0
; 0000 004A         lcd_clear();
	CALL _lcd_clear
; 0000 004B         lcd_puts("*");
	__POINTW2MN _0x19,0
	CALL _lcd_puts
; 0000 004C     }
; 0000 004D         else if(total_number==2)
	RJMP _0x1A
_0x18:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x1B
; 0000 004E         {
; 0000 004F             y12=y;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _y12,R30
	STS  _y12+1,R31
; 0000 0050             total_number++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 0051             b = y ;
	__GETWRS 8,9,0
; 0000 0052             lcd_clear();
	CALL _lcd_clear
; 0000 0053             lcd_puts("**");
	__POINTW2MN _0x19,2
	CALL _lcd_puts
; 0000 0054         }
; 0000 0055         else if(total_number==3)
	RJMP _0x1C
_0x1B:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x1D
; 0000 0056         {
; 0000 0057             y13=y;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _y13,R30
	STS  _y13+1,R31
; 0000 0058             total_number++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 0059             c = y ;
	__GETWRS 10,11,0
; 0000 005A             lcd_clear();
	CALL _lcd_clear
; 0000 005B             lcd_puts("***");
	__POINTW2MN _0x19,5
	CALL _lcd_puts
; 0000 005C         }
; 0000 005D         else if(total_number==4)
	RJMP _0x1E
_0x1D:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R4
	CPC  R31,R5
	BREQ PC+2
	RJMP _0x1F
; 0000 005E         {
; 0000 005F             y14=y;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _y14,R30
	STS  _y14+1,R31
; 0000 0060             total_number=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R4,R30
; 0000 0061             d = y ;
	__GETWRS 12,13,0
; 0000 0062             lcd_clear();
	CALL _lcd_clear
; 0000 0063             lcd_puts("****");
	__POINTW2MN _0x19,9
	CALL SUBOPT_0x0
; 0000 0064             delay_ms(1000);
; 0000 0065             lcd_clear();
; 0000 0066             itoa( a , password ) ; lcd_puts(password);
	ST   -Y,R7
	ST   -Y,R6
	CALL SUBOPT_0x1
; 0000 0067             itoa( b , password ) ; lcd_puts(password);
	ST   -Y,R9
	ST   -Y,R8
	CALL SUBOPT_0x1
; 0000 0068             itoa( c , password ) ; lcd_puts(password);
	ST   -Y,R11
	ST   -Y,R10
	CALL SUBOPT_0x1
; 0000 0069             itoa( d , password ) ; lcd_puts(password);
	ST   -Y,R13
	ST   -Y,R12
	LDI  R26,LOW(_password)
	LDI  R27,HIGH(_password)
	CALL _itoa
	LDI  R26,LOW(_password)
	LDI  R27,HIGH(_password)
	CALL SUBOPT_0x0
; 0000 006A             delay_ms(1000);
; 0000 006B             lcd_clear();
; 0000 006C             y15=y11*1000+y12*100+y13*10+y14;
	LDS  R30,_y11
	LDS  R31,_y11+1
	CALL SUBOPT_0x2
	LDS  R30,_y12
	LDS  R31,_y12+1
	CALL SUBOPT_0x3
	LDS  R30,_y13
	LDS  R31,_y13+1
	CALL SUBOPT_0x4
	LDS  R26,_y14
	LDS  R27,_y14+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _y15,R30
	STS  _y15+1,R31
; 0000 006D             if(y15==my_password)
	LDS  R30,_my_password
	LDS  R31,_my_password+1
	LDS  R26,_y15
	LDS  R27,_y15+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x20
; 0000 006E             {
; 0000 006F                 lcd_gotoxy(0,0);
	CALL SUBOPT_0x5
; 0000 0070                 lcd_putsf("your pass is");
; 0000 0071                 lcd_gotoxy(0,1);
; 0000 0072                 lcd_putsf("      correct");
	__POINTW2FN _0x0,27
	CALL SUBOPT_0x6
; 0000 0073                 delay_ms(1000);
; 0000 0074                 lcd_clear();
; 0000 0075                 lcd_putsf("open!");
	__POINTW2FN _0x0,41
	CALL _lcd_putsf
; 0000 0076                 PORTC.0 = 0;
	CBI  0x15,0
; 0000 0077                 delay_ms(1000);
	RJMP _0x4B
; 0000 0078                 lcd_clear();
; 0000 0079             }
; 0000 007A             else
_0x20:
; 0000 007B             {
; 0000 007C                 lcd_gotoxy(0,0);
	CALL SUBOPT_0x5
; 0000 007D                 lcd_putsf("your pass is");
; 0000 007E                 lcd_gotoxy(0,1);
; 0000 007F                 lcd_putsf("    incorrect");
	__POINTW2FN _0x0,47
	CALL _lcd_putsf
; 0000 0080                 delay_ms(1000);
_0x4B:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 0081                 lcd_clear();
	CALL _lcd_clear
; 0000 0082             }
; 0000 0083         };
_0x1F:
_0x1E:
_0x1C:
_0x1A:
; 0000 0084 }
	JMP  _0x20A0003
; .FEND

	.DSEG
_0x19:
	.BYTE 0xE
;void main(void)
; 0000 0086 {

	.CSEG
_main:
; .FSTART _main
; 0000 0087 // Declare your local variables here
; 0000 0088      int y;
; 0000 0089      int y1,y2,y3,y4,y5;
; 0000 008A      int i=1;
; 0000 008B      char aray[];
; 0000 008C      int y6,y7,y8,y9,y10;
; 0000 008D // Input/Output Ports initialization
; 0000 008E // Port A initialization
; 0000 008F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0090 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,18
	LDI  R30,LOW(1)
	STD  Y+10,R30
	LDI  R30,LOW(0)
	STD  Y+11,R30
;	y -> R16,R17
;	y1 -> R18,R19
;	y2 -> R20,R21
;	y3 -> Y+16
;	y4 -> Y+14
;	y5 -> Y+12
;	i -> Y+10
;	aray -> Y+10
;	y6 -> Y+8
;	y7 -> Y+6
;	y8 -> Y+4
;	y9 -> Y+2
;	y10 -> Y+0
	OUT  0x1A,R30
; 0000 0091 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0092 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0093 
; 0000 0094 // Port B initialization
; 0000 0095 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0096 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0097 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0098 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0099 
; 0000 009A // Port C initialization
; 0000 009B // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=Out
; 0000 009C DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(1)
	OUT  0x14,R30
; 0000 009D // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=0
; 0000 009E PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 009F 
; 0000 00A0 // Port D initialization
; 0000 00A1 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 00A2 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(15)
	OUT  0x11,R30
; 0000 00A3 // State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 00A4 PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(240)
	OUT  0x12,R30
; 0000 00A5 
; 0000 00A6 // Alphanumeric LCD initialization
; 0000 00A7 // Connections are specified in the
; 0000 00A8 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 00A9 // RS - PORTA Bit 0
; 0000 00AA // RD - PORTA Bit 1
; 0000 00AB // EN - PORTA Bit 2
; 0000 00AC // D4 - PORTA Bit 4
; 0000 00AD // D5 - PORTA Bit 5
; 0000 00AE // D6 - PORTA Bit 6
; 0000 00AF // D7 - PORTA Bit 7
; 0000 00B0 // Characters/line: 16
; 0000 00B1 lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 00B2 PORTC.0 = 1;
	SBI  0x15,0
; 0000 00B3 lcd_putsf("enter password");
	__POINTW2FN _0x0,61
	CALL _lcd_putsf
; 0000 00B4 
; 0000 00B5 while (1)
_0x26:
; 0000 00B6       {
; 0000 00B7       // Place your code here
; 0000 00B8         y = key();
	RCALL _key
	MOVW R16,R30
; 0000 00B9         if(y == 10){i++;delay_ms(100);}
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x29
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0000 00BA         up2:
_0x29:
_0x2A:
; 0000 00BB         while(i%4==0)
_0x2B:
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL __MODW21
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2D
; 0000 00BC         {
; 0000 00BD             lcd_clear();
	CALL _lcd_clear
; 0000 00BE             lcd_putsf("reset pass");
	__POINTW2FN _0x0,76
	CALL SUBOPT_0x6
; 0000 00BF             delay_ms(1000);
; 0000 00C0             lcd_clear();
; 0000 00C1             lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0000 00C2             up:
_0x2E:
; 0000 00C3             lcd_putsf("enter old pass:");
	__POINTW2FN _0x0,87
	CALL SUBOPT_0x8
; 0000 00C4             lcd_gotoxy(0,1);
; 0000 00C5 
; 0000 00C6             y1=key();if(y1==10){i=0;goto up2;}itoa(y1,aray);lcd_puts(aray);delay_ms(200);
	MOVW R18,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CP   R30,R18
	CPC  R31,R19
	BRNE _0x2F
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x2F:
	ST   -Y,R19
	ST   -Y,R18
	CALL SUBOPT_0x9
; 0000 00C7             y2=key();if(y2==10){i=0;goto up2;}itoa(y2,aray);lcd_puts(aray);delay_ms(200);
	MOVW R20,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x30
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x30:
	ST   -Y,R21
	ST   -Y,R20
	CALL SUBOPT_0x9
; 0000 00C8             y3=key();if(y3==10){i=0;goto up2;}itoa(y3,aray);lcd_puts(aray);delay_ms(200);
	STD  Y+16,R30
	STD  Y+16+1,R31
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	SBIW R26,10
	BRNE _0x31
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x31:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	CALL SUBOPT_0xA
; 0000 00C9             y4=key();if(y4==10){i=0;goto up2;}itoa(y4,aray);lcd_puts(aray);delay_ms(200);
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,10
	BRNE _0x32
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x32:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CALL SUBOPT_0xB
; 0000 00CA             y5=y1*1000+y2*100+y3*10+y4;
	MOVW R30,R18
	CALL SUBOPT_0x2
	MOVW R30,R20
	CALL SUBOPT_0x3
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	CALL SUBOPT_0x4
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+12,R30
	STD  Y+12+1,R31
; 0000 00CB 
; 0000 00CC             if(y5==my_password)
	LDS  R30,_my_password
	LDS  R31,_my_password+1
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CP   R30,R26
	CPC  R31,R27
	BREQ PC+2
	RJMP _0x33
; 0000 00CD             {
; 0000 00CE                 lcd_clear();
	CALL _lcd_clear
; 0000 00CF                 lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0000 00D0                 lcd_putsf("pass correct");
	__POINTW2FN _0x0,103
	CALL SUBOPT_0x6
; 0000 00D1                 delay_ms(1000);
; 0000 00D2                 lcd_clear();
; 0000 00D3                 lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0000 00D4                 lcd_putsf("enter new pass :");
	__POINTW2FN _0x0,116
	CALL SUBOPT_0x8
; 0000 00D5                 lcd_gotoxy(0,1);
; 0000 00D6 
; 0000 00D7                 y6=key();if(y6==10){i=0;goto up2;}itoa(y6,aray);lcd_puts(aray);delay_ms(200);
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,10
	BRNE _0x34
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x34:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	CALL SUBOPT_0xA
; 0000 00D8                 y7=key();if(y7==10){i=0;goto up2;}itoa(y7,aray);lcd_puts(aray);delay_ms(200);
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,10
	BRNE _0x35
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x35:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0xA
; 0000 00D9                 y8=key();if(y8==10){i=0;goto up2;}itoa(y8,aray);lcd_puts(aray);delay_ms(200);
	STD  Y+4,R30
	STD  Y+4+1,R31
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,10
	BRNE _0x36
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x36:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0xA
; 0000 00DA                 y9=key();if(y9==10){i=0;goto up2;}itoa(y9,aray);lcd_puts(aray);delay_ms(200);
	STD  Y+2,R30
	STD  Y+2+1,R31
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,10
	BRNE _0x37
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	RJMP _0x2A
_0x37:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CALL SUBOPT_0xB
; 0000 00DB                 y10=y6*1000+y7*100+y8*10+y9;
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	CALL SUBOPT_0x2
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x3
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x4
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R30,R26
	ADC  R31,R27
	ST   Y,R30
	STD  Y+1,R31
; 0000 00DC                 my_password=y10;
	STS  _my_password,R30
	STS  _my_password+1,R31
; 0000 00DD                 lcd_clear();
	CALL _lcd_clear
; 0000 00DE                 lcd_gotoxy(0,0);lcd_putsf("new pass is : ");
	CALL SUBOPT_0x7
	__POINTW2FN _0x0,133
	CALL _lcd_putsf
; 0000 00DF                 lcd_gotoxy(0,1);itoa(y10,aray);lcd_puts(aray);delay_ms(1000);
	CALL SUBOPT_0xC
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,12
	CALL _itoa
	MOVW R26,R28
	ADIW R26,10
	CALL SUBOPT_0x0
; 0000 00E0                 lcd_clear();
; 0000 00E1                 i=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+10,R30
	STD  Y+10+1,R31
; 0000 00E2             }
; 0000 00E3             else
	RJMP _0x38
_0x33:
; 0000 00E4             {
; 0000 00E5                 lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0000 00E6                 lcd_putsf("pass incorrect");
	__POINTW2FN _0x0,148
	CALL _lcd_putsf
; 0000 00E7                 delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 00E8                 lcd_gotoxy(0,1);
	CALL SUBOPT_0xC
; 0000 00E9                 lcd_putsf("please repeat");
	__POINTW2FN _0x0,163
	CALL SUBOPT_0x6
; 0000 00EA                 delay_ms(1000);
; 0000 00EB                 lcd_clear();
; 0000 00EC                 goto up;
	RJMP _0x2E
; 0000 00ED             }
_0x38:
; 0000 00EE       }
	RJMP _0x2B
_0x2D:
; 0000 00EF 
; 0000 00F0         switch(y){
	MOVW R30,R16
; 0000 00F1          case 11:   {lcd_gotoxy(0,1);lcd_putsf("Close !");PORTC.0 = 1;
	CPI  R30,LOW(0xB)
	LDI  R26,HIGH(0xB)
	CPC  R31,R26
	BRNE _0x3C
	CALL SUBOPT_0xC
	__POINTW2FN _0x0,177
	CALL _lcd_putsf
	SBI  0x15,0
; 0000 00F2              delay_ms(1000);lcd_clear();lcd_putsf("Enter Password:"); }
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
	CALL _lcd_clear
	__POINTW2FN _0x0,185
	CALL _lcd_putsf
; 0000 00F3              break;
	RJMP _0x3B
; 0000 00F4          case 0:
_0x3C:
	SBIW R30,0
	BRNE _0x3F
; 0000 00F5              lcd_putchar('0');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(48)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 00F6          case 1:
_0x3F:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x40
; 0000 00F7              lcd_putchar('1');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(49)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 00F8          case 2:
_0x40:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x41
; 0000 00F9              lcd_putchar('2');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(50)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 00FA          case 3:
_0x41:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x42
; 0000 00FB              lcd_putchar('3');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(51)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 00FC          case 4:
_0x42:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x43
; 0000 00FD              lcd_putchar('4');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(52)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 00FE          case 5:
_0x43:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x44
; 0000 00FF              lcd_putchar('5');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(53)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 0100          case 6:
_0x44:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x45
; 0000 0101              lcd_putchar('6');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(54)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 0102          case 7:
_0x45:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x46
; 0000 0103              lcd_putchar('7');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(55)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 0104          case 8:
_0x46:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x47
; 0000 0105              lcd_putchar('8');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(56)
	CALL SUBOPT_0xD
	RJMP _0x3B
; 0000 0106          case 9:
_0x47:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x49
; 0000 0107              lcd_putchar('9');  delay_ms(50);   amaliat(y);break;
	LDI  R26,LOW(57)
	CALL SUBOPT_0xD
; 0000 0108          default:
_0x49:
; 0000 0109             break;
; 0000 010A      }
_0x3B:
; 0000 010B   }
	RJMP _0x26
; 0000 010C }
_0x4A:
	RJMP _0x4A
; .FEND

	.CSEG
_itoa:
; .FSTART _itoa
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
; .FEND

	.DSEG

	.CSEG
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

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 2
	SBI  0x1B,2
	__DELAY_USB 2
	CBI  0x1B,2
	__DELAY_USB 2
	RJMP _0x20A0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 17
	RJMP _0x20A0001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
_0x20A0003:
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0xE
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0xE
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2020007
	RJMP _0x20A0001
_0x2020007:
_0x2020004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x1B,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x20A0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020008
_0x202000A:
	RJMP _0x20A0002
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x202000B:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000D
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x202000B
_0x202000D:
_0x20A0002:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0xF
	CALL SUBOPT_0xF
	CALL SUBOPT_0xF
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 33
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20A0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_password:
	.BYTE 0x4
_y11:
	.BYTE 0x2
_y12:
	.BYTE 0x2
_y13:
	.BYTE 0x2
_y14:
	.BYTE 0x2
_y15:
	.BYTE 0x2
_my_password:
	.BYTE 0x2
__seed_G100:
	.BYTE 0x4
__base_y_G101:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x0:
	CALL _lcd_puts
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(_password)
	LDI  R27,HIGH(_password)
	CALL _itoa
	LDI  R26,LOW(_password)
	LDI  R27,HIGH(_password)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL __MULW12
	MOVW R22,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	LDI  R26,LOW(100)
	LDI  R27,HIGH(100)
	CALL __MULW12
	__ADDWRR 22,23,30,31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	ADD  R30,R22
	ADC  R31,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	__POINTW2FN _0x0,14
	CALL _lcd_putsf
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x6:
	CALL _lcd_putsf
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	CALL _lcd_putsf
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	JMP  _key

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x9:
	MOVW R26,R28
	ADIW R26,12
	CALL _itoa
	MOVW R26,R28
	ADIW R26,10
	CALL _lcd_puts
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
	JMP  _key

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,12
	CALL _itoa
	MOVW R26,R28
	ADIW R26,10
	CALL _lcd_puts
	LDI  R26,LOW(200)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:60 WORDS
SUBOPT_0xD:
	CALL _lcd_putchar
	LDI  R26,LOW(50)
	LDI  R27,0
	CALL _delay_ms
	MOVW R26,R16
	JMP  _amaliat

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G101
	__DELAY_USB 33
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xFA
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

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

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
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

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

;END OF CODE MARKER
__END_OF_CODE:
