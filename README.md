# SORTES

**Software for Real-Time and Embedded Systems**  
_(Master in Computer Science at the KULEUVEN)_

The projects are executed on a [PIC18F97J60 Microcontroller](http://www.microchip.com/wwwproducts/Devices.aspx?dDocName=en026439) in combination with the [SDCC Compiler](http://sdcc.sourceforge.net/doc/sdccman.pdf).

### Installation 
To install the necessary binder and compiler, run the install script (install.sh). Make sure you have the package *build essentials* installed. 

###Project One: Alarm clock.
The first project assignment was the following:
>The purpose of this mini-project is to give you the opportunity to design and implement a C program running on a "naked" computer, i. e. without the services of the operating system. In particular, you will have to cope with timer interrupts to know what time it is. You will program an alarm clock on a microcontroller (a small computer-on-a chip) built by the Microchip company. On this micromputer, your programs have directly access to the memory and the peripherals. Its architecture is quite different from a classical PC and you will first have to understand it.
>
> Your alarm clock will have the following features:  
 1. The alarm clock will display time in the following format hh:mm:ss. The display will thus have to be updated at least once a second. 
 2. Hours are counted from 0 to 23; the display will thus have to jump from 23:59.59 to 00:00.00 
 3. The clock time and wake up time must be set when the board is powered up. Ringing is replaced by blinking a led every second during 30 secs. 
 4. When the clock is running, it will be possible to change the wake up time without influencing the clock; it will also be possible to change the clock time. 
 5. The yellow led must blink (1/2 second on, 1/2 second off).  
