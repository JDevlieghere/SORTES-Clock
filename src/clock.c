#define __18F97J60
#define __SDCC__
#define CLOCK_FREQ 	40000000 	// 40 Mhz
#define THIS_INCLUDES_THE_MAIN_FUNCTION

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "../Include/HardwareProfile.h"
#include "../Include/LCDBlocking.h"
#include "time.h"

/* Method declaration. */
void DisplayString(BYTE pos, char* text);

int main(void){
	LCDInit();
	seconds_since_midnight = 3691;
 	DisplayString(0, time2string());
	return 0;
}

void DisplayString(BYTE pos, char* text)
{
   BYTE        l = strlen(text);/*number of actual chars in the string*/
   BYTE      max = 32-pos;    /*available space on the lcd*/
   char       *d = (char*)&LCDText[pos];
   const char *s = text;
   size_t      n = (l<max)?l:max;
   /* Copy as many bytes as will fit */
    if (n != 0)
      while (n-- != 0)*d++ = *s++;
   LCDUpdate();
}
