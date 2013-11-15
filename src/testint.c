#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION
#include "../Include/HardwareProfile.h"

#include <string.h>
#include <stdlib.h>

#include "../Include/LCDBlocking.h"
#include "../Include/TCPIP_Stack/Delay.h"

#define LOW(a)     (a & 0xFF)
#define HIGH(a)    ((a>>8) & 0xFF)
#define CLOCK_FREQ 40000000     //40 MHz
#define EXEC_FREQ CLOCK_FREQ/4  //4 clock cycles to execute 1 instruction
void DisplayString(BYTE pos, char* text);
void DisplayWORD(BYTE pos, WORD w);
void DisplayIPValue(DWORD IPdw);
size_t strlcpy(char *dst, const char *src, size_t siz);
 
void dumb_delay1ms (void);

void high_isr (void) interrupt 1
{
    if(INTCON3bits.INT1F  = 1)
    {
        LED1_IO ^= 1; //change state of red leds
        LED2_IO ^= 1; 
        if(BUTTON0_IO);  //just read the bit
        INTCON3bits.INT1F  = 0;   //clear INT1 flag
    }
}


void main(void)
    {
    int i;

    LED0_TRIS = 0; //configure 1st led pin as output (yellow)
    LED1_TRIS = 0; //configure 2nd led pin as output (red)
    LED2_TRIS = 0; //configure 3rd led pin as output (red)

    BUTTON0_TRIS = 1; //configure button0 as input

    RCONbits.IPEN      = 1;   //enable interrupts priority levels
    INTCON3bits.INT1P  = 1;   //connect INT1 interrupt (button 2) to high prio
    INTCON2bits.INTEDG1= 0;   //INT1 interrupts on falling edge
    INTCONbits.GIE     = 1;   //enable high priority interrupts
    INTCON3bits.INT1E  = 1;   //enable INT1 interrupt (button 2)
    INTCON3bits.INT1F  = 0;   //clear INT1 flag
 
    LCDInit();
    for(i=0;i<100;i++) dumb_delay1ms();

    DisplayString (0,"Hello World"); //first arg is start position
                                     // on 32 positions LCD

    while(1)
    {
        //blink the yellow led with a 2 secons period
        LED0_IO ^=1;
        for(i=0;i<1000;i++) dumb_delay1ms(); 
    }
}
 
/*************************************************
 Function DisplayWORD:
 writes a WORD in hexa on the position indicated by
 pos. 
 - pos=0 -> 1st line of the LCD
 - pos=16 -> 2nd line of the LCD

 __SDCC__ only: for debugging
*************************************************/
#if defined(__SDCC__)
void DisplayWORD(BYTE pos, WORD w) //WORD is a 16 bits unsigned
{
    BYTE WDigit[6]; //enough for a  number < 65636: 5 digits + \0
    BYTE j;
    BYTE LCDPos=0;  //write on first line of LCD
    unsigned radix=10; //type expected by sdcc's ultoa()

    LCDPos=pos;
    ultoa(w, WDigit, radix);      
    for(j = 0; j < strlen((char*)WDigit); j++)
    {
       LCDText[LCDPos++] = WDigit[j];
    }
    if(LCDPos < 32u)
       LCDText[LCDPos] = 0;
    LCDUpdate();
}

// /*************************************************
//  Function DisplayString: 
//  Writes string to the LCD display starting at pos
//  since strlcopy writes the final \0, only 31 characters 
//  are really usable on the LCD
//*************************************************/
// void DisplayString(BYTE pos, char* text)
// {
//   BYTE l= strlen(text)+1;/* l must include the finam \0, so, it is strlen+1*/
//    BYTE max= 32-pos;
//    strlcpy((char*)&LCDText[pos], text,(l<max)?l:max );
//    LCDUpdate();
// 
// }

/*************************************************
 Function DisplayString: 
 Writes the first characters of the string in the remaining 
 space of the 32 positions LCD, starting at pos
 (does not use strlcopy, so can use up to the 32th place)
*************************************************/
void DisplayString(BYTE pos, char* text)
{
   BYTE        l = strlen(text);/*number of actual chars in the string*/
   BYTE      max = 32-pos;      /*available space on the lcd*/
   char       *d = (char*)&LCDText[pos];
   const char *s = text;
   size_t      n = (l<max)?l:max;
   /* Copy as many bytes as will fit */
    if (n != 0)
      while (n-- != 0)*d++ = *s++;
   LCDUpdate();

}

#endif


/*-------------------------------------------------------------------------
 *
 * strlcpy.c
 *    strncpy done right
 *
 * This file was taken from OpenBSD and is used on platforms that don't
 * provide strlcpy().  The OpenBSD copyright terms follow.
 *-------------------------------------------------------------------------
 */

/*  $OpenBSD: strlcpy.c,v 1.11 2006/05/05 15:27:38 millert Exp $    */

/*
 * Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
 
/*
 * Copy src to string dst of size siz.  At most siz-1 characters
 * will be copied.  Always NUL terminates (unless siz == 0).
 * Returns strlen(src); if retval >= siz, truncation occurred.
 * Function creation history:  http://www.gratisoft.us/todd/papers/strlcpy.html
 */
size_t
strlcpy(char *dst, const char *src, size_t siz)
{
    char       *d = dst;
    const char *s = src;
    size_t      n = siz;

    /* Copy as many bytes as will fit */
    if (n != 0)
    {
        while (--n != 0)
        {
            if ((*d++ = *s++) == '\0')
                break;
        }
    }

    /* Not enough room in dst, add NUL and traverse rest of src */
    if (n == 0)
    {
        if (siz != 0)
            *d = '\0';          /* NUL-terminate dst */
        while (*s++)
            ;
    }



    return (s - src - 1);       /* count does not include NUL */
}


void dumb_delay1ms (void)
{
    TMR0H = HIGH (0x10000-EXEC_FREQ/1000);
    TMR0L = LOW  (0x10000-EXEC_FREQ/1000);
    T0CONbits.TMR0ON = 0;  //disable timer0
    T0CONbits.T08BIT = 0;  //use timer0 16-bit counter
    T0CONbits.T0CS   = 0;  //use timer0 instruction cycle clock
    T0CONbits.PSA    = 1;  //disable timer0 prescaler
    INTCONbits.T0IF   = 0;  //clear timer0 overflow bit
    T0CONbits.TMR0ON = 1;  //enable timer0
    while(!INTCONbits.T0IF){} //busy wait for timer0 to overflow
    INTCONbits.T0IF   = 0;  //clear timer0 overflow bit
    T0CONbits.TMR0ON = 0;  //disable timer0   
}
