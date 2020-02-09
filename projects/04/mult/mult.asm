// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// This is a naive adder.
// The book states that R0 and R1 are *positive* and that R0*R1<32768

// Example program in JavaScript:
// let R0 = 6;
// let R1 = 7;
// let R2 = 0;
// let x = 0;
// for (var i = R1; i > 0; i--) {
//     x += R0;
// }
// R2 = x;

// Clear output
@R2
M=0

(LOOP)
    // Is R1 > 0 still?
    @R1
    D=M
    @END
    D;JLE
    
    // Add R0 to R2 again
    @R0
    D=M
    @R2
    M=D+M

    // Decrement R1
    @R1
    M=M-1

    // Loop back and evaluate again
    @LOOP
    0;JMP

(END)
    @END
    0;JMP
