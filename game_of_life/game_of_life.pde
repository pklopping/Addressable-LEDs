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
	40 41 42 43 44 45 46 47 48 49
	50 51 52 53 54 55 56 57 58 59
	60 61 62 63 64 65 66 67 68 69
	70 71 72 73 74 75 76 77 78 79
	80 81 82 83 84 85 86 87 88 89
	90 91 92 93 94 95 96 97 98 99
	
	Which is accessed like 
	
	(0,0),(1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0)
	(0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(7,1),(9,1)
	(0,2),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2)
	(0,3),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3)
	(0,4),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4)
	(0,5),(1,5),(2,5),(3,5),(4,5),(5,5),(6,5),(7,5),(8,5),(9,5)
	(0,6),(1,6),(2,6),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(9,6)
	(0,7),(1,7),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(8,7),(9,7)
	(0,8),(1,8),(2,8),(3,8),(4,8),(5,8),(6,8),(7,8),(8,8),(9,8)
	(0,9),(1,9),(2,9),(3,9),(4,9),(5,9),(6,9),(7,9),(8,9),(9,9)

*/

#define ROWS 10
#define COLS 10

#include "FastLED.h"
#include "naughts.h" //initial states for the game

#define DATA_PIN 6
#define CHIPSET WS2811_400
#define BRIGHTNESS 64 //maybe eventually tie this into a pot?
#define NAUGHT 2 //use -1 for random

#define BLACK 0,0,0 //Dead and never used
#define GREEN 16,0,0 //Dead and used
#define BLUE 18,18,237 //ALIVE

bool DEBUG = false;

CRGB leds[ROWS*COLS];
uint8_t board[ROWS][COLS];
uint8_t board_alt[ROWS][COLS]; //scratch board

void setup() { 
	FastLED.addLeds<CHIPSET, DATA_PIN>(leds, ROWS*COLS);
	if (DEBUG) {
		Serial.begin(115200);
		Serial.println("Debugging Mode");
	}
	initializeBoard();
}

void loop() {
	showBoard();
	iterate();
	delay(100);
}

uint8_t convertCoords(uint8_t x, uint8_t y) {
	uint8_t pos = 0;
	if (y % 2 == 0) {
		pos = pos + (9-x);
		pos = pos + (9-y)*ROWS;
	} else {
		pos = pos + x;
		pos = pos + (9-y)*ROWS;
	}
	return pos;
}

void showBoard() {
	// if (DEBUG) {
	// 	Serial.println("Show Board");
	// }
	for (uint8_t y = 0; y < ROWS; y++) {
		for (uint8_t x = 0; x < COLS; x++) {
			CRGB newColor;
			switch(board[x][y]) {
				case 0: // Dead and never used
					newColor= CRGB(BLACK);
					break;
				case 1: // Dead and previously used
					newColor = CRGB(GREEN);
					break;
				case 2: // Alive
					newColor = CRGB(BLUE);
					break;
				default: //Adleiavde
					newColor = CRGB(255,0,0); // something is wrong...
					break;
			}
			// if (DEBUG) {
			// 	Serial.print(board[x][y]);
			// 	Serial.print(", ");
			// }
			leds[convertCoords(x,y)] = newColor;
		}
		// if (DEBUG) {
		// 	Serial.println(" - ");
		// }
	}
	// if (DEBUG) {
	// 	Serial.print("\n\n");
	// }
	FastLED.show(BRIGHTNESS);
}

void iterate() {
	for (uint8_t x=0; x<COLS; x++) {
		for (uint8_t y=0; y<ROWS; y++) {
			board_alt[x][y] = calcNextValue(x,y);
		}
	}
	copyAltToMain();
}

uint8_t calcNextValue(uint8_t x, uint8_t y) {

	uint8_t currVal = board[x][y];
	uint8_t retVal = 0;
	uint8_t numAlive = 0;

	//Count how many alive neighbors it has
	for (int8_t i = x-1; i <= x+1; i++) {
		for (int8_t j = y-1; j <= y+1; j++) {
			if (!(x == i && y == j)){
				if (getValueAtPosition(i,j) == 2)
					numAlive++;
			}
		}
	}
	switch (currVal) {
		case 0:
			if (numAlive == 3)
				retVal = 2;
			break;
		case 1:
			if (numAlive == 3)
				retVal = 2;
			else
				retVal = 1;
			break;
		case 2:
			if (numAlive > 1 && numAlive < 4)
				retVal = 2;
			else
				retVal = 1;
			break;
		default: 
			retVal = -1; //Something is wrong...
			break;
	}
	return retVal;
}

/*
	Gets a value at a position. 
	I want to build it to accept out of bounds values and wrap around 
	as if the game board used a toroidal coordinate system 
*/
uint8_t getValueAtPosition(int8_t x, int8_t y) {
	// Serial.print(x);
	// Serial.print(",");
	// Serial.println(y);

	if (x < 0) {
		Serial.println(x, COLS+x);
		x = COLS + x;
	} else if (x >= COLS) {
		x = x - COLS;
	}
	if (y < 0) {
		y = ROWS + y;
	} else if (y >= ROWS) {
		y = y - ROWS;
	}
	return board[x][y];
}

void copyAltToMain() {
	for (uint8_t x = 0; x < COLS; x++) {
		for (uint8_t y = 0; y < ROWS; y++) {
			board[x][y] = board_alt[x][y];
		}
	}
}

void initializeBoard() {
	for (uint8_t y=0; y<ROWS; y++) {
		for (uint8_t x=0; x<COLS; x++) {
			board[x][y] = naughts[NAUGHT][y][x];
		}
	}
}

