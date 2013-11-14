;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 14 2013) (UNIX)
; This file was generated Thu Nov 14 17:00:04 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _update_human_time
	global _set_time
	global _time
	global _seconds_since_midnight
	global _main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _stdin
	extern _stdout
	extern _printf
	extern __divsint
	extern __mulint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


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

udata_clock_0	udata
_seconds_since_midnight	res	4

udata_clock_1	udata
_time	res	6

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_clock__main	code
_main:
;	.line	22; src/clock.c	seconds_since_midnight = 3661;
	MOVLW	0x4d
	BANKSEL	_seconds_since_midnight
	MOVWF	_seconds_since_midnight, B
	MOVLW	0x0e
	BANKSEL	(_seconds_since_midnight + 1)
	MOVWF	(_seconds_since_midnight + 1), B
	BANKSEL	(_seconds_since_midnight + 2)
	CLRF	(_seconds_since_midnight + 2), B
	BANKSEL	(_seconds_since_midnight + 3)
	CLRF	(_seconds_since_midnight + 3), B
;	.line	23; src/clock.c	update_human_time();
	CALL	_update_human_time
	BANKSEL	(_time + 1)
;	.line	24; src/clock.c	printf("HOURS: %d\n", time.hours);
	MOVF	(_time + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_time
	MOVF	_time, W, B
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	CALL	_printf
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_time + 3)
;	.line	25; src/clock.c	printf("MINS: %d\n", time.minutes);
	MOVF	(_time + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_time + 2)
	MOVF	(_time + 2), W, B
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	MOVWF	POSTDEC1
	CALL	_printf
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_time + 5)
;	.line	26; src/clock.c	printf("seconds: %d\n", time.seconds);
	MOVF	(_time + 5), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_time + 4)
	MOVF	(_time + 4), W, B
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_2)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_2)
	MOVWF	POSTDEC1
	CALL	_printf
	MOVLW	0x05
	ADDWF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_clock__set_time	code
_set_time:
;	.line	57; src/clock.c	void set_time(int hours, int minutes, int seconds){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
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
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	58; src/clock.c	seconds_since_midnight = seconds + minutes * SEC_IN_MIN + hours * SEC_IN_HOUR;
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	ADDWF	r0x04, F
	MOVF	r0x03, W
	ADDWFC	r0x05, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	ADDWF	r0x04, F
	MOVF	r0x01, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, _seconds_since_midnight
	MOVFF	r0x05, (_seconds_since_midnight + 1)
	CLRF	WREG
	BTFSC	r0x05, 7
	MOVLW	0xff
	BANKSEL	(_seconds_since_midnight + 2)
	MOVWF	(_seconds_since_midnight + 2), B
	BANKSEL	(_seconds_since_midnight + 3)
	MOVWF	(_seconds_since_midnight + 3), B
;	.line	59; src/clock.c	update_human_time();
	CALL	_update_human_time
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_clock__update_human_time	code
_update_human_time:
;	.line	35; src/clock.c	void update_human_time(void){
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
	BANKSEL	_seconds_since_midnight
;	.line	37; src/clock.c	remaining_seconds = seconds_since_midnight;
	MOVF	_seconds_since_midnight, W, B
	MOVWF	r0x00
	BANKSEL	(_seconds_since_midnight + 1)
	MOVF	(_seconds_since_midnight + 1), W, B
	MOVWF	r0x01
;	.line	39; src/clock.c	hours = remaining_seconds / SEC_IN_HOUR;
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	40; src/clock.c	remaining_seconds -= (hours * SEC_IN_HOUR);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	SUBWF	r0x00, F
	MOVF	r0x05, W
	SUBWFB	r0x01, F
;	.line	42; src/clock.c	minutes = remaining_seconds / SEC_IN_MIN;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	43; src/clock.c	remaining_seconds -= minutes * SEC_IN_MIN;
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	SUBWF	r0x00, F
	MOVF	r0x07, W
	SUBWFB	r0x01, F
;	.line	46; src/clock.c	time.hours = hours;
	MOVF	r0x02, W
	BANKSEL	_time
	MOVWF	_time, B
	MOVF	r0x03, W
	BANKSEL	(_time + 1)
	MOVWF	(_time + 1), B
;	.line	47; src/clock.c	time.minutes = minutes;
	MOVF	r0x04, W
	BANKSEL	(_time + 2)
	MOVWF	(_time + 2), B
	MOVF	r0x05, W
	BANKSEL	(_time + 3)
	MOVWF	(_time + 3), B
;	.line	48; src/clock.c	time.seconds = remaining_seconds;
	MOVF	r0x00, W
	BANKSEL	(_time + 4)
	MOVWF	(_time + 4), B
	MOVF	r0x01, W
	BANKSEL	(_time + 5)
	MOVWF	(_time + 5), B
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
__str_0:
	DB	0x48, 0x4f, 0x55, 0x52, 0x53, 0x3a, 0x20, 0x25, 0x64, 0x0a, 0x00
; ; Starting pCode block
__str_1:
	DB	0x4d, 0x49, 0x4e, 0x53, 0x3a, 0x20, 0x25, 0x64, 0x0a, 0x00
; ; Starting pCode block
__str_2:
	DB	0x73, 0x65, 0x63, 0x6f, 0x6e, 0x64, 0x73, 0x3a, 0x20, 0x25, 0x64, 0x0a
	DB	0x00


; Statistics:
; code size:	  592 (0x0250) bytes ( 0.45%)
;           	  296 (0x0128) words
; udata size:	   10 (0x000a) bytes ( 0.26%)
; access size:	    8 (0x0008) bytes


	end
