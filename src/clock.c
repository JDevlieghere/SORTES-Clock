#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION

#define CLOCK_FREQ        40000000      
#define EXEC_FREQ         CLOCK_FREQ/4 	

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
void update_display(void);
void toggle_led(void);
int read_and_clear(int *variable);

time _time;
time _alarm;
char display_line[32];
int alarm_going_off = 0;
int alarm_counter = 0;
int overflow_counter = 0;
int but1_pressed = 0;
int but2_pressed = 0;

int main(void){
		_time = time_create();
		_alarm = time_create();

		init();
        init_clock(_time);
		time_set(_alarm,0,0,5);
		update_display();
        return 0;
}

void update_display(void){
	time_print(_time, display_line);
	display_string(0, display_line);
}

void toggle_led(void){
	LED0_IO^=1;
}

void alarm_led(void){
	LED1_IO^=1;
	LED2_IO^=1;
}

void init_clock(time t){
    int h, m, s;
    h = get_input(24, "HOURS:");
    m = get_input(60, "MINUTES:");
    s = get_input(60, "SECONDS:");
    time_set(t,h,m,s);
    // Start timer
    T0CONbits.TMR0ON = 1;
}

int read_and_clear(int *variable){
	if(*variable){
		*variable = 0;
		return 1;
	}
	return 0;
}
int get_input(int maxvalue, char *text){
        BYTE length = strlen(text);
        int value = 0;
        display_string(0, text);
        while(1)
        {
        	DelayMs(10);
			if(read_and_clear(&but2_pressed)){
				LCDErase();
				return value;
			}
			if(read_and_clear(&but1_pressed)){ 
				value = (++value)%maxvalue;
				display_string(length + 1, to_double_digits(value));
			}
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

void lowPriorityInterruptHandler (void) __interrupt(1){
    if(INTCON3bits.INT1F == 1){
		but2_pressed = 1;	
		if(BUTTON1_IO);
		INTCON3bits.INT1F = 0; 
	}
	if(INTCON3bits.INT3F  == 1){
		but1_pressed = 1;	
		if(BUTTON1_IO);
		INTCON3bits.INT3F = 0; 
	}
	if(INTCONbits.TMR0IF == 1) {
		overflow_counter++;
		if(overflow_counter == 50){
			toggle_led();
		}else if(overflow_counter == 100){
			if(time_equals(_alarm,_time)){
				alarm_going_off = 1;
			}
			if(alarm_going_off){
				alarm_counter++;
				alarm_led();
				if(alarm_counter==30){
					alarm_going_off =0;
					alarm_counter = 0;
				}
			}
			overflow_counter = 0;
			toggle_led();
			add_second(_time);
			update_display();
		}
        INTCONbits.TMR0IF = 0;
    }
}


void init(void){
	// Initialize LCD
	LCDInit();

	BUTTON0_TRIS = 1;
	BUTTON1_TRIS = 1;

	// Enable interrupts
	INTCONbits.GIE = 1;
    INTCONbits.PEIE = 1;
    RCONbits.IPEN = 1; 

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

    // Enable timer and interrupts
	INTCONbits.TMR0IE = 1;

	// Enable button interrupts
    INTCON3bits.INT1IE = 1;
    INTCON3bits.INT3IE = 1;

	// Enable leds
	LED0_TRIS = 0;
   	LED1_TRIS = 0;   
   	LED2_TRIS = 0;
   	LED3_TRIS = 0;

   	// Disable all LED but backlight
   	LED0_IO = 0; 
   	LED1_IO = 0;
   	LED2_IO = 0;
    LED3_IO = 1;
}
