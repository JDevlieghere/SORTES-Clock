;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 14 2013) (UNIX)
; This file was generated Fri Nov 15 11:46:14 2013
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
	extern __divslong
	extern __mullong
	extern __divsint
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
_seconds_since_midnight	db	0x00, 0x00, 0x00, 0x00


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
;	.line	55; src/time.c	int set_time(int hours, int minutes, int seconds){
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
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	56; src/time.c	if(hours < 0 || hours >= 24)
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BC	_00130_DS_
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00144_DS_
	MOVLW	0x18
	SUBWF	r0x00, W
_00144_DS_:
	BNC	_00131_DS_
_00130_DS_:
;	.line	57; src/time.c	return ERROR_HOURS;
	SETF	PRODL
	SETF	WREG
	BRA	_00139_DS_
_00131_DS_:
;	.line	58; src/time.c	if(minutes < 0 || minutes >= 60)
	BSF	STATUS, 0
	BTFSS	r0x03, 7
	BCF	STATUS, 0
	BC	_00133_DS_
	MOVF	r0x03, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00145_DS_
	MOVLW	0x3c
	SUBWF	r0x02, W
_00145_DS_:
	BNC	_00134_DS_
_00133_DS_:
;	.line	59; src/time.c	return ERROR_MINS;
	SETF	PRODL
	MOVLW	0xfe
	BRA	_00139_DS_
_00134_DS_:
;	.line	60; src/time.c	if(seconds < 0 || seconds >= 60)
	BSF	STATUS, 0
	BTFSS	r0x05, 7
	BCF	STATUS, 0
	BC	_00136_DS_
	MOVF	r0x05, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00146_DS_
	MOVLW	0x3c
	SUBWF	r0x04, W
_00146_DS_:
	BNC	_00137_DS_
_00136_DS_:
;	.line	61; src/time.c	return ERROR_SECS;
	SETF	PRODL
	MOVLW	0xfd
	BRA	_00139_DS_
_00137_DS_:
;	.line	62; src/time.c	seconds_since_midnight = (long)seconds + (long)minutes * SEC_IN_MIN + (long)hours * SEC_IN_HOUR;
	CLRF	WREG
	BTFSC	r0x05, 7
	MOVLW	0xff
	MOVWF	r0x06
	MOVWF	r0x07
	CLRF	WREG
	BTFSC	r0x03, 7
	MOVLW	0xff
	MOVWF	r0x08
	MOVWF	r0x09
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	ADDWF	r0x04, F
	MOVF	r0x03, W
	ADDWFC	r0x05, F
	MOVF	r0x08, W
	ADDWFC	r0x06, F
	MOVF	r0x09, W
	ADDWFC	r0x07, F
	CLRF	WREG
	BTFSC	r0x01, 7
	MOVLW	0xff
	MOVWF	r0x02
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	ADDWF	r0x04, W
	BANKSEL	_seconds_since_midnight
	MOVWF	_seconds_since_midnight, B
	MOVF	r0x01, W
	ADDWFC	r0x05, W
	BANKSEL	(_seconds_since_midnight + 1)
	MOVWF	(_seconds_since_midnight + 1), B
	MOVF	r0x02, W
	ADDWFC	r0x06, W
	BANKSEL	(_seconds_since_midnight + 2)
	MOVWF	(_seconds_since_midnight + 2), B
	MOVF	r0x03, W
	ADDWFC	r0x07, W
	BANKSEL	(_seconds_since_midnight + 3)
	MOVWF	(_seconds_since_midnight + 3), B
;	.line	63; src/time.c	return 0;
	CLRF	PRODL
	CLRF	WREG
_00139_DS_:
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
S_time__to_double_digits	code
_to_double_digits:
;	.line	43; src/time.c	char* to_double_digits(long value){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	45; src/time.c	sprintf(buffer, "%02lu", value);
	MOVLW	HIGH(_to_double_digits_buffer_1_1)
	MOVWF	r0x05
	MOVLW	LOW(_to_double_digits_buffer_1_1)
	MOVWF	r0x04
	MOVLW	0x80
	MOVWF	r0x06
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
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
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_sprintf
	MOVLW	0x0a
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
S_time__time2string	code
_time2string:
;	.line	26; src/time.c	char* time2string(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	28; src/time.c	string[0] = to_double_digits(get_hours())[0];
	CALL	_get_hours
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x04
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
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x04
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
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x04
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
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x04
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
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x04
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
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_to_double_digits
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVLW	0x04
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
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_time__get_seconds	code
_get_seconds:
;	.line	17; src/time.c	long get_seconds(void){
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
;	.line	18; src/time.c	long remaining_seconds = seconds_since_midnight - (get_hours() * SEC_IN_HOUR + get_minutes() * SEC_IN_MIN);
	CALL	_get_hours
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	CALL	_get_minutes
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVFF	PRODH, r0x06
	MOVFF	FSR0L, r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVFF	PRODH, r0x06
	MOVFF	FSR0L, r0x07
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x00, F
	MOVF	r0x05, W
	ADDWFC	r0x01, F
	MOVF	r0x06, W
	ADDWFC	r0x02, F
	MOVF	r0x07, W
	ADDWFC	r0x03, F
	MOVF	r0x00, W
	BANKSEL	_seconds_since_midnight
	SUBWF	_seconds_since_midnight, W, B
	MOVWF	r0x00
	MOVF	r0x01, W
	BANKSEL	(_seconds_since_midnight + 1)
	SUBWFB	(_seconds_since_midnight + 1), W, B
	MOVWF	r0x01
	MOVF	r0x02, W
	BANKSEL	(_seconds_since_midnight + 2)
	SUBWFB	(_seconds_since_midnight + 2), W, B
	MOVWF	r0x02
	MOVF	r0x03, W
	BANKSEL	(_seconds_since_midnight + 3)
	SUBWFB	(_seconds_since_midnight + 3), W, B
	MOVWF	r0x03
;	.line	19; src/time.c	return remaining_seconds;
	MOVFF	r0x03, FSR0L
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
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
S_time__get_minutes	code
_get_minutes:
;	.line	12; src/time.c	long get_minutes(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	13; src/time.c	int remaining_seconds = seconds_since_midnight - (get_hours() * SEC_IN_HOUR);
	CALL	_get_hours
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	_seconds_since_midnight
	SUBWF	_seconds_since_midnight, W, B
	MOVWF	r0x00
	MOVF	r0x01, W
	BANKSEL	(_seconds_since_midnight + 1)
	SUBWFB	(_seconds_since_midnight + 1), W, B
	MOVWF	r0x01
	MOVF	r0x02, W
	BANKSEL	(_seconds_since_midnight + 2)
	SUBWFB	(_seconds_since_midnight + 2), W, B
	MOVWF	r0x02
	MOVF	r0x03, W
	BANKSEL	(_seconds_since_midnight + 3)
	SUBWFB	(_seconds_since_midnight + 3), W, B
	MOVWF	r0x03
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
	CLRF	WREG
	BTFSC	r0x01, 7
	MOVLW	0xff
	MOVWF	r0x02
	MOVWF	r0x03
	MOVFF	r0x03, FSR0L
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_time__get_hours	code
_get_hours:
;	.line	8; src/time.c	long get_hours(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	9; src/time.c	return (seconds_since_midnight / SEC_IN_HOUR);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	BANKSEL	(_seconds_since_midnight + 3)
	MOVF	(_seconds_since_midnight + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_seconds_since_midnight + 2)
	MOVF	(_seconds_since_midnight + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_seconds_since_midnight + 1)
	MOVF	(_seconds_since_midnight + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_seconds_since_midnight
	MOVF	_seconds_since_midnight, W, B
	MOVWF	POSTDEC1
	CALL	__divslong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x25, 0x30, 0x32, 0x6c, 0x75, 0x00


; Statistics:
; code size:	 1750 (0x06d6) bytes ( 1.34%)
;           	  875 (0x036b) words
; udata size:	   12 (0x000c) bytes ( 0.31%)
; access size:	   10 (0x000a) bytes


	end
