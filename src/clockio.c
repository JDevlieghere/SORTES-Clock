#include "clockio.h"

/**
 * Displays the given string at the given position on the LCD. 
 */
void display_string(BYTE pos, char* text){
	BYTE        l = strlen(text);
	BYTE      max = 32-pos;    
	char       *d = (char*)&LCDText[pos];
	const char *s = text;
	size_t      n = (l<max)?l:max;
	if (n != 0)
		while (n-- != 0)*d++ = *s++;
	LCDUpdate();
}

/**
 * Updates the display and prints the current time. 
 */
void display_update(time t){
	char display_line[32];
	time_print(t, display_line);
	display_string(0, display_line);
}

/**
 * Display strings on first and second line of LCD display.
 */
void display_line(char *top, char *bottom){
	display_string(START_FIRST_LINE, top);
	display_string(START_SECOND_LINE, bottom);
}

/**
 * Gets the desired value for the given setting. 
 */
int get_input(int maxvalue, char *text, char *mode, int * btn_next, int *btn_confrm){
	BYTE length = strlen(text);
	int value = 0;
	display_line(mode, text);
	while(1){
		if(read_and_clear(btn_confrm)){
			LCDErase();
			return value;
		}
		if(read_and_clear(btn_next)){ 
			value = (++value)%maxvalue;
		}
		display_string(START_SECOND_LINE + length + 1, to_double_digits(value));
	}
}

/**
 * Returns a pointer to a string of the double digit representation of the given value. 
 */
char* to_double_digits(int value){
	static char buffer[3];
	sprintf(buffer, "%02d", value);
	return buffer;
}

/**
 * Returns whether the given int represents true and sets it to false. 
 */
int read_and_clear(int *variable){
	if(*variable){
		*variable = 0;
		return 1;
	}
	return 0;
}