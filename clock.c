#define __18CXX          		// means "any pic18"
// #define CLOCK_FREQ 	40000000 	// 40 Mhz
#include <stdio.h>
#define SEC_IN_HOUR 3600		// one hour consists of 3600 seconds
#define SEC_IN_MIN 	60			// one minute consists of 60 seconds

struct human_time {
	int hours;
	int minutes;
	int seconds; 
}time;

long seconds_since_midnight;
void update_human_time(void);

int main(void){
	seconds_since_midnight = 10;
	update_human_time();
	printf("HOURS: %d\n", time.hours);
	printf("MINS: %d\n", time.hours);
	printf("seconds: %d\n", time.hours);

}

void update_human_time(void){
	int hours, minutes, remaining_seconds;
	remaining_seconds = seconds_since_midnight;

	hours = remaining_seconds / SEC_IN_HOUR;
	remaining_seconds -= (hours * SEC_IN_HOUR);

	minutes = remaining_seconds / SEC_IN_MIN;
	remaining_seconds -= minutes * SEC_IN_MIN;

	time.hours = hours;
	time.minutes = minutes;
	time.seconds = remaining_seconds;
}