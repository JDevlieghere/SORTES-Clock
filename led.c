#define __18CXX          //means "any pic18"
#include <pic18fregs.h>  //defines the address corresponding to the symbolic
                         //names of the sfr

#define CLOCK_FREQ 40000000 // 40 Mhz
#define EXEC_FREQ CLOCK_FREQ/4 // 4 clock cycles to execute an instruction

// wait for approx 1ms
void delay_1ms(void) {
	TMR0H=(0x10000-EXEC_FREQ/1000)>>8;
	TMR0L=(0x10000-EXEC_FREQ/1000)&0xff;
	T0CONbits.TMR0ON=0; // disable timer0
	T0CONbits.T08BIT=0; // use timer0 16-bit counter
	T0CONbits.T0CS=0; // use timer0 instruction cycle clock
	T0CONbits.PSA=1; // disable timer0 prescaler
	INTCONbits.T0IF=0; // clear timer0 overflow bit
	T0CONbits.TMR0ON=1; // enable timer0
	while (!INTCONbits.T0IF) {} // wait for timer0 overflow
	INTCONbits.T0IF=0; // clear timer0 overflow bit
	T0CONbits.TMR0ON=0; // disable timer0
}

// wait for some ms
void delay_ms(unsigned int ms) {
	while (ms--) {
		delay_1ms();
	}
}

// initialize board
void init_board(void) {
	TRISJbits.TRISJ0=0; // configure PORTJ0 for output (LED)
	TRISJbits.TRISJ1=0; // configure PORTJ1 for output (LED)
}

void main() {
	init_board();
	LATJbits.LATJ0=1; // switch LED on
	LATJbits.LATJ1=0; // switch LED off
	while (1) {
		delay_ms(1000);
		LATJbits.LATJ0^=1; // toggle LED
		LATJbits.LATJ1^=1; // toggle LED
	}
}
