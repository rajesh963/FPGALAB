#include <Arduino.h>

#define X 2
#define Y 3
#define Z 4
#define O 13


int x,y,z, temp,temp1, output;

void setup() {
	
	pinMode(O, OUTPUT);
	pinMode(X, INPUT);
	pinMode(Y, INPUT);
	pinMode(Z,INPUT);
}

void loop() {
    x = digitalRead(X);
    y = digitalRead(Y);
    z = digitalRead(Z);

    
    temp=!(x&&y);

    temp1=!(y&&z);

    output = !(temp&&temp1);


    if(output == 1)
	    digitalWrite(O, HIGH);
    else
	    digitalWrite(O, LOW);
}
