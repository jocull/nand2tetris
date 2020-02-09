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

(LOOP)
    @KBD
    D=M     // read keyboard

    @YES_KEY
    D;JGT   // if any key
    @NO_KEY
    0;JMP   // else

    (YES_KEY)
        @THIS
        M=-1
        @COMPARE_LAST
        0;JMP

    (NO_KEY)
        @THIS
        M=0
        @COMPARE_LAST
        0;JMP

    (COMPARE_LAST)
        @THIS
        D=M
        @THAT
        D=M-D
        @LOOP
        D;JEQ // If zero, no work to do. Loop back.

    // Use @THIS as the current state of the screen
    // Save @THIS to @THAT to track previous state
    @THIS
    D=M
    @THAT
    M=D

    // The Hack screen's pixel bits start at @SCREEN.
    // There are 8192 memory addresses to work through,
    // as in 256*512 bits with 16 bits per register.
    @8191
    D=A   // Load number (8191; zero based 8192) into A register and save to D register
    @i
    M=D   // Walk backwards through @SCREEN registers using @i
    D=M   // Get the register width for @SCREEN back
    @SCREEN
    D=D+A // Calculate pointer to end of @SCREEN's range
    @p
    M=D   // Save the pointer into @p

    (ITER)
        @THIS
        D=M
        @p
        A=M   // Use @p's value as A (so we may use it as a memory location)
        M=D   // Put @THIS into @p's memory location (fill or clear)

        @p
        M=M-1  // Decrement @p's pointer
        @i
        MD=M-1 // Decrement @i's counter

        @ITER
        D;JGE  // Do it again?
        @LOOP
        0;JMP  // Nah, back to loop
