#define dataPin 2
#define clkPin 3

int i = 0;
bool inc = true;
void setup() {
	pinMode (dataPin, OUTPUT) ; //data
	pinMode (clkPin, OUTPUT) ; //clock
}

void loop() {
	for (int j=0; j < 32; j++) { //32 LEDs
		if (i == j) {
			sendNumber(255); //Blue
			sendNumber(0); //Green
			sendNumber(0); //Red
		} else {
			sendNumber(0);
			sendNumber(0);
			sendNumber(0);
		}
	}
	delay(1);
	(inc) ? i++ : i--;
	if (i == 32)
		inc = false;
	if (i == 0)
		inc = true;
}

void sendNumber(int number) {
	for (int i = 0; i < 8; i++) {
		bool value = bitRead(number,i) == 1 ? HIGH : LOW;
		sendBit(value);
	}
}

void sendBit(bool value) {
	digitalWrite(dataPin, value);
	digitalWrite(clkPin,HIGH);
	delayMicroseconds(1);
	digitalWrite(clkPin,LOW);
}
