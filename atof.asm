;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 14 2013) (UNIX)
; This file was generated Fri Nov 15 15:30:12 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _atof

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern _isdigit
	extern _islower
	extern _isspace
	extern _atoi
	extern ___fsmul
	extern ___sint2fs
	extern ___fsadd
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
r0x0d	res	1
r0x0e	res	1
r0x0f	res	1
r0x10	res	1
r0x11	res	1
r0x12	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_atof__atof	code
_atof:
;	.line	22; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	float atof(char * s)
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
	MOVFF	r0x0d, POSTDEC1
	MOVFF	r0x0e, POSTDEC1
	MOVFF	r0x0f, POSTDEC1
	MOVFF	r0x10, POSTDEC1
	MOVFF	r0x11, POSTDEC1
	MOVFF	r0x12, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	29; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	while (isspace(*s)) s++;
	MOVFF	r0x00, r0x03
	MOVFF	r0x01, r0x04
	MOVFF	r0x02, r0x05
_00105_DS_:
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_isspace
	MOVWF	r0x06
	INCF	FSR1L, F
	MOVF	r0x06, W
	BZ	_00152_DS_
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	BRA	_00105_DS_
_00152_DS_:
	MOVFF	r0x03, r0x00
	MOVFF	r0x04, r0x01
	MOVFF	r0x05, r0x02
;	.line	32; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	if (*s == '-')
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x06
	MOVF	r0x06, W
	XORLW	0x2d
	BNZ	_00111_DS_
;	.line	34; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	sign=1;
	MOVLW	0x01
	MOVWF	r0x07
;	.line	35; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	s++;
	MOVF	r0x03, W
	ADDLW	0x01
	MOVWF	r0x00
	MOVLW	0x00
	ADDWFC	r0x04, W
	MOVWF	r0x01
	MOVLW	0x00
	ADDWFC	r0x05, W
	MOVWF	r0x02
	BRA	_00112_DS_
_00111_DS_:
;	.line	39; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	sign=0;
	CLRF	r0x07
;	.line	40; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	if (*s == '+') s++;
	MOVF	r0x06, W
	XORLW	0x2b
	BNZ	_00112_DS_
	MOVF	r0x03, W
	ADDLW	0x01
	MOVWF	r0x00
	MOVLW	0x00
	ADDWFC	r0x04, W
	MOVWF	r0x01
	MOVLW	0x00
	ADDWFC	r0x05, W
	MOVWF	r0x02
_00112_DS_:
;	.line	44; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	for (value=0.0; isdigit(*s); s++)
	CLRF	r0x03
	CLRF	r0x04
	CLRF	r0x05
	CLRF	r0x06
	MOVFF	r0x00, r0x08
	MOVFF	r0x01, r0x09
	MOVFF	r0x02, r0x0a
_00125_DS_:
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrget1
	MOVWF	r0x0b
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	CALL	_isdigit
	MOVWF	r0x0b
	INCF	FSR1L, F
	MOVF	r0x0b, W
	BTFSC	STATUS, 2
	BRA	_00153_DS_
;	.line	46; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	value=10.0*value+(*s-'0');
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVLW	0x41
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	___fsmul
	MOVWF	r0x0b
	MOVFF	PRODL, r0x0c
	MOVFF	PRODH, r0x0d
	MOVFF	FSR0L, r0x0e
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrget1
	MOVWF	r0x0f
	CLRF	r0x10
	BTFSC	r0x0f, 7
	SETF	r0x10
	MOVLW	0xd0
	ADDWF	r0x0f, F
	BTFSS	STATUS, 0
	DECF	r0x10, F
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	CALL	___sint2fs
	MOVWF	r0x0f
	MOVFF	PRODL, r0x10
	MOVFF	PRODH, r0x11
	MOVFF	FSR0L, r0x12
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x12, W
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	CALL	___fsadd
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVFF	PRODH, r0x05
	MOVFF	FSR0L, r0x06
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	44; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	for (value=0.0; isdigit(*s); s++)
	INCF	r0x08, F
	BTFSC	STATUS, 0
	INCF	r0x09, F
	BTFSC	STATUS, 0
	INCF	r0x0a, F
	BRA	_00125_DS_
_00153_DS_:
	MOVFF	r0x08, r0x00
	MOVFF	r0x09, r0x01
	MOVFF	r0x0a, r0x02
;	.line	50; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	if (*s == '.')
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrget1
	MOVWF	r0x0b
	MOVF	r0x0b, W
	XORLW	0x2e
	BZ	_00160_DS_
	BRA	_00114_DS_
_00160_DS_:
;	.line	52; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	s++;
	MOVF	r0x08, W
	ADDLW	0x01
	MOVWF	r0x00
	MOVLW	0x00
	ADDWFC	r0x09, W
	MOVWF	r0x01
	MOVLW	0x00
	ADDWFC	r0x0a, W
	MOVWF	r0x02
;	.line	53; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	for (fraction=0.1; isdigit(*s); s++)
	MOVLW	0xcd
	MOVWF	r0x08
	MOVLW	0xcc
	MOVWF	r0x09
	MOVWF	r0x0a
	MOVLW	0x3d
	MOVWF	r0x0b
	MOVFF	r0x00, r0x0c
	MOVFF	r0x01, r0x0d
	MOVFF	r0x02, r0x0e
_00129_DS_:
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, PRODL
	MOVF	r0x0e, W
	CALL	__gptrget1
	MOVWF	r0x0f
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	CALL	_isdigit
	MOVWF	r0x0f
	INCF	FSR1L, F
	MOVF	r0x0f, W
	BTFSC	STATUS, 2
	BRA	_00154_DS_
;	.line	55; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	value+=(*s-'0')*fraction;
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, PRODL
	MOVF	r0x0e, W
	CALL	__gptrget1
	MOVWF	r0x0f
	CLRF	r0x10
	BTFSC	r0x0f, 7
	SETF	r0x10
	MOVLW	0xd0
	ADDWF	r0x0f, F
	BTFSS	STATUS, 0
	DECF	r0x10, F
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	CALL	___sint2fs
	MOVWF	r0x0f
	MOVFF	PRODL, r0x10
	MOVFF	PRODH, r0x11
	MOVFF	FSR0L, r0x12
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x12, W
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	CALL	___fsmul
	MOVWF	r0x0f
	MOVFF	PRODL, r0x10
	MOVFF	PRODH, r0x11
	MOVFF	FSR0L, r0x12
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x12, W
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	___fsadd
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVFF	PRODH, r0x05
	MOVFF	FSR0L, r0x06
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	56; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	fraction*=0.1;
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVLW	0x3d
	MOVWF	POSTDEC1
	MOVLW	0xcc
	MOVWF	POSTDEC1
	MOVLW	0xcc
	MOVWF	POSTDEC1
	MOVLW	0xcd
	MOVWF	POSTDEC1
	CALL	___fsmul
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVFF	PRODH, r0x0a
	MOVFF	FSR0L, r0x0b
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	53; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	for (fraction=0.1; isdigit(*s); s++)
	INCF	r0x0c, F
	BTFSC	STATUS, 0
	INCF	r0x0d, F
	BTFSC	STATUS, 0
	INCF	r0x0e, F
	BRA	_00129_DS_
_00154_DS_:
	MOVFF	r0x0c, r0x00
	MOVFF	r0x0d, r0x01
	MOVFF	r0x0e, r0x02
_00114_DS_:
;	.line	61; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	if (toupper(*s)=='E')
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x08
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_islower
	MOVWF	r0x08
	INCF	FSR1L, F
	MOVF	r0x08, W
	BZ	_00135_DS_
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x08
	CLRF	r0x09
	BTFSC	r0x08, 7
	SETF	r0x09
	BCF	r0x08, 5
	BRA	_00136_DS_
_00135_DS_:
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x0a
	MOVFF	r0x0a, r0x08
	CLRF	r0x09
	BTFSC	r0x0a, 7
	SETF	r0x09
_00136_DS_:
	MOVF	r0x08, W
	XORLW	0x45
	BNZ	_00162_DS_
	MOVF	r0x09, W
	BZ	_00163_DS_
_00162_DS_:
	BRA	_00122_DS_
_00163_DS_:
;	.line	63; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	s++;
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
;	.line	64; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	iexp=(char)atoi(s);
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_atoi
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x03
	ADDWF	FSR1L, F
_00118_DS_:
;	.line	66; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	while(iexp!=0)
	MOVF	r0x00, W
	BTFSC	STATUS, 2
	BRA	_00122_DS_
;	.line	68; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	if(iexp<0)
	BSF	STATUS, 0
	BTFSS	r0x00, 7
	BCF	STATUS, 0
	BNC	_00116_DS_
;	.line	70; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	value*=0.1;
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVLW	0x3d
	MOVWF	POSTDEC1
	MOVLW	0xcc
	MOVWF	POSTDEC1
	MOVLW	0xcc
	MOVWF	POSTDEC1
	MOVLW	0xcd
	MOVWF	POSTDEC1
	CALL	___fsmul
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVFF	PRODH, r0x05
	MOVFF	FSR0L, r0x06
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	71; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	iexp++;
	INCF	r0x00, F
	BRA	_00118_DS_
_00116_DS_:
;	.line	75; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	value*=10.0;
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVLW	0x41
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	___fsmul
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVFF	PRODH, r0x05
	MOVFF	FSR0L, r0x06
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	76; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	iexp--;
	DECF	r0x00, F
	BRA	_00118_DS_
_00122_DS_:
;	.line	82; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	if(sign) value*=-1.0;
	MOVF	r0x07, W
	BZ	_00124_DS_
	BTG	r0x06, 7
_00124_DS_:
;	.line	83; /usr/local/lib/pic16/pic16/libc/stdlib/atof.c	return (value);
	MOVFF	r0x06, FSR0L
	MOVFF	r0x05, PRODH
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x12
	MOVFF	PREINC1, r0x11
	MOVFF	PREINC1, r0x10
	MOVFF	PREINC1, r0x0f
	MOVFF	PREINC1, r0x0e
	MOVFF	PREINC1, r0x0d
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



; Statistics:
; code size:	 1200 (0x04b0) bytes ( 0.92%)
;           	  600 (0x0258) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	   19 (0x0013) bytes


	end
