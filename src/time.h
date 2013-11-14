#ifndef __TIME_H
#define __TIME_H

#define SEC_IN_HOUR 3600		// one hour consists of 3600 seconds
#define SEC_IN_MIN 	60			// one minute consists of 60 seconds

/* Define and declare structure for the readable time. */
struct human_time {
	long hours;
	long minutes;
	long seconds; 
};

static struct human_time time;
static long seconds_since_midnight;

void update_human_time(void);
void set_time(int hours, int minutes, int seconds);
char* to_double_digits(int value);
char* time2string(struct human_time *time);

#endif