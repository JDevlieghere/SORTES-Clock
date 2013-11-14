#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "time.h"

/** 
 * Update human readable time based on the 
 * current amount of seconds that have elapsed
 * since midnight.
 */
void update_human_time(void){
	long hours, minutes, remaining_seconds;
	remaining_seconds = seconds_since_midnight;

	hours = remaining_seconds / SEC_IN_HOUR;
	remaining_seconds -= (hours * SEC_IN_HOUR);

	minutes = remaining_seconds / SEC_IN_MIN;
	remaining_seconds -= minutes * SEC_IN_MIN;
	
	/* Set the correct propterties in the struct. */
	time.hours = hours;
	time.minutes = minutes;
	time.seconds = remaining_seconds;
}

/**
 * Converts the current time to a stirng in 
 * human readable format.
 */
char* time2string(struct human_time *time){
	static char string[11];
	strncat(string, to_double_digits(time->hours),2);
	strncat(string, ":",1);
	strncat(string, to_double_digits(time->minutes),2);
	strncat(string, ":",1);
	strncat(string, to_double_digits(time->seconds),2);	
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
	update_human_time();
}
