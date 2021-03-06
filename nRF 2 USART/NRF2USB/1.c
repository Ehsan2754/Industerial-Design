/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 9/8/2013
Author  : PerTic@n
Company : If You Like This Software,Buy It
Comments: 


Chip type               : ATmega8
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega8.h>
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <spi.h>

/* NRF24L01+ Module */
#define NRF_CE       PORTC.1
#define NRF_CE_DDR   DDRC.1
#define NRF_CSN      PORTC.0
#define NRF_CSN_DDR  DDRC.0
#include <R2T\hjnrf24l01p.h>
#include <R2T\hjnrf24l01p.c>
#include <R2T\nrf24l01.h>
#include <R2T_Debug.h>

#ifndef RXB8
#define RXB8 1
#endif

#ifndef TXB8
#define TXB8 0
#endif

#ifndef UPE
#define UPE 2
#endif

#ifndef DOR
#define DOR 3
#endif

#ifndef FE
#define FE 4
#endif

#ifndef UDRE
#define UDRE 5
#endif

#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)

// USART Receiver buffer
#define RX_BUFFER_SIZE 8
char rx_buffer[RX_BUFFER_SIZE];

#if RX_BUFFER_SIZE <= 256
unsigned char rx_wr_index,rx_rd_index,rx_counter;
#else
unsigned int rx_wr_index,rx_rd_index,rx_counter;
#endif

// This flag is set on USART Receiver buffer overflow
bit rx_buffer_overflow;

// USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void)
{
char status,data;
status=UCSRA;
data=UDR;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer[rx_wr_index++]=data;
#if RX_BUFFER_SIZE == 256
   // special case for receiver buffer size=256
   if (++rx_counter == 0) rx_buffer_overflow=1;
#else
   if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
   if (++rx_counter == RX_BUFFER_SIZE)
      {
      rx_counter=0;
      rx_buffer_overflow=1;
      }
#endif
   }
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter==0);
data=rx_buffer[rx_rd_index++];
#if RX_BUFFER_SIZE != 256
if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
#endif
#asm("cli")
--rx_counter;
#asm("sei")
return data;
}
#pragma used-
#endif

// Standard Input/Output functions
#include <stdio.h>

// SPI functions
#include <spi.h>

// Declare your global variables here
char tx_address[5] = {0xE7,0xE7,0xE7,0xE7,0xE7};
char rx_address[5] = {0xD7,0xD7,0xD7,0xD7,0xD7};
void init()
{
// Declare your local variables here

// Input/Output Ports initialization
// Port B initialization
// Func7=In Func6=In Func5=Out Func4=In Func3=Out Func2=Out Func1=In Func0=In 
// State7=T State6=T State5=0 State4=T State3=0 State2=0 State1=T State0=T 
PORTB=0x00;
DDRB=0x2C;

// Port C initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=Out 
// State6=T State5=T State4=T State3=T State2=T State1=0 State0=0 
PORTC=0x00;
DDRC=0x03;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=Out Func3=Out Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=0 State3=0 State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x18;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
TCCR0=0x00;
TCNT0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
MCUCR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

//// USART initialization
//// Communication Parameters: 8 Data, 1 Stop, No Parity
//// USART Receiver: On
//// USART Transmitter: On
//// USART Mode: Asynchronous
//// USART Baud Rate: 115200
//UCSRA=0x00;
//UCSRB=0x98;
//UCSRC=0x86;
//UBRRH=0x00;
//UBRRL=0x03;
// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x33;
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC disabled
ADCSRA=0x00;

// SPI initialization
// SPI Type: Master
// SPI Clock Rate: 2000.000 kHz
// SPI Clock Phase: Cycle Start
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=0x50;
SPSR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

// Global enable interrupts
#asm("sei")
}
void main(void)
{
      init(); 
      PcDbg("R2T Debugger Wireless Link init...");
      nrf24_config(DebugChannel);
      nrf24_tx_address(tx_address);
      nrf24_rx_address(rx_address); 
      PcDbg("WifiLink Address:0xD7,0xD7,0xD7,0xD7,0xD7"); 
      printf("WifiLink Channel:%d#");
      PcDbg("<>-----WifiLink is activated and ready-----<>");
             
while (1)
      {
      // Place your code here   
        char str[32] = "";
        if(nrf24_dataReady())
        { 
         PORTD.3 = 1;
         CurrentPayLoad = nrf24_dynamicpayload_length();
         if(CurrentPayLoad > 32)PcDbg("RXPayload length Error");
         nrf24_getData(str);   
         SendDataNFixed(str,CurrentPayLoad); 
         PORTD.3 = 0;
        }
        nrf24_powerUpRx(); 
        delay_ms(1);
        PORTD.4 = 1;
                               
//        /* Automatically goes to TX mode */
//        nrf24_send(str);        
//        
//        /* Wait for transmission to end */
//        while(nrf24_isSending());
//        
//        //ToDO : NRF_CE = 0;
//        /* Make analysis on last tranmission attempt */
//        temp = nrf24_lastMessageStatus();
//
//        if(temp == NRF24_TRANSMISSON_OK)
//        {                    
//            PcDbg("Transmision done.");
//        }
//        else if(temp == NRF24_MESSAGE_LOST)
//        {                    
//            PcDbg("Message is lost.");   
//        }
//        
//		/* Retranmission count indicates the tranmission quality */
//		temp = nrf24_retransmissionCount();
//		if (temp > 0) printf("> Retranmission count: %d#",temp);
//
//		/* Optionally, go back to RX mode ... */
//		//nrf24_powerUpRx();
//
//		/* Or you might want to power down after TX */
//		// nrf24_powerDown();            
//
//		/* Wait a little ... */
//		delay_ms(100); 
      }
}
