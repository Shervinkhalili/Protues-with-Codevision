/*******************************************************

Project : strongbox  
Date    : 12/20/2021
Author  : Sadra.Termehbaf & Shervin Khalili 
 

Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 1.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32.h>
#include <delay.h>
#include <stdlib.h>
// Alphanumeric LCD functions
#include <alcd.h>

 //Declare your global variables here
flash int Pattern[4]={0xFE, 0xFD, 0xFB, 0xF7};
flash int key_number [4][3]={{7,8,9},{4,5,6},{1,2,3},{11,0,10}};
int total_number=1 , a , b , c , d ;
char password[4];
int y11,y12,y13,y14,y15;
int my_password=0000; 
int key(void)
{
    while(1)
    {   int j, column = 3;

          for( j=0; j<4; j++)
          {
             PORTD = Pattern[j];
             
             if (PIND.4 == 0)
             {
               column  = 0;
               while (PIND.4 == 0) {};
               break;
             }
             else
                 if (PIND.5 == 0)
                 {
                   column  = 1;
                   while (PIND.5 == 0) {};
                   break;
                 }
                 else
                     if (PIND.6 == 0)
                     {
                       column  = 2;
                       while (PIND.6 == 0) {};
                       break;
                     }

             }

              if (column != 3) 
                  return key_number[j][column];

      
    }
}
void amaliat (int y)
{
    if(total_number==1) 
    {
        y11=y;
        total_number++;
        a = y ;
        lcd_clear();
        lcd_puts("*");
    }
        else if(total_number==2) 
        {
            y12=y;
            total_number++;
            b = y ;
            lcd_clear();
            lcd_puts("**");
        }
        else if(total_number==3) 
        {
            y13=y;
            total_number++;
            c = y ;
            lcd_clear();
            lcd_puts("***");
        }
        else if(total_number==4) 
        {
            y14=y;
            total_number=1;
            d = y ;
            lcd_clear();
            lcd_puts("****");
            delay_ms(1000);
            lcd_clear();
            itoa( a , password ) ; lcd_puts(password);
            itoa( b , password ) ; lcd_puts(password);
            itoa( c , password ) ; lcd_puts(password);
            itoa( d , password ) ; lcd_puts(password);
            delay_ms(1000);
            lcd_clear();
            y15=y11*1000+y12*100+y13*10+y14;
            if(y15==my_password)
            {
                lcd_gotoxy(0,0);
                lcd_putsf("your pass is");
                lcd_gotoxy(0,1);
                lcd_putsf("      correct");
                delay_ms(1000);
                lcd_clear();
                lcd_putsf("open!");
                PORTC.0 = 0;
                delay_ms(1000);
                lcd_clear();
            }
            else
            {
                lcd_gotoxy(0,0);
                lcd_putsf("your pass is");
                lcd_gotoxy(0,1);
                lcd_putsf("    incorrect");
                delay_ms(1000);
                lcd_clear();
            }
        };
}
void main(void)
{
// Declare your local variables here
     int y;
     int y1,y2,y3,y4,y5;
     int i=1;
     char aray[];
     int y6,y7,y8,y9,y10;
// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=Out 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (1<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 0
// RD - PORTA Bit 1
// EN - PORTA Bit 2
// D4 - PORTA Bit 4
// D5 - PORTA Bit 5
// D6 - PORTA Bit 6
// D7 - PORTA Bit 7
// Characters/line: 16
lcd_init(16);
PORTC.0 = 1;
lcd_putsf("enter password");

while (1)
      {
      // Place your code here
        y = key();
        if(y == 10){i++;delay_ms(100);}
        up2:
        while(i%4==0)
        {
            lcd_clear();
            lcd_putsf("reset pass");
            delay_ms(1000);
            lcd_clear();
            lcd_gotoxy(0,0);
            up:
            lcd_putsf("enter old pass:");
            lcd_gotoxy(0,1);
            
            y1=key();if(y1==10){i=0;goto up2;}itoa(y1,aray);lcd_puts(aray);delay_ms(200);
            y2=key();if(y2==10){i=0;goto up2;}itoa(y2,aray);lcd_puts(aray);delay_ms(200);
            y3=key();if(y3==10){i=0;goto up2;}itoa(y3,aray);lcd_puts(aray);delay_ms(200);
            y4=key();if(y4==10){i=0;goto up2;}itoa(y4,aray);lcd_puts(aray);delay_ms(200);
            y5=y1*1000+y2*100+y3*10+y4;
            
            if(y5==my_password)
            {
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_putsf("pass correct");
                delay_ms(1000);
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_putsf("enter new pass :");
                lcd_gotoxy(0,1);
                
                y6=key();if(y6==10){i=0;goto up2;}itoa(y6,aray);lcd_puts(aray);delay_ms(200);
                y7=key();if(y7==10){i=0;goto up2;}itoa(y7,aray);lcd_puts(aray);delay_ms(200);
                y8=key();if(y8==10){i=0;goto up2;}itoa(y8,aray);lcd_puts(aray);delay_ms(200);
                y9=key();if(y9==10){i=0;goto up2;}itoa(y9,aray);lcd_puts(aray);delay_ms(200);
                y10=y6*1000+y7*100+y8*10+y9;
                my_password=y10;
                lcd_clear();
                lcd_gotoxy(0,0);lcd_putsf("new pass is : ");
                lcd_gotoxy(0,1);itoa(y10,aray);lcd_puts(aray);delay_ms(1000);
                lcd_clear();
                i=1;
            }
            else
            {
                lcd_gotoxy(0,0);
                lcd_putsf("pass incorrect");
                delay_ms(1000);
                lcd_gotoxy(0,1);
                lcd_putsf("please repeat");
                delay_ms(1000);
                lcd_clear();
                goto up;
            }
      }

        switch(y){
         case 11:   {lcd_gotoxy(0,1);lcd_putsf("Close !");PORTC.0 = 1;
             delay_ms(1000);lcd_clear();lcd_putsf("Enter Password:"); }
             break;
         case 0:
             lcd_putchar('0');  delay_ms(50);   amaliat(y);break;
         case 1:
             lcd_putchar('1');  delay_ms(50);   amaliat(y);break;             
         case 2:
             lcd_putchar('2');  delay_ms(50);   amaliat(y);break;
         case 3:
             lcd_putchar('3');  delay_ms(50);   amaliat(y);break;
         case 4:
             lcd_putchar('4');  delay_ms(50);   amaliat(y);break;
         case 5:
             lcd_putchar('5');  delay_ms(50);   amaliat(y);break;
         case 6:
             lcd_putchar('6');  delay_ms(50);   amaliat(y);break;
         case 7:
             lcd_putchar('7');  delay_ms(50);   amaliat(y);break;
         case 8:
             lcd_putchar('8');  delay_ms(50);   amaliat(y);break;
         case 9:
             lcd_putchar('9');  delay_ms(50);   amaliat(y);break;  
         default:
            break;          
     }
  }
}