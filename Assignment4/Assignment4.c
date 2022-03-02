#include <avr/io.h>
#include <util/delay.h>


int main (void)
{


  /* Arduino boards have a LED at PB5 */
 //set PB5, pin 13 of arduino as output
  DDRB    |= ((1 << DDB5));
  while (1) {
unsigned char  Z=0x01,Y=0x00,X=0x00;//inputs in hex

unsigned char one = 0x01;//used for displaying the output in bit
unsigned char A,B,O;//outputs

A=~(X&Y);
B=~(Y&Z);
O=~(A&B);
if(O==0) {
    PORTB = ((0 <<  PB5));}
else{PORTB = ((1 <<  PB5));}
    
    }

  /* . */
  return 0;

}

