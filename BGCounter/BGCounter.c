
#include <mega8.h>
#include <delay.h>
#include <stdio.h>

//--------------------------------
#define ADC_VREF_TYPE    0x00
#define LED              PORTC.5
#define Buzzer           PORTC.1
#define FirstSeg         PORTB.3
#define SecondSeg        PORTB.0
#define ThirdSeg         PORTB.1
#define ForthSeg         PORTB.2
#define SWRST            PINC.4
#define SWSEL            PINC.3
#define EncoderSyncValue 9
#define SW_RST           4
#define SW_RST_VAL       400
#define SW_SEL           3
#define SW_SEL_VAL       150
#define DelayForBlinking 500
#define SegOFF           10
#define RelayOut         PORTC.0
//--------------------------------
      //0b10000110;
      //--BFAEDPCG   
       
char Segments[12]        = {0b00000101,0b01111101,0b01000110,0b01010100,0b00111100,0b10010100,0b10000100,0b01011101,0b00000100,0b00010100,0b11111111,0b11111110};
char AnimSeg1[6]         = {0b11011111,0b10111111,0b11101111,0b11110111,0b11111101,0b01111111};
char AnimSeg[13]         = {0b11011111,0b10011111,0b10001111,0b10000111,0b10000101,0b00000101,0b00100101,0b01100101,0b01110101,0b01111101,0b01111111,0b11111111,0b10000110};

char FirstVal            = 0;
char SecondVal           = 0;
char ThirdVal            = 0;  
char ForthVal            = 0;  
char TimeFlag            = 1;
char DecimalPoint        = 0;
char CounterINTFlag      = 0;
bit  AnimSegFlag         = 0;
char AnimSegFrame        = 0;
int MainCounter          = 0;
char CheckCounterValue   = 0;
bit  AnimationIsOn       = 0;
eeprom long int TotalCounter  = 0;
eeprom int CounterValue  = 0;
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
switch(TimeFlag)
{
 case 1:
      FirstSeg  = 1;
      SecondSeg = 0;
      ThirdSeg  = 0;  
      ForthSeg  = 0;
      PORTD = Segments[FirstVal];   
     
      TimeFlag = 2;
 break;   
 case 2:
      PORTD = Segments[SecondVal];
      FirstSeg  = 0;
      SecondSeg = 1;
      ThirdSeg  = 0; 
      ForthSeg  = 0;
      if(DecimalPoint == 1) PORTD.2 = 0; 
      TimeFlag = 3;   
 break;
 case 3:
      PORTD = Segments[ThirdVal];  
      FirstSeg  = 0;
      SecondSeg = 0;
      ThirdSeg  = 1; 
      ForthSeg  = 0;
      TimeFlag = 4;
 break;       
 case 4:                 
 if(AnimSegFlag == 0) 
 {
      PORTD = Segments[ForthVal]; 
 }
 else
 {
      PORTD = AnimSeg[AnimSegFrame]; 
 } 
      FirstSeg  = 0;
      SecondSeg = 0;
      ThirdSeg  = 0; 
      ForthSeg  = 1;
      TimeFlag  = 1;   
   
 
 break;
}

}
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
// Place your code here


}
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
void         init()
{

// Input/Output Ports initialization
// Port B initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTB=0x00;
DDRB=0x3F;

// Port C initialization
// Func6=In Func5=Out Func4=In Func3=In Func2=In Func1=Out Func0=Out 
// State6=T State5=0 State4=T State3=T State2=T State1=0 State0=0 
PORTC=0x00;
DDRC=0x23;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 125.000 kHz
TCCR0=0x03;
TCNT0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 7.813 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x05;
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
TIMSK=0x05;

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


// Global enable interrupts

#asm("sei")
}
int          Convert(char n)
{
switch (n)
{
case '0':
return 0;break;

case '1':
return 1;break;

case '2':
return 2;break;

case '3':
return 3;break;

case '4':
return 4;break;

case '5':
return 5;break;

case '6':
return 6;break;

case '7':
return 7;break;


case '8':
return 8;break;

case '9':
return 9;break;

case ' ':
return 10;break;

case '-':
return 11;break;
}
}
void         Display(signed int value)
{
char DispSeg[4];
sprintf(DispSeg,"%4d",value);
//if(DispSeg[3] == '1')ThirdVal = 1;
//else ThirdVal = 0;
FirstVal  = Convert(DispSeg[3]);
SecondVal = Convert(DispSeg[2]);
ThirdVal  = Convert(DispSeg[1]);
ForthVal  = Convert(DispSeg[0]);

}
char         IncValue(char BaseValue,char WhichSeg)
{
 char VirVal = BaseValue;
 while(read_adc(SW_RST) > SW_RST_VAL)
 {
  switch(WhichSeg)
  {
   case 1:            
   if(VirVal == 9) {VirVal = 0;} else {VirVal++;} 
   FirstVal = VirVal;
   break;
   case 2:        
   if(VirVal == 9) {VirVal = 0;} else {VirVal++;}  
   SecondVal = VirVal;
   break;
   case 3:   
   if(VirVal == 1) {VirVal = 0;} else {VirVal++;}    
   ThirdVal = VirVal;
   break;
   case 4:
   ForthVal = VirVal;
   break;
  }
  delay_ms(300);
 }  
 return VirVal;
}
void         SetValue()
{
 //Display 
 int i=0;  
 char VirVal = 0;   
 DecimalPoint = 1 ;      
 ForthVal = 10;        
 ThirdVal = 10;
 SecondVal = 10;
 FirstVal = 0;
 Display(CounterValue);   
 while(1)
 { 
      //FirstVal  
      while(1)
      {                    
       if(FirstVal < 10) {VirVal = FirstVal;}else{VirVal = 0;}
       i=0;
       while(i < DelayForBlinking)
       {                             
        FirstVal = SegOFF; 
        delay_ms(1); i++; 
        if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,1);} 
        if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetSecondVal;}
       }
       
       i=0;
       while(i < DelayForBlinking)
       {     
        FirstVal = VirVal;
        delay_ms(1);i++;
        if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,1);}
        if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetSecondVal;}
       }  
      }  
      //SecondVal
      SetSecondVal :
      FirstVal = VirVal; 
      i = 0;    
      while(read_adc(SW_SEL) > SW_SEL_VAL)
      {
       delay_ms(1); 
       i++;
       if(i > 500)
       {
        goto End;
       }
      }
      
      Buzzer=1;
      delay_ms(80); 
      Buzzer=0;
      while(1)
      {
       if(SecondVal < 10) {VirVal = SecondVal;}else{VirVal = 0;}
       i=0;
       while(i < DelayForBlinking)
       {                             
        SecondVal = SegOFF; 
        delay_ms(1); i++; 
        if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,2);}  
        if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetThirdVal;}
       }
       
       i=0;
       while(i < DelayForBlinking)
       {     
        SecondVal = VirVal;
        delay_ms(1);i++;
        if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,2);}
        if(read_adc(SW_SEL) > SW_SEL_VAL) {goto SetThirdVal;}
       }  
      }
      //ThirdVal   
      SetThirdVal :
      SecondVal = VirVal;
      i = 0;    
      while(read_adc(SW_SEL) > SW_SEL_VAL)
      {
       delay_ms(1); 
       i++;
       if(i > 300)
       {
        goto End;
       }
      }
      Buzzer=1;
      delay_ms(80); 
      Buzzer=0;
      while(1)
      {
       if(ThirdVal < 10) {VirVal = ThirdVal;}else{VirVal = 0;}
       i=0;
       while(i < DelayForBlinking)
       {                             
        ThirdVal = SegOFF; 
        delay_ms(1); i++; 
        if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,3);}  
        if(read_adc(SW_SEL) > SW_SEL_VAL) {goto Again;}
       }
       
       i=0;
       while(i < DelayForBlinking)
       {     
        ThirdVal = VirVal;
        delay_ms(1);i++;
        if(read_adc(SW_RST) > SW_RST_VAL) {VirVal = IncValue(VirVal,3);}
        if(read_adc(SW_SEL) > SW_SEL_VAL) {goto Again;}
       }  
      }      
      Again:  
      ThirdVal = VirVal;
      i = 0;    
      while(read_adc(SW_SEL) > SW_SEL_VAL)
      {
       delay_ms(1); 
       i++;
       if(i > 300)
       {
        goto End;
       }
      }
      Buzzer=1;
      delay_ms(80); 
      Buzzer=0;
 }   
 End:
 CounterValue  =  FirstVal;
 if(SecondVal < 10) CounterValue += (SecondVal*10);
 if(ThirdVal  < 10) CounterValue += (ThirdVal*100); 
 Buzzer = 1; 
 Display(CounterValue);  
 delay_ms(150);
 Buzzer = 0;   
 delay_ms(150);
 Buzzer = 1; 
 delay_ms(150);
 Buzzer = 0; 
 delay_ms(150);   
 Buzzer = 1; 
 delay_ms(1000);
 Buzzer = 0;   
 CheckCounterValue = 1; 
 AnimationIsOn = 1;
 
}
void         StartCounting()
{
 char EncoderCounter = 0; 
 unsigned int BuzzDelay = 0;   
 unsigned int DelayCounter = 0;
 unsigned int AnimDelayCounter = 0;    
 AnimationIsOn = 0;
 MainCounter  = 0;       
 DecimalPoint = 1;
 while(1)
 {     
     if(CounterINTFlag == 0)
     {
      if(read_adc(2) > 400)
      {
        if(EncoderCounter == EncoderSyncValue)
        {
      MainCounter++;    
      TotalCounter++;   
      EncoderCounter = 0;
     }            
       else
       {
      EncoderCounter++;
     }
       Display(MainCounter);   
       DecimalPoint = 1 ;
       CounterINTFlag = 1;      
       //LED = 1;
       //delay_ms(10);
       //LED = 0;
      }          
     } 
     if((MainCounter >= CounterValue) && (CheckCounterValue == 1))
     {
     Buzzer = 1;             
     RelayOut = 1;  
     DelayCounter++;
      if(DelayCounter > 30500)
      {             
       DelayCounter = 0;
       CheckCounterValue = 0;   
       AnimSegFrame = 11;
       Buzzer = 0;
      }
     } 
     else if ((MainCounter > CounterValue - 6) && (CheckCounterValue == 1))
     {        
       LED = 1;      
       if(BuzzDelay < (400+(CounterValue - MainCounter)*200)) 
       {
       BuzzDelay++;   
       } 
       else
       {
       if(Buzzer ==1) {Buzzer = 0;}
       else           {Buzzer=1;}  
       BuzzDelay = 0;
       }
     }
  if(read_adc(2) < 400 )
  {      
     CounterINTFlag = 0;
  }
  if(read_adc(4) > 400) {delay_ms(100);break;} 
  if(read_adc(3) > 150) 
  { 
  FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 11 ;ForthVal = 11; delay_ms(500);     
  SetValue(); 
  Display(MainCounter); 
  }
   if(AnimationIsOn == 1)
  {                
   AnimSegFlag = 1;
   AnimDelayCounter++;
   if(AnimDelayCounter == 1000)
   {         
    if(CheckCounterValue == 1)
    {      
     AnimSegFrame++;  
     AnimDelayCounter = 0; 
     if(AnimSegFrame == 12)
     {
      AnimSegFrame = 0;
     } 
    } 
    else
    {
      AnimDelayCounter = 0; 
      if(AnimSegFrame == 11)AnimSegFrame = 12;
      else AnimSegFrame = 11;
    }
   }
  }
 } 
 LED = 0;
}
void main(void)
{
// Declare your local variables here
FirstVal = 10 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10;  
init();
// DDRC.1 = 0;   Buzzer OFF
if(CounterValue == -1) CounterValue = 0;
if(TotalCounter == -1) TotalCounter = 0;
AnimationIsOn = 0;
while (1)
      {              
      DecimalPoint = 0; 
      CheckCounterValue = 0;                
      RelayOut = 0;    
      Buzzer = 0;  
      AnimSegFlag = 0;
      FirstVal = 10 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10;     
      Buzzer = 1; 
      delay_ms(200);
      Buzzer = 0;                 
      //999000 Is End OF Counter  
      if(TotalCounter/100 > 9990) 
      {
       Display(TotalCounter/100);
       Buzzer = 1;
       delay_ms(5000); 
       TotalCounter = 0;   
       Buzzer = 0;
      }
      Display(TotalCounter/100); delay_ms(500);
      FirstVal = 11 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10; delay_ms(500);    
      Display(TotalCounter/100); delay_ms(500);
      FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 10 ;ForthVal = 10; delay_ms(500); 
      Display(TotalCounter/100); delay_ms(500);    
      FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 11 ;ForthVal = 10; delay_ms(500); 
      Display(TotalCounter/100); delay_ms(500);
      FirstVal = 11 ; SecondVal = 11 ; ThirdVal = 11 ;ForthVal = 11; delay_ms(500);       
      FirstVal = 0 ; SecondVal = 10 ; ThirdVal = 10 ;ForthVal = 10;      
      StartCounting();         
      }
}
