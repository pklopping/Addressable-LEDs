#include "FastLED.h"

#define DATA_PIN 6
#define NUM_LEDS 100
#define CHIPSET WS2811_400

CRGB leds[NUM_LEDS];

int fade = 0;
bool inc = true;

void setup() { 
	FastLED.addLeds<CHIPSET, DATA_PIN>(leds, NUM_LEDS);
}
void loop() {
	for (int i = 0; i < NUM_LEDS; i++) {
		if (i == fade) {
			leds[i] = CRGB(255,0,0);
		} else {
			leds[i] = CRGB::Black;
		}
		// leds[i].red = fade;
		// leds[i].green = 0;
		// leds[i].blue = 0;
		// leds[i] = CRGB(fade,fade,fade);
	}
	FastLED.show();
	(inc) ? fade++ : fade--;
	if (fade == 0)
		inc = true;
	if (fade == NUM_LEDS)
		inc = false;
	delay(1);
}