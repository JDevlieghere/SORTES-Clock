#ifndef __CLOCKIO_H_
#define __CLOCKIO_H_

#define __18F97J60
#define __SDCC__

// Defines for easy use of the LCD. 
#define START_FIRST_LINE 0 
#define START_SECOND_LINE 16 

// INCLUDES
#include <stdlib.h>
#include <stdio.h>

#include "../Include/HardwareProfile.h"
#include "../Include/LCDBlocking.h"

#include "time.h"

void display_string(BYTE pos, char* text);
void display_update(time t);
void display_line(char *top, char *bottom);
int get_input(int maxvalue, char *text, char *mode, int * btn_next, int *btn_confrm);
char* to_double_digits(int value);
int read_and_clear(int *variable);

#endif