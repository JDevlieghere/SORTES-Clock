AS = gpasm
CC = sdcc
CFLAGS= -c -mpic16 -p18f97j60 -o $@ 
LD = sdcc
LDFLAGS= -mpic16 -p18f97j60 -L /usr/local/lib/pic16 -llibio18f97j60.lib \
				 -llibdev18f97j60.lib -llibc18f.lib -L include
AR = ar
RM = rm

OBJECTS= objects/LCDBlocking.o objects/time.o objects/clockio.o

SDCC_HEADERS=/usr/local/share/sdcc/include/string.h \
	 /usr/local/share/sdcc/include/stdlib.h \
	 /usr/local/share/sdcc/include/stdio.h \
	 /usr/local/share/sdcc/include/stddef.h \
	 /usr/local/share/sdcc/include/stdarg.h \
	 /usr/local/share/sdcc/include/malloc.h 

SDCC_PIC16_HEADERS=/usr/local/share/sdcc/include/pic16/pic18f97j60.h

TCPIP_HEADERS=   Include/TCPIP_Stack/ETH97J60.h \
	 Include/TCPIP_Stack/LCDBlocking.h 

APP_HEADERS=Include/GenericTypeDefs.h \
	 Include/Compiler.h \
	 Include/HardwareProfile.h 


clock : objects/clock.o $(OBJECTS)
	@echo "#################### BUILD INIT ####################"
	$(LD) $(LDFLAGS) objects/clock.o $(OBJECTS)
	@echo "#################### BUILD DONE ####################"


objects/clock.o : src/clock.c $(SDCC_HEADERS) $(SDCC_PIC16_HEADERS) \
	 $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) $(CFLAGS) src/clock.c


objects/LCDBlocking.o : lib/LCDBlocking.c $(SDCC_HEADERS)  \
	 $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60 -IInclude -I/usr/local/share/sdcc/include/ -I/usr/local/share/sdcc/include/pic16 -o "objects/LCDBlocking.o" \
							-L/usr/local/lib/pic16  lib/LCDBlocking.c

objects/Tick.o : lib/Tick.c  $(SDCC_HEADERS)  \
	 $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -IInclude -I/usr/local/share/sdcc/include/ -I/usr/local/share/sdcc/include/pic16 -o "objects/Tick.o" \
							-L/usr/local/lib/pic16  lib/Tick.c

objects/time.o : src/time.c $(SDCC_HEADERS)  \
	 $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60 -IInclude -I/usr/local/share/sdcc/include/ -I/usr/local/share/sdcc/include/pic16 -o "objects/time.o" \
							-L/usr/local/lib/pic16  src/time.c		

objects/clockio.o : src/clockio.c $(SDCC_HEADERS)  \
	 $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60 -IInclude -I/usr/local/share/sdcc/include/ -I/usr/local/share/sdcc/include/pic16 -o "objects/clockio.o" \
							-L/usr/local/lib/pic16  src/clockio.c									

test : objects/test.o $(OBJECTS)
	$(LD) $(LDFLAGS) objects/test.o $(OBJECTS)

objects/test.o : src/test.c $(SDCC_HEADERS) $(SDCC_PIC16_HEADERS) \
	 $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) $(CFLAGS)  src/test.c

testint : objects/testint.o $(OBJECTS)
	$(LD) $(LDFLAGS) objects/testint.o $(OBJECTS)

objects/testint.o : src/testint.c $(SDCC_HEADERS) $(SDCC_PIC16_HEADERS) \
	 $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) $(CFLAGS) src/testint.c

clean : 
	$(RM) -rf objects/* 
	$(RM) *.hex *.lst *.asm *.cod
	clear