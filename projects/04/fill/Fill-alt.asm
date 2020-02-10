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

// @KBD pointer is predefined as the currently pressed key.
// @SCREEN pointer is predefined as first pixel (256x512 pixel screen).
// @KBD is adjacent to the very end of @SCREEN's range.

// Initialize @pixel as the first register of @SCREEN
(RESET)
    @SCREEN
    D=A
    @pixel
    M=D

(LOOP)
    @KBD
    D=M     // read keyboard for any key actively down

    @YES_KEY
    D;JGT   // if any key
    @NO_KEY
    0;JMP   // else

    (YES_KEY)
        @THIS
        M=-1
        @DO_FILL
        0;JMP

    (NO_KEY)
        @THIS
        M=0
        @DO_FILL
        0;JMP

    (DO_FILL)
        // Load current value of @THIS into the @pixel pointer
        @THIS
        D=M
        @pixel
        A=M
        M=D

        // Increment @pixel's pointer to the next address
        @pixel
        M=M+1

        // If we hit the @KBD pointer's range, start back at @SCREEN
        @KBD
        D=A
        @pixel
        D=D-M
        @RESET
        D;JLE
        @LOOP
        0;JMP // else, loop again