// File: Fill.asm
// Author: Ian Stephenson
// Date: 03/03/2020
// Section: 510
// E-mail: ims43@tamu.edu 
// Description: Implementation of the Fill.asm in Hack Assembly

// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(LOOP)
	@SCREEN
	D=A
	@currPix	// set pixel counter to screen start
	M=D
	
	@KBD
	D=M			// take in values from keyboard
	
	@SETWHITE
	D;JEQ		// input value is zero, set screen to white
	
	@SETBLACK
	0;JEQ		// else jump to setblack if keyboard isnt zero

(SETSCREEN)
	@currPix
	D=M
	@KBD
	D=D-A
	@LOOP
	D;JEQ		// filled whole screen, return to loop to get check keyboard input
				// only returns to loop after every pixel is filled, then it can check for new input
	@set
	D=M
	@currPix
	A=M
	M=D
	@currPix
	M=M+1		// store the current pixel value and increment it
	
	@SETSCREEN
	0;JMP		// return to setscreen until all the pixels are filled
	
(SETBLACK)
	@set
	M=-1
	@SETSCREEN
	0;JMP		// set pixel value to one for black and return to set the screen color

(SETWHITE)
	@set
	M=0
	@SETSCREEN
	0;JMP		// set pixel value to zero for white, return to set screen color
