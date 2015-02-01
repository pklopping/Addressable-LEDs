#define dataPin 2
#define clkPin 3

int r=0,b=0,g=0;
void setup() {
	pinMode (dataPin, OUTPUT) ; //data
	pinMode (clkPin, OUTPUT) ; //clock
}

void loop() {
	digitalWrite(dataPin, HIGH);
	int i = 0;
	int j = 0;
	for (;;)
	{
		for (j=0; j < 32; j++) { //32 LEDs
			digitalWrite(dataPin,LOW);
			for (i=0; i < 24; i++) { //24 bits/led
				digitalWrite (clkPin,HIGH) ;
				delayMicroseconds (10);
				digitalWrite (clkPin, LOW) ;
				delayMicroseconds (10);
				if (i >= 0 && i < 7) { //BLUE
					digitalWrite(dataPin,LOW);
				} else if (i >= 7 && i < 15) { //GREEN
					digitalWrite(dataPin,LOW);
				} else { //RED
					digitalWrite(dataPin,HIGH);
				}
			}
	 	 }
	}
	delay(1);
}

