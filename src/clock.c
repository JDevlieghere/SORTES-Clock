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

// void high_isr (void) interrupt 1
// {
//     if(INTCON3bits.INT1F  = 1)
//     {
//     	if(BUTTON0_IO);  //just read the bit
//         INTCON3bits.INT1F  = 0;   //clear INT1 flag

//         if(configuring == 0){
//         	initClock();
//         }else{
// 			configuring++;
//         }
//     }
// }

int main(void){
    BUTTON0_TRIS 		= 1; 	//configure button0 as input

    RCONbits.IPEN      	= 1;	//enable interrupts priority levels
    INTCON3bits.INT1P  	= 1;	//connect INT1 interrupt (button 2) to high prio
    INTCON2bits.INTEDG1	= 0;	//INT1 interrupts on falling edge
    INTCONbits.GIE     	= 1;	//enable high priority interrupts
    INTCON3bits.INT1E  	= 1;	//enable INT1 interrupt (button 2)
    INTCON3bits.INT1F  	= 0;	//clear INT1 flag

	// Setting flags of the timer.
	T0CONbits.TMR0ON=0; // disable timer0
	T0CONbits.T08BIT=0; // use timer0 16-bit counter
	T0CONbits.T0CS=0; // use timer0 instruction cycle clock
	T0CONbits.PSA=1; // disable timer0 prescaler
	INTCONbits.T0IF=0; // clear timer0 overflow bit

    LCDInit();
    initClock();
	while(1);
}

void high_isr (void) interrupt 1
{
    if(INTCON3bits.INT1F  = 1)
    {
        LED1_IO ^= 1; //change state of red leds
        LED2_IO ^= 1; 
        if(BUTTON0_IO);  //just read the bit
        INTCON3bits.INT1F  = 0;   //clear INT1 flag
    }
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
