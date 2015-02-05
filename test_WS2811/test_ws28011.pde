#include "FastLED.h"

#define DATA_PIN 6
#define NUM_LEDS 1
#define CHIPSET WS2811_400

CRGB leds[1];

void setup() { 
	FastLED.addLeds<CHIPSET, DATA_PIN>(leds, NUM_LEDS);
}
void loop() { 
	leds[0] = CRGB::White;
	FastLED.show();
	delay(30); 

	leds[0] = CRGB::Black;
	FastLED.show();
	delay(30);
}