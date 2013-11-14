;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 14 2013) (UNIX)
; This file was generated Thu Nov 14 20:54:12 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _get_hours
	global _get_minutes
	global _get_seconds
	global _time2string
	global _to_double_digits
	global _set_time
	global _seconds_since_midnight

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern _stdin
	extern _stdout
	extern _sprintf
	extern __divsint
	extern __mulint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_seconds_since_midnight	db	0x00, 0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1

udata_time_0	udata
_time2string_string_1_1	res	9

udata_time_1	udata
_to_double_digits_buffer_1_1	res	3

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_time__set_time	code
_set_time:
;	.line	55; src/time.c	void set_time(int hours, int minutes, int seconds){
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
;	.line	56; src/time.c	seconds_since_midnight = seconds + minutes * SEC_IN_MIN + hours * SEC_IN_HOUR;
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
	ADDWF	r0x04, W
	BANKSEL	_seconds_since_midnight
	MOVWF	_seconds_since_midnight, B
	MOVF	r0x01, W
	ADDWFC	r0x05, W
	BANKSEL	(_seconds_since_midnight + 1)
	MOVWF	(_seconds_since_midnight + 1), B
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_time__to_double_digits	code
_to_double_digits:
;	.line	43; src/time.c	char* to_double_digits(int value){
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
;	.line	45; src/time.c	sprintf(buffer, "%02d", value);
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
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
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
;	.line	46; src/time.c	return buffer;
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
S_time__time2string	code
_time2string:
;	.line	26; src/time.c	char* time2string(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	28; src/time.c	string[0] = to_double_digits(get_hours())[0];
	CALL	_get_hours
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	_time2string_string_1_1
	MOVWF	_time2string_string_1_1, B
;	.line	29; src/time.c	string[1] = to_double_digits(get_hours())[1];
	CALL	_get_hours
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_time2string_string_1_1 + 1)
	MOVWF	(_time2string_string_1_1 + 1), B
;	.line	30; src/time.c	string[2] = ':';
	MOVLW	0x3a
	BANKSEL	(_time2string_string_1_1 + 2)
	MOVWF	(_time2string_string_1_1 + 2), B
;	.line	31; src/time.c	string[3] = to_double_digits(get_minutes())[0];
	CALL	_get_minutes
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_time2string_string_1_1 + 3)
	MOVWF	(_time2string_string_1_1 + 3), B
;	.line	32; src/time.c	string[4] = to_double_digits(get_minutes())[1];
	CALL	_get_minutes
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_time2string_string_1_1 + 4)
	MOVWF	(_time2string_string_1_1 + 4), B
;	.line	33; src/time.c	string[5] = ':';
	MOVLW	0x3a
	BANKSEL	(_time2string_string_1_1 + 5)
	MOVWF	(_time2string_string_1_1 + 5), B
;	.line	34; src/time.c	string[6] = to_double_digits(get_seconds())[0];
	CALL	_get_seconds
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_time2string_string_1_1 + 6)
	MOVWF	(_time2string_string_1_1 + 6), B
;	.line	35; src/time.c	string[7] = to_double_digits(get_seconds())[1];	
	CALL	_get_seconds
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_time2string_string_1_1 + 7)
	MOVWF	(_time2string_string_1_1 + 7), B
	BANKSEL	(_time2string_string_1_1 + 8)
;	.line	36; src/time.c	string[8] = '\0';
	CLRF	(_time2string_string_1_1 + 8), B
;	.line	37; src/time.c	return string;
	MOVLW	HIGH(_time2string_string_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_time2string_string_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_time__get_seconds	code
_get_seconds:
;	.line	17; src/time.c	int get_seconds(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	18; src/time.c	int remaining_seconds = seconds_since_midnight - (get_hours() * SEC_IN_HOUR + get_minutes() * SEC_IN_MIN);
	CALL	_get_hours
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
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
	CALL	_get_minutes
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
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
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVF	r0x00, W
	BANKSEL	_seconds_since_midnight
	SUBWF	_seconds_since_midnight, W, B
	MOVWF	r0x00
	MOVF	r0x01, W
	BANKSEL	(_seconds_since_midnight + 1)
	SUBWFB	(_seconds_since_midnight + 1), W, B
	MOVWF	r0x01
;	.line	19; src/time.c	return remaining_seconds;
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_time__get_minutes	code
_get_minutes:
;	.line	12; src/time.c	int get_minutes(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	13; src/time.c	int remaining_seconds = seconds_since_midnight - (get_hours() * SEC_IN_HOUR);
	CALL	_get_hours
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
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
	BANKSEL	_seconds_since_midnight
	SUBWF	_seconds_since_midnight, W, B
	MOVWF	r0x00
	MOVF	r0x01, W
	BANKSEL	(_seconds_since_midnight + 1)
	SUBWFB	(_seconds_since_midnight + 1), W, B
	MOVWF	r0x01
;	.line	14; src/time.c	return (remaining_seconds / SEC_IN_MIN);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_time__get_hours	code
_get_hours:
;	.line	8; src/time.c	int get_hours(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	9; src/time.c	return (int)(seconds_since_midnight / SEC_IN_HOUR);
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	BANKSEL	(_seconds_since_midnight + 1)
	MOVF	(_seconds_since_midnight + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_seconds_since_midnight
	MOVF	_seconds_since_midnight, W, B
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x25, 0x30, 0x32, 0x64, 0x00


; Statistics:
; code size:	 1126 (0x0466) bytes ( 0.86%)
;           	  563 (0x0233) words
; udata size:	   12 (0x000c) bytes ( 0.31%)
; access size:	    6 (0x0006) bytes


	end
