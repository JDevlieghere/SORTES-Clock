;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 14 2013) (UNIX)
; This file was generated Sat Nov 16 01:25:19 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _update_display
	global _toggle_led
	global _init_clock
	global _read_and_clear
	global _get_input
	global _display_string
	global _to_double_digits
	global _init
	global __time
	global __alarm
	global _display_line
	global _alarm_going_off
	global _alarm_counter
	global _overflow_counter
	global _but1_pressed
	global _but2_pressed
	global _main
	global _alarm_led
	global _highPriorityInterruptHandler

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget2
	extern __gptrput2
	extern __gptrget1
	extern __gptrput1
	extern _stdin
	extern _stdout
	extern _EBSTCONbits
	extern _MISTATbits
	extern _EFLOCONbits
	extern _MACON1bits
	extern _MACON2bits
	extern _MACON3bits
	extern _MACON4bits
	extern _MACLCON1bits
	extern _MACLCON2bits
	extern _MICONbits
	extern _MICMDbits
	extern _EWOLIEbits
	extern _EWOLIRbits
	extern _ERXFCONbits
	extern _EIEbits
	extern _ESTATbits
	extern _ECON2bits
	extern _EIRbits
	extern _EDATAbits
	extern _SSP2CON2bits
	extern _SSP2CON1bits
	extern _SSP2STATbits
	extern _ECCP2DELbits
	extern _ECCP2ASbits
	extern _ECCP3DELbits
	extern _ECCP3ASbits
	extern _RCSTA2bits
	extern _TXSTA2bits
	extern _CCP5CONbits
	extern _CCP4CONbits
	extern _T4CONbits
	extern _ECCP1DELbits
	extern _BAUDCON2bits
	extern _BAUDCTL2bits
	extern _BAUDCONbits
	extern _BAUDCON1bits
	extern _BAUDCTLbits
	extern _BAUDCTL1bits
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _PORTFbits
	extern _PORTGbits
	extern _PORTHbits
	extern _PORTJbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _LATFbits
	extern _LATGbits
	extern _LATHbits
	extern _LATJbits
	extern _DDRAbits
	extern _TRISAbits
	extern _DDRBbits
	extern _TRISBbits
	extern _DDRCbits
	extern _TRISCbits
	extern _DDRDbits
	extern _TRISDbits
	extern _DDREbits
	extern _TRISEbits
	extern _DDRFbits
	extern _TRISFbits
	extern _DDRGbits
	extern _TRISGbits
	extern _DDRHbits
	extern _TRISHbits
	extern _DDRJbits
	extern _TRISJbits
	extern _OSCTUNEbits
	extern _MEMCONbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _PIE3bits
	extern _PIR3bits
	extern _IPR3bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _RCSTA1bits
	extern _TXSTAbits
	extern _TXSTA1bits
	extern _PSPCONbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _CCP3CONbits
	extern _ECCP3CONbits
	extern _CCP2CONbits
	extern _ECCP2CONbits
	extern _CCP1CONbits
	extern _ECCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSP1CON2bits
	extern _SSPCON2bits
	extern _SSP1CON1bits
	extern _SSPCON1bits
	extern _SSP1STATbits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _ECON1bits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _LCDText
	extern _MAADR5
	extern _MAADR6
	extern _MAADR3
	extern _MAADR4
	extern _MAADR1
	extern _MAADR2
	extern _EBSTSD
	extern _EBSTCON
	extern _EBSTCS
	extern _EBSTCSL
	extern _EBSTCSH
	extern _MISTAT
	extern _EFLOCON
	extern _EPAUS
	extern _EPAUSL
	extern _EPAUSH
	extern _MACON1
	extern _MACON2
	extern _MACON3
	extern _MACON4
	extern _MABBIPG
	extern _MAIPG
	extern _MAIPGL
	extern _MAIPGH
	extern _MACLCON1
	extern _MACLCON2
	extern _MAMXFL
	extern _MAMXFLL
	extern _MAMXFLH
	extern _MICON
	extern _MICMD
	extern _MIREGADR
	extern _MIWR
	extern _MIWRL
	extern _MIWRH
	extern _MIRD
	extern _MIRDL
	extern _MIRDH
	extern _EHT0
	extern _EHT1
	extern _EHT2
	extern _EHT3
	extern _EHT4
	extern _EHT5
	extern _EHT6
	extern _EHT7
	extern _EPMM0
	extern _EPMM1
	extern _EPMM2
	extern _EPMM3
	extern _EPMM4
	extern _EPMM5
	extern _EPMM6
	extern _EPMM7
	extern _EPMCS
	extern _EPMCSL
	extern _EPMCSH
	extern _EPMO
	extern _EPMOL
	extern _EPMOH
	extern _EWOLIE
	extern _EWOLIR
	extern _ERXFCON
	extern _EPKTCNT
	extern _EWRPT
	extern _EWRPTL
	extern _EWRPTH
	extern _ETXST
	extern _ETXSTL
	extern _ETXSTH
	extern _ETXND
	extern _ETXNDL
	extern _ETXNDH
	extern _ERXST
	extern _ERXSTL
	extern _ERXSTH
	extern _ERXND
	extern _ERXNDL
	extern _ERXNDH
	extern _ERXRDPT
	extern _ERXRDPTL
	extern _ERXRDPTH
	extern _ERXWRPT
	extern _ERXWRPTL
	extern _ERXWRPTH
	extern _EDMAST
	extern _EDMASTL
	extern _EDMASTH
	extern _EDMAND
	extern _EDMANDL
	extern _EDMANDH
	extern _EDMADST
	extern _EDMADSTL
	extern _EDMADSTH
	extern _EDMACS
	extern _EDMACSL
	extern _EDMACSH
	extern _EIE
	extern _ESTAT
	extern _ECON2
	extern _EIR
	extern _EDATA
	extern _SSP2CON2
	extern _SSP2CON1
	extern _SSP2STAT
	extern _SSP2ADD
	extern _SSP2BUF
	extern _ECCP2DEL
	extern _ECCP2AS
	extern _ECCP3DEL
	extern _ECCP3AS
	extern _RCSTA2
	extern _TXSTA2
	extern _TXREG2
	extern _RCREG2
	extern _SPBRG2
	extern _CCP5CON
	extern _CCPR5
	extern _CCPR5L
	extern _CCPR5H
	extern _CCP4CON
	extern _CCPR4
	extern _CCPR4L
	extern _CCPR4H
	extern _T4CON
	extern _PR4
	extern _TMR4
	extern _ECCP1DEL
	extern _ERDPT
	extern _ERDPTL
	extern _ERDPTH
	extern _BAUDCON2
	extern _BAUDCTL2
	extern _SPBRGH2
	extern _BAUDCON
	extern _BAUDCON1
	extern _BAUDCTL
	extern _BAUDCTL1
	extern _SPBRGH
	extern _SPBRGH1
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _PORTF
	extern _PORTG
	extern _PORTH
	extern _PORTJ
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _LATF
	extern _LATG
	extern _LATH
	extern _LATJ
	extern _DDRA
	extern _TRISA
	extern _DDRB
	extern _TRISB
	extern _DDRC
	extern _TRISC
	extern _DDRD
	extern _TRISD
	extern _DDRE
	extern _TRISE
	extern _DDRF
	extern _TRISF
	extern _DDRG
	extern _TRISG
	extern _DDRH
	extern _TRISH
	extern _DDRJ
	extern _TRISJ
	extern _OSCTUNE
	extern _MEMCON
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _PIE3
	extern _PIR3
	extern _IPR3
	extern _EECON1
	extern _EECON2
	extern _RCSTA
	extern _RCSTA1
	extern _TXSTA
	extern _TXSTA1
	extern _TXREG
	extern _TXREG1
	extern _RCREG
	extern _RCREG1
	extern _SPBRG
	extern _SPBRG1
	extern _PSPCON
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _CCP3CON
	extern _ECCP3CON
	extern _CCPR3
	extern _CCPR3L
	extern _CCPR3H
	extern _CCP2CON
	extern _ECCP2CON
	extern _CCPR2
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _ECCP1CON
	extern _CCPR1
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRES
	extern _ADRESL
	extern _ADRESH
	extern _SSP1CON2
	extern _SSPCON2
	extern _SSP1CON1
	extern _SSPCON1
	extern _SSP1STAT
	extern _SSPSTAT
	extern _SSP1ADD
	extern _SSPADD
	extern _SSP1BUF
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _ECON1
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PROD
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTR
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PC
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOS
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _sprintf
	extern _strlen
	extern _LCDInit
	extern _LCDUpdate
	extern _LCDErase
	extern _time_create
	extern _time_set
	extern _add_second
	extern _time_print
	extern _time_equals
	extern __modsint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
BSR	equ	0xfe0
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_alarm_going_off	db	0x00, 0x00
_alarm_counter	db	0x00, 0x00
_overflow_counter	db	0x00, 0x00
_but1_pressed	db	0x00, 0x00
_but2_pressed	db	0x00, 0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1
r0x0a	res	1
r0x0b	res	1
r0x0c	res	1

udata_clock_0	udata
__time	res	3

udata_clock_1	udata
__alarm	res	3

udata_clock_2	udata
_display_line	res	32

udata_clock_3	udata
_to_double_digits_buffer_1_1	res	3

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_clock_ivec_0x1_highPriorityInterruptHandler	code	0X000008
ivec_0x1_highPriorityInterruptHandler:
	GOTO	_highPriorityInterruptHandler

; I code from now on!
; ; Starting pCode block
S_clock__main	code
_main:
;	.line	47; src/clock.c	_time = time_create();
	CALL	_time_create
	BANKSEL	__time
	MOVWF	__time, B
	MOVFF	PRODL, (__time + 1)
	MOVFF	PRODH, (__time + 2)
;	.line	48; src/clock.c	_alarm = time_create();
	CALL	_time_create
	BANKSEL	__alarm
	MOVWF	__alarm, B
	MOVFF	PRODL, (__alarm + 1)
	MOVFF	PRODH, (__alarm + 2)
;	.line	50; src/clock.c	init();
	CALL	_init
	BANKSEL	(__time + 2)
;	.line	51; src/clock.c	init_clock(_time);
	MOVF	(__time + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(__time + 1)
	MOVF	(__time + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	__time
	MOVF	__time, W, B
	MOVWF	POSTDEC1
	CALL	_init_clock
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	52; src/clock.c	time_set(_alarm,0,0,5);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x05
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	BANKSEL	(__alarm + 2)
	MOVF	(__alarm + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(__alarm + 1)
	MOVF	(__alarm + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	__alarm
	MOVF	__alarm, W, B
	MOVWF	POSTDEC1
	CALL	_time_set
	MOVLW	0x09
	ADDWF	FSR1L, F
;	.line	53; src/clock.c	update_display();
	CALL	_update_display
;	.line	54; src/clock.c	return 0;
	CLRF	PRODL
	CLRF	WREG
	RETURN	

; ; Starting pCode block
S_clock__init	code
_init:
;	.line	161; src/clock.c	void init(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	163; src/clock.c	LCDInit();
	CALL	_LCDInit
;	.line	166; src/clock.c	BUTTON0_TRIS = 1;
	BSF	_TRISBbits, 3
;	.line	167; src/clock.c	BUTTON1_TRIS = 1;
	BSF	_TRISBbits, 1
;	.line	170; src/clock.c	INTCONbits.GIE = 1;
	BSF	_INTCONbits, 7
;	.line	171; src/clock.c	INTCONbits.PEIE = 1;
	BSF	_INTCONbits, 6
;	.line	172; src/clock.c	RCONbits.IPEN = 1; 
	BSF	_RCONbits, 7
;	.line	175; src/clock.c	T0CONbits.TMR0ON = 0;
	BCF	_T0CONbits, 7
;	.line	178; src/clock.c	TMR0H = 0x00000000;
	CLRF	_TMR0H
;	.line	179; src/clock.c	TMR0L = 0x00000000;
	CLRF	_TMR0L
;	.line	182; src/clock.c	T0CONbits.T08BIT = 0;
	BCF	_T0CONbits, 6
;	.line	185; src/clock.c	T0CONbits.T0CS = 0;
	BCF	_T0CONbits, 5
;	.line	188; src/clock.c	T0CONbits.PSA = 1;
	BSF	_T0CONbits, 3
;	.line	191; src/clock.c	INTCONbits.TMR0IE = 1;
	BSF	_INTCONbits, 5
;	.line	194; src/clock.c	INTCON3bits.INT1IE = 1;
	BSF	_INTCON3bits, 3
;	.line	195; src/clock.c	INTCON3bits.INT3IE = 1;
	BSF	_INTCON3bits, 5
;	.line	198; src/clock.c	LED0_TRIS = 0;
	BCF	_TRISJbits, 0
;	.line	199; src/clock.c	LED1_TRIS = 0;   
	BCF	_TRISJbits, 1
;	.line	200; src/clock.c	LED2_TRIS = 0;
	BCF	_TRISJbits, 2
;	.line	201; src/clock.c	LED3_TRIS = 0;
	BCF	_TRISGbits, 5
;	.line	204; src/clock.c	LED0_IO = 0; 
	BCF	_LATJbits, 0
;	.line	205; src/clock.c	LED1_IO = 0;
	BCF	_LATJbits, 1
;	.line	206; src/clock.c	LED2_IO = 0;
	BCF	_LATJbits, 2
;	.line	207; src/clock.c	LED3_IO = 1;
	BSF	_PORTGbits, 5
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__highPriorityInterruptHandler	code
_highPriorityInterruptHandler:
;	.line	123; src/clock.c	void highPriorityInterruptHandler (void) __interrupt(1){
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	124; src/clock.c	if(INTCON3bits.INT1F == 1){
	CLRF	r0x00
	BTFSC	_INTCON3bits, 0
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00181_DS_
;	.line	125; src/clock.c	but2_pressed = 1;	
	MOVLW	0x01
	BANKSEL	_but2_pressed
	MOVWF	_but2_pressed, B
	BANKSEL	(_but2_pressed + 1)
	CLRF	(_but2_pressed + 1), B
; ;;!!! pic16_aopOp:1071 called for a spillLocation -- assigning WREG instead --- CHECK
;	.line	126; src/clock.c	if(BUTTON0_IO);
	CLRF	WREG
	BTFSC	_PORTBbits, 3
	INCF	WREG, F
;	.line	127; src/clock.c	INTCON3bits.INT1F = 0; 
	BCF	_INTCON3bits, 0
_00181_DS_:
;	.line	130; src/clock.c	if(INTCON3bits.INT3F  == 1){
	CLRF	r0x00
	BTFSC	_INTCON3bits, 2
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00183_DS_
;	.line	131; src/clock.c	but1_pressed = 1;	
	MOVLW	0x01
	BANKSEL	_but1_pressed
	MOVWF	_but1_pressed, B
	BANKSEL	(_but1_pressed + 1)
	CLRF	(_but1_pressed + 1), B
; ;;!!! pic16_aopOp:1071 called for a spillLocation -- assigning WREG instead --- CHECK
;	.line	132; src/clock.c	if(BUTTON1_IO);
	CLRF	WREG
	BTFSC	_PORTBbits, 1
	INCF	WREG, F
;	.line	133; src/clock.c	INTCON3bits.INT3F = 0; 
	BCF	_INTCON3bits, 2
_00183_DS_:
;	.line	135; src/clock.c	if(INTCONbits.TMR0IF == 1) {
	CLRF	r0x00
	BTFSC	_INTCONbits, 2
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00212_DS_
	BRA	_00197_DS_
_00212_DS_:
	BANKSEL	_overflow_counter
;	.line	136; src/clock.c	overflow_counter++;
	INCF	_overflow_counter, F, B
	BNC	_10223_DS_
	BANKSEL	(_overflow_counter + 1)
	INCF	(_overflow_counter + 1), F, B
_10223_DS_:
	BANKSEL	_overflow_counter
;	.line	137; src/clock.c	if(overflow_counter == CYCLES/2){
	MOVF	_overflow_counter, W, B
	XORLW	0x2e
	BNZ	_00213_DS_
	BANKSEL	(_overflow_counter + 1)
	MOVF	(_overflow_counter + 1), W, B
	BZ	_00214_DS_
_00213_DS_:
	BRA	_00193_DS_
_00214_DS_:
;	.line	138; src/clock.c	toggle_led();
	CALL	_toggle_led
	BRA	_00194_DS_
_00193_DS_:
	BANKSEL	_overflow_counter
;	.line	139; src/clock.c	}else if(overflow_counter == CYCLES){
	MOVF	_overflow_counter, W, B
	XORLW	0x5d
	BNZ	_00215_DS_
	BANKSEL	(_overflow_counter + 1)
	MOVF	(_overflow_counter + 1), W, B
	BZ	_00216_DS_
_00215_DS_:
	BRA	_00194_DS_
_00216_DS_:
	BANKSEL	(__time + 2)
;	.line	140; src/clock.c	if(time_equals(_alarm,_time)){
	MOVF	(__time + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(__time + 1)
	MOVF	(__time + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	__time
	MOVF	__time, W, B
	MOVWF	POSTDEC1
	BANKSEL	(__alarm + 2)
	MOVF	(__alarm + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(__alarm + 1)
	MOVF	(__alarm + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	__alarm
	MOVF	__alarm, W, B
	MOVWF	POSTDEC1
	CALL	_time_equals
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x06
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	BZ	_00185_DS_
;	.line	141; src/clock.c	alarm_going_off = 1;
	MOVLW	0x01
	BANKSEL	_alarm_going_off
	MOVWF	_alarm_going_off, B
	BANKSEL	(_alarm_going_off + 1)
	CLRF	(_alarm_going_off + 1), B
_00185_DS_:
	BANKSEL	_alarm_going_off
;	.line	143; src/clock.c	if(alarm_going_off){
	MOVF	_alarm_going_off, W, B
	BANKSEL	(_alarm_going_off + 1)
	IORWF	(_alarm_going_off + 1), W, B
	BZ	_00189_DS_
	BANKSEL	_alarm_counter
;	.line	144; src/clock.c	alarm_counter++;
	INCF	_alarm_counter, F, B
	BNC	_20224_DS_
	BANKSEL	(_alarm_counter + 1)
	INCF	(_alarm_counter + 1), F, B
_20224_DS_:
;	.line	145; src/clock.c	alarm_led();
	CALL	_alarm_led
	BANKSEL	_alarm_counter
;	.line	146; src/clock.c	if(alarm_counter==30){
	MOVF	_alarm_counter, W, B
	XORLW	0x1e
	BNZ	_00217_DS_
	BANKSEL	(_alarm_counter + 1)
	MOVF	(_alarm_counter + 1), W, B
	BZ	_00218_DS_
_00217_DS_:
	BRA	_00189_DS_
_00218_DS_:
	BANKSEL	_alarm_going_off
;	.line	147; src/clock.c	alarm_going_off =0;
	CLRF	_alarm_going_off, B
	BANKSEL	(_alarm_going_off + 1)
	CLRF	(_alarm_going_off + 1), B
	BANKSEL	_alarm_counter
;	.line	148; src/clock.c	alarm_counter = 0;
	CLRF	_alarm_counter, B
	BANKSEL	(_alarm_counter + 1)
	CLRF	(_alarm_counter + 1), B
_00189_DS_:
	BANKSEL	_overflow_counter
;	.line	151; src/clock.c	overflow_counter = 0;
	CLRF	_overflow_counter, B
	BANKSEL	(_overflow_counter + 1)
	CLRF	(_overflow_counter + 1), B
;	.line	152; src/clock.c	toggle_led();
	CALL	_toggle_led
	BANKSEL	(__time + 2)
;	.line	153; src/clock.c	add_second(_time);
	MOVF	(__time + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(__time + 1)
	MOVF	(__time + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	__time
	MOVF	__time, W, B
	MOVWF	POSTDEC1
	CALL	_add_second
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	154; src/clock.c	update_display();
	CALL	_update_display
_00194_DS_:
;	.line	156; src/clock.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
_00197_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; ; Starting pCode block
S_clock__to_double_digits	code
_to_double_digits:
;	.line	117; src/clock.c	char* to_double_digits(int value){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	119; src/clock.c	sprintf(buffer, "%02d", value);
	MOVLW	HIGH(_to_double_digits_buffer_1_1)
	MOVWF	r0x03
	MOVLW	LOW(_to_double_digits_buffer_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_sprintf
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	120; src/clock.c	return buffer;
	MOVLW	HIGH(_to_double_digits_buffer_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_to_double_digits_buffer_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__display_string	code
_display_string:
;	.line	106; src/clock.c	void display_string(BYTE pos, char* text){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	107; src/clock.c	BYTE        l = strlen(text);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	108; src/clock.c	BYTE      max = 32-pos;    
	MOVF	r0x00, W
	SUBLW	0x20
	MOVWF	r0x05
;	.line	109; src/clock.c	char       *d = (char*)&LCDText[pos];
	CLRF	r0x06
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x06, F
	MOVF	r0x06, W
	MOVWF	r0x06
	MOVF	r0x00, W
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x07
;	.line	111; src/clock.c	size_t      n = (l<max)?l:max;
	MOVF	r0x05, W
	SUBWF	r0x04, W
	BNC	_00165_DS_
	MOVFF	r0x05, r0x04
_00165_DS_:
	CLRF	r0x05
;	.line	112; src/clock.c	if (n != 0)
	MOVF	r0x04, W
	IORWF	r0x05, W
	BZ	_00161_DS_
_00157_DS_:
;	.line	113; src/clock.c	while (n-- != 0)*d++ = *s++;
	MOVFF	r0x04, r0x08
	MOVFF	r0x05, r0x09
	MOVLW	0xff
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x08, W
	IORWF	r0x09, W
	BZ	_00161_DS_
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, PRODL
	MOVF	r0x03, W
	CALL	__gptrget1
	MOVWF	r0x08
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x06, PRODL
	MOVF	r0x07, W
	CALL	__gptrput1
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	BRA	_00157_DS_
_00161_DS_:
;	.line	114; src/clock.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__get_input	code
_get_input:
;	.line	88; src/clock.c	int get_input(int maxvalue, char *text){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
;	.line	89; src/clock.c	BYTE length = strlen(text);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	90; src/clock.c	int value = 0;
	CLRF	r0x06
	CLRF	r0x07
;	.line	91; src/clock.c	display_string(0, text);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_display_string
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	92; src/clock.c	while(1)
	INCF	r0x05, W
	MOVWF	r0x02
_00152_DS_:
;	.line	94; src/clock.c	DelayMs(10);
	MOVLW	0x68
	MOVWF	r0x03
	MOVLW	0x42
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x08
_00137_DS_:
	MOVFF	r0x03, r0x09
	MOVFF	r0x04, r0x0a
	MOVFF	r0x05, r0x0b
	MOVFF	r0x08, r0x0c
	MOVLW	0xff
	ADDWF	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x04, F
	MOVLW	0xff
	ADDWFC	r0x05, F
	MOVLW	0xff
	ADDWFC	r0x08, F
	MOVF	r0x09, W
	IORWF	r0x0a, W
	IORWF	r0x0b, W
	IORWF	r0x0c, W
	BNZ	_00137_DS_
;	.line	95; src/clock.c	if(read_and_clear(&but2_pressed)){
	MOVLW	HIGH(_but2_pressed)
	MOVWF	r0x04
	MOVLW	LOW(_but2_pressed)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_read_and_clear
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	IORWF	r0x04, W
	BZ	_00144_DS_
;	.line	96; src/clock.c	LCDErase();
	CALL	_LCDErase
;	.line	97; src/clock.c	return value;
	MOVFF	r0x07, PRODL
	MOVF	r0x06, W
	BRA	_00150_DS_
_00144_DS_:
;	.line	99; src/clock.c	if(read_and_clear(&but1_pressed)){ 
	MOVLW	HIGH(_but1_pressed)
	MOVWF	r0x04
	MOVLW	LOW(_but1_pressed)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_read_and_clear
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	IORWF	r0x04, W
	BZ	_00146_DS_
;	.line	100; src/clock.c	value = (++value)%maxvalue;
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
_00146_DS_:
;	.line	102; src/clock.c	display_string(length + 1, to_double_digits(value));
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVFF	PRODH, r0x05
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_display_string
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00152_DS_
_00150_DS_:
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__read_and_clear	code
_read_and_clear:
;	.line	81; src/clock.c	int read_and_clear(int *variable){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	82; src/clock.c	if(*variable){
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget2
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	r0x03, W
	IORWF	r0x04, W
	BZ	_00131_DS_
;	.line	83; src/clock.c	*variable = 0;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	PRODH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput2
;	.line	84; src/clock.c	return 1;
	CLRF	PRODL
	MOVLW	0x01
	BRA	_00132_DS_
_00131_DS_:
;	.line	86; src/clock.c	return 0;
	CLRF	PRODL
	CLRF	WREG
_00132_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__init_clock	code
_init_clock:
;	.line	71; src/clock.c	void init_clock(time t){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	73; src/clock.c	h = get_input(24, "HOURS:");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	CALL	_get_input
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	74; src/clock.c	m = get_input(60, "MINUTES:");
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	_get_input
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	75; src/clock.c	s = get_input(60, "SECONDS:");
	MOVLW	UPPER(__str_2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_2)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_2)
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	_get_input
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	76; src/clock.c	time_set(t,h,m,s);
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_time_set
	MOVLW	0x09
	ADDWF	FSR1L, F
;	.line	78; src/clock.c	T0CONbits.TMR0ON = 1;
	BSF	_T0CONbits, 7
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__alarm_led	code
_alarm_led:
;	.line	66; src/clock.c	void alarm_led(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	67; src/clock.c	LED1_IO^=1;
	CLRF	r0x00
	BTFSC	_LATJbits, 1
	INCF	r0x00, F
	MOVLW	0x01
	XORWF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	RLNCF	WREG, W
	MOVWF	PRODH
	MOVF	_LATJbits, W
	ANDLW	0xfd
	IORWF	PRODH, W
	MOVWF	_LATJbits
;	.line	68; src/clock.c	LED2_IO^=1;
	CLRF	r0x00
	BTFSC	_LATJbits, 2
	INCF	r0x00, F
	MOVLW	0x01
	XORWF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	RLNCF	WREG, W
	RLNCF	WREG, W
	MOVWF	PRODH
	MOVF	_LATJbits, W
	ANDLW	0xfb
	IORWF	PRODH, W
	MOVWF	_LATJbits
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__toggle_led	code
_toggle_led:
;	.line	62; src/clock.c	void toggle_led(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	63; src/clock.c	LED0_IO^=1;
	CLRF	r0x00
	BTFSC	_LATJbits, 0
	INCF	r0x00, F
	MOVLW	0x01
	XORWF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	MOVWF	PRODH
	MOVF	_LATJbits, W
	ANDLW	0xfe
	IORWF	PRODH, W
	MOVWF	_LATJbits
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__update_display	code
_update_display:
;	.line	57; src/clock.c	void update_display(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	58; src/clock.c	time_print(_time, display_line);
	MOVLW	HIGH(_display_line)
	MOVWF	r0x01
	MOVLW	LOW(_display_line)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	BANKSEL	(__time + 2)
	MOVF	(__time + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(__time + 1)
	MOVF	(__time + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	__time
	MOVF	__time, W, B
	MOVWF	POSTDEC1
	CALL	_time_print
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	59; src/clock.c	display_string(0, display_line);
	MOVLW	HIGH(_display_line)
	MOVWF	r0x01
	MOVLW	LOW(_display_line)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_display_string
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x48, 0x4f, 0x55, 0x52, 0x53, 0x3a, 0x00
; ; Starting pCode block
__str_1:
	DB	0x4d, 0x49, 0x4e, 0x55, 0x54, 0x45, 0x53, 0x3a, 0x00
; ; Starting pCode block
__str_2:
	DB	0x53, 0x45, 0x43, 0x4f, 0x4e, 0x44, 0x53, 0x3a, 0x00
; ; Starting pCode block
__str_3:
	DB	0x25, 0x30, 0x32, 0x64, 0x00


; Statistics:
; code size:	 2072 (0x0818) bytes ( 1.58%)
;           	 1036 (0x040c) words
; udata size:	   41 (0x0029) bytes ( 1.07%)
; access size:	   13 (0x000d) bytes


	end
