/*******************************************************
Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 1/000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/
#include <mega32.h>
#include <delay.h>
#include <stdlib.h>   //bray tabee random
#include <alcd.h>
int key =1;
char getkey();        //bray estefade az keypad shomaryi ke vard mishvad ra dr dron khodsh bshd
interrupt [EXT_INT0] void ext_int0_isr(void)
{
char k;
lcd_clear();
k = getkey();
  if (k!=0xff){
    if(k == key){
    lcd_gotoxy(6,9);
    lcd_putsf("Thats correct...") ;
    }
    else{
     lcd_gotoxy(0,0);
    lcd_putsf("Incorrect answer"); 
    lcd_gotoxy(2,1);
    lcd_putsf("answer is ") ;
   }                         
  } 
  else 
  {
   lcd_gotoxy(6,9);
   lcd_putsf("what??");
  }
    
  PORTB=key;
  delay_ms(1000);
  lcd_clear();
  key = rand()%10;
  PORTB=0;
  lcd_gotoxy(0,0);
  lcd_putsf("Guest the number???"); 
}

void main(void)
{
 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);


TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0=0x00;


TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
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

ASSR=0<<AS2;
TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Falling Edge
GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);
MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);

// USART initialization
// USART disabled
UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);

ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME);

ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

// SPI initialization
// SPI disabled
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
// TWI initialization
// TWI disabled
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

lcd_init(16);

// Global enable interrupts
#asm("sei")
DDRB=0xFF;
PORTB=0x00;
DDRC=0xf0;
PORTC=0x0f;
lcd_gotoxy(0,0);
lcd_putsf("Guest the number");
while (1)
      {
      // Place your code here

      }
}
char getkey(){
  unsigned char key_code = 0xFF;       //az in motaqir dr interupt estfade konim
    PORTD=0xFF;
    
    PORTC.4=0; 
    if(PINC.0==0){key_code=1;}
    if(PINC.1==0){key_code=2;}
    if(PINC.2==0){key_code=3;}
    PORTC.4=1;  
    
     PORTC.5=0; 
    if(PINC.0==0){key_code=4;}
    if(PINC.1==0){key_code=5;}
    if(PINC.2==0){key_code=6;}
    PORTC.5=1;  
    
     PORTC.6=0; 
    if(PINC.0==0){key_code=7;}
    if(PINC.1==0){key_code=8;}
    if(PINC.2==0){key_code=9;}
    PORTC.6=1;
    
     PORTC.7=0; 
    if(PINC.0==0){key_code=10;}
    if(PINC.1==0){key_code=0;}
    if(PINC.2==0){key_code=11;}
    PORTC.7=1;  
    
    PORTC=0x0f;
    return key_code;
}