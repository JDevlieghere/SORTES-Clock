#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "time.h"

int seconds_since_midnight = 0;

int get_hours(void){
	return (int)(seconds_since_midnight / SEC_IN_HOUR);
}

int get_minutes(void){
	int remaining_seconds = seconds_since_midnight - (get_hours() * SEC_IN_HOUR);
	return (remaining_seconds / SEC_IN_MIN);
}

int get_seconds(void){
	int remaining_seconds = seconds_since_midnight - (get_hours() * SEC_IN_HOUR + get_minutes() * SEC_IN_MIN);
	return remaining_seconds;
}

/**
 * Converts the current time to a stirng in 
 * human readable format.
 */
char* time2string(void){
	static char string[9];
	string[0] = to_double_digits(get_hours())[0];
	string[1] = to_double_digits(get_hours())[1];
	string[2] = ':';
	string[3] = to_double_digits(get_minutes())[0];
	string[4] = to_double_digits(get_minutes())[1];
	string[5] = ':';
	string[6] = to_double_digits(get_seconds())[0];
	string[7] = to_double_digits(get_seconds())[1];	
	string[8] = '\0';
	return string;
}

/**
 * Converts a integer value to a double digit string.
 */
char* to_double_digits(int value){
	static char buffer[3];
	sprintf(buffer, "%02d", value);
	return buffer;
}	

/**
 * Set seconds since midnight based on the given 
 * human readable time format.
 *
 * Updates the human readable time struct so inconsitency is impossible. 
 */
void set_time(int hours, int minutes, int seconds){
	seconds_since_midnight = seconds + minutes * SEC_IN_MIN + hours * SEC_IN_HOUR;
}