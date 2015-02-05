#include "FastLED.h"

#define DATA_PIN 6

CRGB leds[1];

void setup() { FastLED.addLeds<WS2811_400, DATA_PIN>(leds, 1); }
void loop() { 
	leds[0] = CRGB::White; FastLED.show(); delay(30); 
	leds[0] = CRGB::Black; FastLED.show(); delay(30);
}