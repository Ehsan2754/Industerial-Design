/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 2/12/2015
Author  : Dr.Ehsan.sh
Company : R2T-COMPANY
Comments:7-segs are commen catods;;; 
.
..
...
....
.....
......
Chip type               : ATmega8
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/
//Headers
#include <mega8.h>
#include <delay.h>
#include <math.h>

//Defines
#define seg1 PINB.0
#define seg2 PINB.1
#define A PIND.0
#define B PIND.1
#define C PIND.0
#define D PIND.0
#define E PIND.0
#define F PIND.0
#define G PIND.0
#define DOT PIND.0
#define sensor PORTC.0
#define ADC_VREF_TYPE 0x00
char a= 121;
//char R = 119;

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}


void ch_7 ()
{
 if (seg1 == 0 ^ seg2 == 1)
{
 delay_ms(200);
 seg1 = 1 ;
 seg2 = 0 ;
} 
else if (seg2==0 ^ seg1 == 1)
{
 seg1 = 0 ;
 seg2 = 1 ;
}
else {
 seg1 = 0 ;
 seg2 = 1 ;

}
}

float out_adc ()//temp formula
{
 float temp; 
 float out ;
 temp = read_adc(0);/*CHECK THE FOORMULA*/
 if ((temp <10 ^ temp > -10))
{
   return temp;
 }
 else if ((temp>10 ^ temp <100)||(temp<-10 ^ temp >-100))
 {
  out = floor(temp);
  return out;
 }  
 else if (temp >100)
 {
    return E;
 }    
}

// Declare your global variables here
void set_chip()
{
 
// Declare your local variables here

// Input/Output Ports initialization
// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=Out 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=0 
PORTB=0x00;
DDRB=0x03;

// Port C initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State6=T State5=T State4=T State3=T State2=T State1=T State0=P 
PORTC=0x01;
DDRC=0x00;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

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

// USART initialization
// USART disabled
UCSRB=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AREF pin
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x83;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

}
void main(void)
{
while (1)
      {
      // Place your code here 
      set_chip();
      
        
     
      }
}
