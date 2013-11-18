# SORTES

**Software for Real-Time and Embedded Systems**  
_(Master in Computer Science at the KULEUVEN)_

The projects are executed on a [PIC18F97J60 Microcontroller](http://www.microchip.com/wwwproducts/Devices.aspx?dDocName=en026439) in combination with the [SDCC Compiler](http://sdcc.sourceforge.net/doc/sdccman.pdf).

## Installation 
Make sure you have the package *build essentials* installed. To install the necessary compiler and utilities run the install script `install.sh` located in the install directory. 

##Project One: Alarm clock.
The first project assignment was the following:
>The purpose of this mini-project is to give you the opportunity to design and implement a C program running on a "naked" computer, i. e. without the services of the operating system. In particular, you will have to cope with timer interrupts to know what time it is. You will program an alarm clock on a microcontroller (a small computer-on-a chip) built by the Microchip company. On this micromputer, your programs have directly access to the memory and the peripherals. Its architecture is quite different from a classical PC and you will first have to understand it.
>
> Your alarm clock will have the following features:  
 1. The alarm clock will display time in the following format hh:mm:ss. The display will thus have to be updated at least once a second. 
 2. Hours are counted from 0 to 23; the display will thus have to jump from 23:59.59 to 00:00.00 
 3. The clock time and wake up time must be set when the board is powered up. Ringing is replaced by blinking a led every second during 30 secs. 
 4. When the clock is running, it will be possible to change the wake up time without influencing the clock; it will also be possible to change the clock time. 
 5. The yellow led must blink (1/2 second on, 1/2 second off).  

### Deployment
To build and deploy the clock to the PIC a shell script is available. The script will make the `clock.hex` file and start tftp which will wait for input from the user. 
```
$ ./deploy.sh
```
Enter the following command but do not press return just yet. Reset the PIC and wait for the corresponding LED on the router to light up, then press return.
```
put clock.hex     
```
When all of this succeeds, you'll see something like this. The amount of time and bytes may differ.
```
$ make clock 
#################### BUILD INIT ####################
sdcc -mpic16 -p18f97j60 -L /usr/local/lib/pic16 -llibio18f97j60.lib -llibdev18f97j60.lib -llibc18f.lib -L include objects/clock.o objects/LCDBlocking.o objects/newtime.o
message: using default linker script "/usr/local/share/gputils/lkr/18f97j60.lkr"
#################### BUILD DONE ####################
$ ./deploy.sh 
starting tftp to 192.168.97.6
put clock.hex
tftp> tftp> Sent 35956 bytes in 2.1 seconds
```