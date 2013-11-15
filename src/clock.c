#define __18F97J60
#define __SDCC__
#define CLOCK_FREQ 	40000000 	// 40 Mhz
#define EXEC_FREQ 	CLOCK_FREQ/4 // 4 clock cycles to execute an instruction
#define THIS_INCLUDES_THE_MAIN_FUNCTION

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "../Include/HardwareProfile.h"
#include "../Include/LCDBlocking.h"
#include "../Include/TCPIP_Stack/Delay.h"
#include "time.h"

/* Method declaration. */
void DisplayString(BYTE pos, char* text);
int getInput(int maxvalue, char *text);
void delay_1ms(void);
void delay_ms(unsigned int ms);
void initClock();

int main(void){
	LCDInit();
	initClock();
	DisplayString(0, time2string());
	return 0;
}

void initClock(){
	int h = getInput(24, "HOURS:");
	int m = getInput(60, "MINUTES:");
	int s = getInput(60, "SECONDS:");
	set_time(h,m,s);
}

int getInput(int maxvalue, char *text){
	BYTE length = strlen(text);
	int value = 0;
	DisplayString(0, text);

	while(1)
	{
		if(BUTTON1_IO == 0u){
			LCDErase();
			return value;
		}
		if(BUTTON0_IO == 0u) 
			value = (++value)%maxvalue;
		DisplayString(length + 1, to_double_digits(value));
		delay_ms(50);
	}
}

void DisplayString(BYTE pos, char* text){
   BYTE        l = strlen(text);/*number of actual chars in the string*/
   BYTE      max = 32-pos;    /*available space on the lcd*/
   char       *d = (char*)&LCDText[pos];
   const char *s = text;
   size_t      n = (l<max)?l:max;
   /* Copy as many bytes as will fit */
    if (n != 0)
      while (n-- != 0)*d++ = *s++;
   LCDUpdate();
}

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

void delay_ms(unsigned int ms) {
	while (ms--) {
		delay_1ms();
	}
}