// SDCC specific defines.
#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION

// Clock related defines.
#define CLOCK_FREQ  40000000      
#define EXEC_FREQ   CLOCK_FREQ/4 	
#define CYCLES 		93

// Defines for easy use of the LCD. 
#define START_FIRST_LINE 0 
#define START_SECOND_LINE 16 


// DEFINES FOR CONFIGURING MODE.

#define	CM_STRING "Choose mode:" 

// Quit configuration
#define CONFIG_MODE_QUIT -1
#define	CM_QUIT_STRING "Quit config mode." 

// Alarm configuration
#define CONFIG_MODE_ALARM 0 
#define	CM_ALARM_STRING "Set alarm?" 
#define	SM_ALARM_STRING "Set alarm:" 

// Clock configuration
#define CONFIG_MODE_CLOCK 1 
#define	CM_CLOCK_STRING "Set clock?" 
#define	SM_CLOCK_STRING "Set clock:" 

// INCLUDES
#include <stdlib.h>
#include <stdio.h>

#include "../Include/HardwareProfile.h"
#include "../Include/LCDBlocking.h"
#include "../Include/TCPIP_Stack/Delay.h"

#include "newtime.h"


// METHOD DECLARATION 

//			 DOES THIS NEED TO BE HERE??? 
void delay_1ms(void);
void delay_ms(unsigned int ms);

// no declaration for highPriorityInterruptHandler?

void init(void);
void init_config(void);
void init_time(time t, char *);

void display_string(BYTE pos, char* text);
void display_config_mode(char *choice_string);
void update_display(void);
void toggle_second_led(void);
void toggle_alarm_led(void);

int get_input(int maxvalue, char *text, char *mode);
char* to_double_digits(int value);
int read_and_clear(int *variable);



// VARIABLE DECLARATION
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

/**
 * Initializes the program and loop for checking for configuration input. 
 */
int main(void){
	// Initialize variables.
	init();
	// Initialize configuration mode.
	init_config();
	// Do first display update.
	update_display();
	while(1){
		if(config_called){
			config_called =0;
			init_config();
		}
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
	display_config_mode(choice_string);
	while(1){
		if(read_and_clear(&but2_pressed)){
			//Configure the selected config mode.
			switch(choice){
				case CONFIG_MODE_ALARM:
					LCDErase();
					init_time(_alarm, SM_ALARM_STRING);			
					display_config_mode(choice_string);
					break;
				case CONFIG_MODE_CLOCK:
					LCDErase();
					init_time(_time, SM_CLOCK_STRING);
					T0CONbits.TMR0ON = 1;			
					display_config_mode(choice_string);
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
					display_config_mode(choice_string);
					break;
				//For the clock.
				case CONFIG_MODE_ALARM:
					LCDErase();
					choice = CONFIG_MODE_CLOCK;
					choice_string = CM_CLOCK_STRING;
					display_config_mode(choice_string);
					break;
				//For quiting.
				case CONFIG_MODE_CLOCK:
					LCDErase();
					choice =CONFIG_MODE_QUIT;
					choice_string = CM_QUIT_STRING;
					display_config_mode(choice_string);
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
	h = get_input(24, "Hours:", mode);
	m = get_input(60, "Minutes:", mode);
	s = get_input(60, "Seconds:", mode);
	time_set(t,h,m,s);
}

/**
 * Displays the given string at the given position on the LCD. 
 */
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

/**
 * Display the configuring mode with the given choice string. 
 */
void display_config_mode(char *choice_string){
		display_string(START_FIRST_LINE, CM_STRING);
		display_string(START_SECOND_LINE, choice_string);
}

/**
 * Updates the display and prints the current time. 
 */
void update_display(void){
	char display_line[32];
	time_print(_time, display_line);
	display_string(0, display_line);
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
 * Gets the desired value for the given setting. 
 */
int get_input(int maxvalue, char *text, char *mode){
	BYTE length = strlen(text);
	int value = 0;
	display_string(START_FIRST_LINE , mode);
	display_string(START_SECOND_LINE, text);
	while(1){
		if(config_mode_on){
			DelayMs(10);
			if(read_and_clear(&but2_pressed)){
				LCDErase();
				return value;
			}
			if(read_and_clear(&but1_pressed)){ 
				value = (++value)%maxvalue;
			}
			display_string(START_SECOND_LINE + length + 1, to_double_digits(value));
			} else { 
		}
	}
}

/**
 * Returns whether the given int represents true and sets it to false. 
 */
int read_and_clear(int *variable){
	if(*variable){
		*variable = 0;
		return 1;
	}
	return 0;
}

/**
 * Returns a pointer to a string of the double digit representation of the given value. 
 */
char* to_double_digits(int value){
	static char buffer[3];
	sprintf(buffer, "%02d", value);
	return buffer;
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
		if(overflow_counter == CYCLES/2){
			toggle_second_led();
		}else if(overflow_counter == CYCLES){
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
				update_display();
			}
		}
		INTCONbits.TMR0IF = 0;
	}
}
