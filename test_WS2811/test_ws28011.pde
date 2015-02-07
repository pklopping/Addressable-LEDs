/*
	My grid is a string of LEDs that look like this

	99 98 97 96 95 94 93 92 91 90
	80 81 82 83 84 85 86 87 88 89
	79 78 77 76 75 74 73 72 71 70
	60 61 62 63 64 65 66 67 68 69
	59 58 57 56 55 54 53 52 51 50
	40 41 42 43 44 45 46 47 48 49
	39 38 37 36 35 34 33 32 31 30
	20 21 22 23 24 25 26 27 28 29
	19 18 17 16 15 14 13 12 11 10
	00 01 02 03 04 05 06 07 08 09

	And I map it to look more like this

	00 01 02 03 04 05 06 07 08 09
	10 11 12 13 14 15 16 17 17 19
	20 21 22 23 24 25 26 27 28 29
	30 31 32 33 34 35 36 37 38 39
	etc.
*/

#include "FastLED.h"

#define DATA_PIN 6
#define NUM_LEDS 100
#define ROWS 10
#define COLS 10
#define CHIPSET WS2811_400
#define BRIGHTNESS 32

struct position {
	int x;
	int y;
};

CRGB leds[NUM_LEDS];

int fade = 0;
bool inc = true;

void setup() { 
	FastLED.addLeds<CHIPSET, DATA_PIN>(leds, NUM_LEDS);
	Serial.begin(9600);
}

void loop() {
	FastLED.clear();
	setRow(fade, CRGB::White);
	FastLED.show(BRIGHTNESS);
	(inc) ? fade++ : fade--;
	if (fade == 0)
		inc = true;
	if (fade == 9)
		inc = false;
	Serial.println(fade);
	delay(50);
}

void setRow(int start, CRGB color) {
	for (int i = 0; i < ROWS; i++) {
		leds[COLS*start+i] = color;
	}
}

void setCol(int start, CRGB color) {
	for (int i = 0; i < 10; i++) {

	}
}

position 

