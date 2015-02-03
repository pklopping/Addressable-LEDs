#define dataPin 2
#define clkPin 3

int i = 0; //keeps track of where the enabled light currently is
bool inc = true; //Is the light moving up the strip or down?

void setup() {
	pinMode (dataPin, OUTPUT) ; //data
	pinMode (clkPin, OUTPUT) ; //clock
}

void loop() {
	for (int j=0; j < 32; j++) { //32 LEDs
		if (abs(i-j) < 4) {
			sendPixel(255,0,0);
		} else {
			sendPixel(0,0,0);
		}
	}
	delay(1); //A delay of more than 600us will latch the data to the ICs

	//Increment or decrement i, makint the light that is turned on move up or down the strip by 1 position
	(inc) ? i++ : i--;
	if (i == 32)
		inc = false;
	if (i == 0)
		inc = true;
}

void sendPixel(int r, int g, int b) {
	sendNumber(b);
	sendNumber(g);
	sendNumber(r);
}

/*
	Sends the values for one color of an LED
*/
void sendNumber(int number) {
	for (int i = 0; i < 8; i++) {
		bool value = bitRead(number,8-i) == 1 ? HIGH : LOW;
		sendBit(value);
	}
}

/*
	sendBit(value)
	Send an individual bit to the strip
	first, set the output value, then toggle the clock wire up (to latch it), and then back down
*/
void sendBit(bool value) {
	digitalWrite(dataPin, value);
	digitalWrite(clkPin,HIGH); //Latch the data
	delayMicroseconds(1); 
	digitalWrite(clkPin,LOW); //Reset the clock to LOW
	delayMicroseconds(1);
}
