/*
 * PM.c
 *
 * Created: 22/04/2022 12:30:47 �.�
 * Author: Shervin
 */

#include <io.h>
#include <mega32.h>
#include <delay.h>
void blink();  //Tabe ra byad ye bar tarif konim dar ghesmat aval barname
void blink1(); 
void blink2(); 
void blink3(); 



void main(void)
{

DDRA=0b11111111;      //PortA Ra khoroji Tarif mikonim
while (1)
    {
         //Tabe ra dar in ghesmat be estfade az Namesh Frakhni mikhonim      
         blink();
         blink();
         blink();
         blink1();
         blink1();
         blink1();
         blink2();
         blink2();
         blink2(); 
         blink3();
         blink3();
         blink3();
}
}
void blink()
{
   // Dastoroat Lazem ra unja minivsim
    PORTA=0b00000001;
    delay_ms(1000);
    
    PORTA=0b00000010;
    delay_ms(1000);
    
    PORTA=0b00000100;
    delay_ms(1000);
    
    PORTA=0b00001000;
    delay_ms(1000);
    
    PORTA=0b00010000;
    delay_ms(1000);
    
    PORTA=0b00100000;
    delay_ms(1000);
    
    PORTA=0b01000000;
    delay_ms(1000);
    
    PORTA=0b10000000;
    delay_ms(1000);
}
  void blink1()
  {
    PORTA=0b00001111;
    delay_ms(1000); 
     PORTA=0b0000000;
    delay_ms(1000);
  }   
  
  void blink2 ()
  {
    PORTA=0b10000001;
    delay_ms(1000); 
     PORTA=0b1100011;
    delay_ms(1000);
      PORTA=0b1110111;
    delay_ms(1000);
      PORTA=0b1111111;
    delay_ms(1000);
  }       
  
   void blink3()
  {
    PORTA=0b11111111;
    delay_ms(1000); 
     PORTA=0b0000000;
    delay_ms(1000);
}

