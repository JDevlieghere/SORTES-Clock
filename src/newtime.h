#ifndef __NTIME_H_
#define __NTIME_H_

struct time_struct;
typedef struct time_struct *time;

time time_create();
void set_time(time t, int hours, int minutes, int seconds);

int set_hours(time t, int value);
int set_minutes(time t, int value);
int set_seconds(time t, int value);

void add_second(time t);
void add_minute(time t);
void add_hour(time t);

void time_print(time t, char* str);
int time_equals(time t1, time t2);

#endif