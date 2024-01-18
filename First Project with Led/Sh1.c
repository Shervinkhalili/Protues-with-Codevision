/*
 * Sh1.c
 *
 * Created: 25/04/2022 11:56:56 Þ.Ù
 * Author: Shervin
 */
//dr in ghesmat header haye mord niyaz ra frakhani mikonim
#include <io.h>
#include <delay.h>
#include <mega32.h>

void main(void)
{
//dr inja port A ra byd khoroji tarif konim 
DDRC=0b00000001;
//DDRC=0xff;
//PORTC=0x00;
while (1)      
      { 
            PORTC.0=1;
            delay_ms(1000);
            PORTC.0=0;
            delay_ms(1000);
     
      }
    
 }
 //*****    
//           PORTC=0x01;
//      delay_ms(1000);
//      PORTC=0x00;
//      delay_ms(1000);

 //*****


      //   { PORTC.0 =! PORTC.0;
      //    delay_ms(1000); 
      //         }

