#include<stdio.h>

int main()
{
  
unsigned char  Z=0x01,Y=0x01,X=0x00;//inputs in hex
  
unsigned char one = 0x01;//used for displaying the output in bit
unsigned char A,B,O;//outputs
  
A=~(X&Y);
B=~(Y&Z);
O=~(A&B);
  
printf("%x%x%x",one&Z,one&Y,one&X);//Input ZYX
printf(" ");
printf("%x\n" ,one&O);//Output O
printf("X.Y+Y.Z = %x",(one&X*one&Y)+(one&Y*one&Z));
 
/* Output

110 1
X.Y+Y.Z = 1

*/

return 0;

}
