// File: Div.asm
// Author: Ian Stephenson
// Date: 03/03/2020
// Section: 510
// E-mail: ims43@tamu.edu 
// Description: Implementation of the division operation in Hack Assembly

// Pseudocode:
// while quotient - divisor > 0
//		quotient = quotient - divisor
//		counter++
// 		if quotient == 0
//			return counter
//		else if quotient < 0
//			return counter - 1


// NOTES:
//	R0 = RAM[0] = dividend
//	R1 = RAM[1] = divisor
//	R2 = RAM[2] = quotient
//	jmp = goto command
//	jlt = conditional less than
//	jgt = conditional greater than
//	jeq = conditional equal to


// store value in RAM[0] into var dividend
@R0
D=M
@dividend
M=D			// dividend = R0

// store value in RAM[1] into var divisor
@R1
D=M
@divisor
M=D			// divisor = R1

// set value in RAM[2] to 0
@0
D=A
@R2
M=D	


(POSITIVE)
	@dividend
	D=M
	@divisor
	D=D-M		// subtract divisor from dividend
	
	@EQ0		// D equals 0, values are divisible
	D;JEQ
	
	@NEGATIVE	// D less than 0, one too many subtraction operations
	D;JLT
	
	@R2
	M=M+1		// increment counter, placed after eq0 and negative so that it doesnt increment counter one too many times
	
	@divisor
	D=M
	@dividend
	M=M-D		// reduce dividend by divisor so that you divide by updated divisor
	
	@POSITIVE	// not finished dividing, return to top of loop
	D;JGT

(EQ0)
	@R2
	M=M+1	// increment counter in RAM[2]
	@END
	0;JMP

(NEGATIVE)
	@END
	0;JMP
(END)
	@END
	0;JMP
	
