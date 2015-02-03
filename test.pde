#define dataPin 2
#define clkPin 3

int i = 0;

void setup() {
	pinMode (dataPin, OUTPUT) ; //data
	pinMode (clkPin, OUTPUT) ; //clock
}

void loop() {
	for (int j=0; j < 32; j++) { //32 LEDs
		if (j == i) {
			sendPixel(255,0,0);
		} else {
			sendPixel(0,0,0);
		}
	}
	delay(1);
	i++;
	if (i > 32)
		i = 0;
}

/*
	Sets the color of an individual pixel
*/
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
	Sends an individual bit
*/
void sendBit(bool value) {
	digitalWrite(dataPin, value);
	digitalWrite(clkPin,HIGH);
	delayMicroseconds(1);
	digitalWrite(clkPin,LOW);
}
