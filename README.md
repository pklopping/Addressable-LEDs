#Addressable LEDs

Here is where I keep the code that I use to play with addressable LEDs.

So far I've played with the WS2801 chip and the WS2811. The WS2801 was simple enoguh for me to write my own code to interact with it. When I got a set of LEDs that used the WS2811 I decided to use a library that was written by someone else, specifically the FastLED library (http://fastled.io). 

As of this commit, master contains a folder called game_of_life. I built a 10x10 display and wrote a version of Conway's Game Of Life for it. 

# WS2801 Setup

LEDs: http://www.amazon.com/gp/product/B008F05N54/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1
Datasheet: http://www.noodlehed.com/ebay/datasheets/WS2801.pdf

# WS2811 Setup
* Requires https://github.com/FastLED/FastLED
LEDs: http://www.amazon.com/gp/product/B00MECZ06G/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1
Datasheet: https://www.adafruit.com/datasheets/WS2811.pdf