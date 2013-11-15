#include <stdio.h>
#include <stdlib.h>

#include "newtime.h"

int main(void){
	time _time;
	_time = time_create();
	time_set(_time, 10,13,14);
	char str[20];
	time_print(_time,str);
	printf("%s\n", str);
}