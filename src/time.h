#ifndef __TIME_H
#define __TIME_H

#define SEC_IN_HOUR 3600		// one hour consists of 3600 seconds
#define SEC_IN_MIN 	60			// one minute consists of 60 seconds

#define ERROR_HOURS -1
#define ERROR_MINS 	-2
#define ERROR_SECS 	-3

extern long seconds_since_midnight;

int set_time(int hours, int minutes, int seconds);
char* to_double_digits(long value);
char* time2string(void);

long get_hours(void);
long get_minutes(void);
long get_seconds(void);

#endif