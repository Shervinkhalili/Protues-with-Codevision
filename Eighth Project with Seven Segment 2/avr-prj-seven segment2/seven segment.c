
#include <mega32.h>     
#include <delay.h>      
#define key1   PINA.0    
#define key2   PINA.1   
     
void main(void)
{
 int a=0 ;      
 unsigned char seg[10]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};    //morefi yek araye 10 ozvi ke model hegza 0 ta 9 bray seven segment //
  
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);                    //tamam port haye C khoroji Tarif mishvand //
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);   

DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);                    //tamam port haye A Vorodi Tarif mishvand//
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);   

while (1)
 {
      
 PORTC=seg[a];       //dar sorti ke hich kelidi zade nshvd meqdr motaqir a ra roye seven segment neshan midahd//

  if (key1 == 0)           //dar sorti ke kild 1 feshar dade shavd vared shard if mishavd.//
   {
     a++ ;               //be motaqir a yeki ezafe mikonad//
     if (a>9) {  a=0; }     //dastor ke baes mishvad motaqir a bishtr az 9 nshvd//
     PORTC=seg[a];          
     delay_ms(1000);        
   }

   if (key2 == 0)          //dar sorti ke kild 2 feshar dade shavd vared shard if mishavd.//
   {
     a-- ;              //az motaqir a yeki kam mikonad//
     if (a<0) {  a=0; }    //dastor ke baes mishvad motaqir a kmtr az 0 nshvd//
     PORTC=seg[a];         //nameyesh motaqir A roye seven segment//
     delay_ms(1000);                      
   }
 }
}