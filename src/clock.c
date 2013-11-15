#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION

#define CLOCK_FREQ        40000000      // 40 Mhz
#define EXEC_FREQ         CLOCK_FREQ/4 	// 4 clock cycles to execute an instruction

#include <stdlib.h>
#include <stdio.h>

#include "../Include/HardwareProfile.h"
#include "../Include/LCDBlocking.h"
#include "../Include/TCPIP_Stack/Delay.h"

#include "newtime.h"

/* Method declaration. */
void display_string(BYTE pos, char* text);
int get_input(int maxvalue, char *text);
void delay_1ms(void);
void delay_ms(unsigned int ms);
void init_clock(time t);
char* to_double_digits(int value);
void init(void);

time _time;
char display_line[32];
int counter = 0;

int main(void){
		_time = time_create();

		init();
        init_clock(_time);
        time_print(_time, display_line);
        display_string(0, display_line);
        return 0;
}

void init_clock(time t){
    int h, m, s;
    h = get_input(24, "HOURS:");
    m = get_input(60, "MINUTES:");
    s = get_input(60, "SECONDS:");
    time_set(t,h,m,s);
}

int get_input(int maxvalue, char *text){
        BYTE length = strlen(text);
        int value = 0;
        display_string(0, text);
        while(1)
        {
        	DelayMs(10);
			if(BUTTON1_IO == 0u){
					LCDErase();
			        return value;
			}
			if(BUTTON0_IO == 0u) 
			        value = (++value)%maxvalue;
			display_string(length + 1, to_double_digits(value));
        }
}

void display_string(BYTE pos, char* text){
	BYTE        l = strlen(text);
	BYTE      max = 32-pos;    
	char       *d = (char*)&LCDText[pos];
	const char *s = text;
	size_t      n = (l<max)?l:max;
	if (n != 0)
		while (n-- != 0)*d++ = *s++;
	LCDUpdate();
}

char* to_double_digits(int value){
        static char buffer[3];
        sprintf(buffer, "%02d", value);
        return buffer;
}        

// void highPriorityInterruptHandler (void) __interrupt(1){
// 	if(INTCON3bits.INT1F  = 1){
//         LED1_IO ^= 1; //change state of red leds
//         LED2_IO ^= 1; 
//         if(BUTTON0_IO);  //just read the bit
//         INTCON3bits.INT1F  = 0;   //clear INT1 flag
//     }
// }

void lowPriorityInterruptHandler (void) __interrupt(1){
	if (INTCONbits.TMR0IF == 1) {
		display_string(0,to_double_digits(counter++));
        INTCONbits.TMR0IF = 0;
    }
}



void init(void){
	// Initialize LCD
	LCDInit();

	// Enable interrupts
	RCONbits.IPEN = 1;
	INTCONbits.GIE = 1;
    INTCONbits.PEIE = 1;

    // Disable timer
    T0CONbits.TMR0ON = 0;

    // Empty timer: high before low (!)
    TMR0H = 0x00000000;
    TMR0L = 0x00000000;

    // Enable 16-bit operation 
     T0CONbits.T08BIT = 0;

    // Use clock as clock source 
    T0CONbits.T0CS = 0;

    // Unassign prescaler
    T0CONbits.PSA = 1;

    // Enable timer interrupts
	INTCONbits.TMR0IE = 1;

	// // Enable button interrupts
 //    INTCON3bits.INT1P  = 1;   //connect INT1 interrupt (button 2) to high priority
 //    INTCON2bits.INTEDG1= 0;   //INT1 interrupts on falling edge
 //    INTCON3bits.INT1E  = 1;   //enable INT1 interrupt (button 2)
 //    INTCON3bits.INT1F  = 0;   //clear INT1 flag
 

	// Enable backlight
	LED3_TRIS = 0;
    LED3_IO = 1;
}