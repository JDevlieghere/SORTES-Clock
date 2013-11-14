#include <stdio.h>
#include "time.h"

int main(void){
	seconds_since_midnight = 3661;
	update_human_time();
	printf("HOURS: %lu\n", time.hours);
	printf("MINS: %lu\n", time.minutes);
	printf("seconds: %lu\n", time.seconds);
	printf("%s\n", time2string(&time));
}