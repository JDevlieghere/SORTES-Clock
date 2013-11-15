#include "newtime.h"

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

unsigned char _MALLOC_SPEC heap[32];

struct time_struct {
	int hours;
	int minutes;
	int seconds;
};

time time_create(){
    time t = (time)malloc(sizeof (struct time_struct));
    time_set(t,0,0,0);
    return t;
}

void time_set(time t, int hours, int minutes, int seconds){
	set_hours(t,hours);
	set_minutes(t,minutes);
	set_seconds(t,seconds);
}

int set_hours(time t, int value){
	int overflow = value/24;
	t->hours = value%24;
	return overflow;
}

int set_minutes(time t, int value){
	int overflow = value/60;
	t->minutes = value%60;
	return overflow;
}

int set_seconds(time t, int value){
	int overflow = value/60;
	t->seconds = value % 60;
	return overflow;
}

void add_second(time t){
	if(set_seconds(t,t->seconds + 1) != 0)
		add_minute(t);
}

void add_minute(time t){
	if(set_minutes(t,t->minutes + 1) != 0)
		add_hour(t);
}

void add_hour(time t){
	set_hours(t,t->hours + 1);
}

void time_print(time t, char* str){
	sprintf(str, "%02d:%02d:%02d", t->hours, t->minutes, t->seconds);
}

int time_equals(time t1, time t2){
	if(t1->seconds != t2->seconds)
		return 0;
	if(t1->minutes != t2->minutes)
		return 0;
	if(t1->hours != t2->hours)
		return 0;
	return 1;
}