/*
 * Seven.c
 *
 * Created: 5/23/2022 10:42:01 PM
 * Author: Shervin
 */
#include <io.h>
#include <mega32.h>
#include <delay.h>
//char seg [] = { 63 , 6 , 91 , 79 ,102 , 109 ,125 ,7 , 127 , 111};
char seg [] = {0x3F , 0x06 , 0x5B ,0x4F , 0x66 , 0x6D , 0x7D , 0x07 , 0x7F , 0x6F};
 
void main(void)
{
    DDRC = 0b11111111 ;
 
while (1)
      {  int i ;
         for (i = 0 ; i<10 ; i++)
         {
            PORTC = seg[i];
            delay_ms(500 ) ;
 
         } 
     
 
      }
}