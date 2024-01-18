/*
 * Shervin khalili 
 *
 * Created: 11/12/2021 09:47:08 È.Ù
 * Author: admin
 */

#include <io.h>
 #include <mega32.h>
 #define F_CPU 1000000
 #include <interrupt.h>
 #include <delay.h>
 int n=0,second=0,minute=0 , hour=0;
 flash char control [8] ={0b11111110,0b11111101,0b11111011,0b11110111,0b11101111,0b11011111,0b10111111,0b01111111}; 
 flash char seven [10] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
 flash char sevendp [1] = {0x80};      // '.' bein clock

void main(void)
{
  int start;
 DDRA = 0XFF;
 DDRC = 0XFF;
 DDRD = 0XFF;
 start=1; 
while (1)
    {
    // Please write your application code here
        PORTC = control[0];             
          PORTA = seven[second % 10];
          delay_ms(5);
       PORTC = control [1];            
          PORTA = seven[second /10];
          delay_ms(5);
       PORTC = control[2];
          PORTA = sevendp[0];
          delay_ms(5);    
       PORTC = control[3];
          PORTA = seven[minute % 10];
          delay_ms(5);
       PORTC = control [4];
          PORTA = seven[minute /10];
          delay_ms(5);
       PORTC = control [5]; 
          PORTA = sevendp[0];
          delay_ms(5);
       PORTC = control[6];
          PORTA = seven[hour % 10];
          delay_ms(5);
       PORTC = control [7];
          PORTA = seven[hour /10];
          delay_ms(5);
          if (start==1)
    {    
         if(PIND.1==0)     //ziyad v kam shdon autmoat 
         {
             n++; // n ye jori shabi be delay ast
            if(n >= 3){    
               second++;
               if(second >=60){
                  minute++; 
                  second = 0;
                  if (minute >=60){
                     hour++;
                     minute = 0;
                     if (hour >=24)
                        hour = 0;
                  }
               }                           
               n = 0;
            }  
          }
       else
       {     
            n++;   // n ye jori shabi be delay ast
            if(n >= 3){    
               second--;
               if(second <=0){
                  minute--; 
                  second = 59;
                  if (minute <=0){
                     hour--;
                     minute = 59;
                     if (hour <=0)
                        hour = 23;
                  }
               }                           
               n = 0;
            }

       }   
    }
          if(PIND.0==1)          //roshan v khamosh kardan
          {        
           start=0;         
           }                 
          else
          {        
           start=1;                  
           }   
           
           if(PIND.5==0)    // dasti ziyad v kam mikond
           { 
            if(PIND.2==1) 
            {      
             delay_ms(200);
             hour++; 
              if (hour>=24)
              hour=0;
            } 
            if(PIND.3==1) 
            {      
            delay_ms(200);
            minute++; 
            if (minute>=60)
            minute=0;
            }
            if(PIND.4==1) 
            {      
            delay_ms(200);
            second++; 
            if (second>=60)
            second=0;
            }
            }
            else
            {
            if(PIND.2==1) 
            {      
            delay_ms(200);
            hour--; 
            if (hour<=0)
            hour=23;
            } 
            if(PIND.3==1) 
            {      
            delay_ms(200);
            minute--; 
            if (minute<=0)
            minute=59;
            }
            if(PIND.4==1) 
            {      
            delay_ms(200);
            second--; 
            if (second<=0)
            second=59;
            }
           }
    }     
   
}


// interrupt[TIM0_OVF]void timer0_ovf_isr (void)
// {
//    if(PIND.1==0)
//         n++;
//            if(n >= 1953){    
//               second++;
//               if(second >=60){
//                  minute++; 
//                  second = 0;
//                  if (minute >=60){
//                     hour++;
//                     minute = 0;
//                     if (hour >=24)
//                        hour = 0;
//                  }
//               }                           
//               n = 0;
//            }  
//       
//       else
//       {     
//            n++;
//            if(n >= 1953){    
//               second--;
//               if(second <=0){
//                  minute--; 
//                  second = 59;
//                  if (minute <=0){
//                     hour--;
//                     minute = 59;
//                     if (hour <=0)
//                        hour = 23;
//                  }
//               }                           
//               n = 0;
//            }

//       }   
//}
//void main(void)
// DDRA = 0XFF;
// DDRC = 0XFF;
//// TCCR0 = 0X01;
//// TIMSK = 0B00000001;
// DDRD=0XFF;
//    //sei ();
//   // #asm("sei")
// while(1)
// if(PIND.0==1)
//          {        
//           start=0;
//           PORTD.0=0;
////           TIMSK = 0B00000000;
//                              
//           } 
// else
//          {        
//           start=1;
//           PORTD.0=1;
////           TIMSK = 0B00000001;                   
//           }
 
