#include <stdio.h>
#include "time.h"

int main(void){
        seconds_since_midnight = 3691;
        printf("HOURS: %d\n", get_hours());
        printf("MINS: %d\n", get_minutes());
        printf("seconds: %d\n", get_seconds());
        printf("%s\n", time2string());
}