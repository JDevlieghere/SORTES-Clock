// SDCC specific defines.
#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION

#define OVERFLOW_CYCLES 	24407	
#define CONFIG_MODE_QUIT 	-1
#define CONFIG_MODE_ALARM 	0 
#define CONFIG_MODE_CLOCK 	1 

#include <stdlib.h>
#include <stdio.h>

#include "../Include/HardwareProfile.h"
#include "../Include/LCDBlocking.h"

#include "strings.h"
#include "time.h"
#include "clockio.h"

void init(void);
void init_config(void);
void init_time(time t, char *);

void toggle_second_led(void);
void toggle_alarm_led(void);

// Clock time
time _time;

// Alarm time
time _alarm;

// State indicators
int alarm_going_off;

// Counters
int alarm_counter;
int overflow_counter;

// Dummy button registers
int but1_pressed;
int but2_pressed;

// Flags for marking mode. 
int config_called;
int config_mode_on;
int time_update_needed;

/**
 * Initializes the program and main loop for checking 
 * 	for configuration input and updating the LCD. 
 */
int main(void){
	// Initialize variables.
	init();
	// Initialize configuration mode.
	init_config();
	// Do first display update.
	display_update(_time);
	while(1){
		if(time_update_needed){
			time_update_needed = 0;
				display_update(_time);
		}
		if(config_called){
			config_called =0;
			init_config();
		}
	}	
}

/**
 * Start the configuration mode. 
 * 	This mode is only for setting the alarm or clock.
 */
void init_config(void){
	// -1 is quit, 0 is alarm , 1 is clock.
	int choice = CONFIG_MODE_ALARM;
	static char *choice_string = CM_ALARM_STRING;
	config_mode_on = 1;
	display_line(CM_STRING,choice_string);
	while(1){
		if(read_and_clear(&but2_pressed)){
			//Configure the selected config mode.
			switch(choice){
				case CONFIG_MODE_ALARM:
					LCDErase();
					init_time(_alarm, SM_ALARM_STRING);			
					display_line(CM_STRING,choice_string);
					break;
				case CONFIG_MODE_CLOCK:
					LCDErase();
					init_time(_time, SM_CLOCK_STRING);
					T0CONbits.TMR0ON = 1;			
					display_line(CM_STRING,choice_string);
					break;
				default:
					LCDErase();
					config_mode_on = 0;
					return;
			}
		}
		if(read_and_clear(&but1_pressed)){ 
			//Cycle trough the config modes.
			switch(choice){
				//For the alarm.
				case CONFIG_MODE_QUIT:
					LCDErase();
					choice = CONFIG_MODE_ALARM;
					choice_string = CM_ALARM_STRING;
					display_line(CM_STRING,choice_string);
					break;
				//For the clock.
				case CONFIG_MODE_ALARM:
					LCDErase();
					choice = CONFIG_MODE_CLOCK;
					choice_string = CM_CLOCK_STRING;
					display_line(CM_STRING,choice_string);
					break;
				//For quiting.
				case CONFIG_MODE_CLOCK:
					LCDErase();
					choice =CONFIG_MODE_QUIT;
					choice_string = CM_QUIT_STRING;
					display_line(CM_STRING,choice_string);
					break;
			}
		}
	}
}

/**
 * Sets the given timer with what the user inputs. 
 */
void init_time(time t, char *mode){ 
	int h, m, s;
	h = get_input(24, HOURS,   mode, &but1_pressed, &but2_pressed);
	m = get_input(60, MINUTES, mode, &but1_pressed, &but2_pressed);
	s = get_input(60, SECONDS, mode, &but1_pressed, &but2_pressed);
	time_set(t,h,m,s);
}

/**
 * Toggle the first (red) LED.
 */
void toggle_second_led(void){
	LED0_IO^=1;
}

/**
 * Toggle the second and third (orange) LEDs.
 */
void toggle_alarm_led(void){
	LED1_IO^=1;
	LED2_IO^=1;
}

/**
 * Handles the high priority interupts. 
 * 	Currently both buttons and ticks have high priority.
 */
void highPriorityInterruptHandler (void) __interrupt(1){
	// Button 2 causes an interrupt
	if(INTCON3bits.INT1F == 1){
	if(!config_mode_on){
		config_called =1;	
	} else {
		but2_pressed = 1;	
	}
	if(BUTTON0_IO);
		INTCON3bits.INT1F = 0; 
	}

	// Button 1 causes an interrupt
	if(INTCON3bits.INT3F  == 1){
		but1_pressed = 1;	
		if(BUTTON1_IO);
		INTCON3bits.INT3F = 0; 
	}

	// Timer 0 causes an interrupt
	if(INTCONbits.TMR0IF == 1) {
		overflow_counter++;
		if(overflow_counter == OVERFLOW_CYCLES/2){
			toggle_second_led();
		}else if(overflow_counter == OVERFLOW_CYCLES){
			if(time_equals(_alarm,_time)){
				alarm_going_off = 1;
			}
			if(alarm_going_off){
				alarm_counter++;
				toggle_alarm_led();
				if(alarm_counter==30){
					alarm_going_off =0;
					alarm_counter = 0;
				}
			}
			overflow_counter = 0;
			toggle_second_led();
			add_second(_time);
			if(!config_called && !config_mode_on){
				time_update_needed = 1;
			}
		}
		INTCONbits.TMR0IF = 0;
	}
}

/**
 * Inintializes all kinds of settings.
 */
void init(void){
	// Initialize LCD
	LCDInit();

	// Initialize time	
	_time = time_create();
	_alarm = time_create();

	// Enable buttons
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

	// Enable 8-bit operation 
	T0CONbits.T08BIT = 1;

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
	
	// INITIALIZE OUR OWN VARIABLES.
	// State indicators
	alarm_going_off = 0;

	// Counters
	alarm_counter = 0;
	overflow_counter = 0;

	// Dummy button registers
	but1_pressed = 0;
	but2_pressed = 0;

	// FLAGS FOR MARKING MODE. 
	config_called = 0;
	config_mode_on = 0;
	time_update_needed =0;
}
