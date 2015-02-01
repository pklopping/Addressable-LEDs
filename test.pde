#define dataPin 2
#define clkPin 3

int r=0,b=0,g=0;
void setup() {
	pinMode (dataPin, OUTPUT) ; //data
	pinMode (clkPin, OUTPUT) ; //clock
	Serial.begin(9600);
	test();
}

void test() {
	Serial.println("Test");
	for (int i = 0; i < 8; i++) {
		Serial.println(bitRead(120,i));
	}
	Serial.println("End Test");
}

void loop() {
	digitalWrite(dataPin, HIGH);
	int i = 0;
	int j = 0;
	for (;;)
	{
		for (j=0; j < 32; j++) { //32 LEDs
			// digitalWrite(dataPin,LOW);
			sendNumber(255);
			// digitalWrite(dataPin,LOW);
			sendNumber(0);
			// digitalWrite(dataPin,HIGH);
			sendNumber(255);
	 	 }
	}
	delay(1);
}

void sendNumber(int number) {
	for (int i = 0; i < 8; i++) {
		bool value = bitRead(number,i) == 1 ? HIGH : LOW;
		sendBit(value);
	}
}

void sendBit(bool value) {
	digitalWrite(dataPin, value);
	delayMicroseconds(20);
	digitalWrite(clkPin,HIGH);
	delayMicroseconds(20);
	digitalWrite(clkPin,LOW);
	delayMicroseconds(20);
}
