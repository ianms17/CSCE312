// File: LCD.asm
// Author: Ian Stephenson
// Date: 03/03/2020
// Section: 510
// E-mail: ims43@tamu.edu 
// Description: Implementation of the Greatest Common Denominator function in Hack Assembly

// Pseudocode:
// 		If a = 0, GCD(a, b) = b
//		Else if b = 0, GCD(a, b) = a
// 		Else calculate remainder
// 			 set a = b
//			 set b = remainder
//			 calculate GCD(b, remainder) as GCD(a, b), where a = b and b = remainder


// store value in R0 into a copy of A
@R0
D=M
@copyA
M=D

// store value in R1 into a copy of B
@R1
D=M
@copyB
M=D


// initialize remainder counter to zero, store in remainder variable
@0
D=A
@R3
M=D
@R3
D=M
@remainder
M=D

// Special cases where initial A, B equals 0
@copyA
D=M
@AEQ0		// if R0 contains 0, go to special case AEQ0
D;JEQ


@copyB
D=M
@BEQ0		// if R1 contains 0, go to special case BEQ0
D;JEQ

(CALCULATEREMAINDER)
	(POSITIVE)
		@copyA
		D=M
		@copyB
		D=D-M		// subtract divisor from dividend
		
		@EQ0		// D equals 0, values are divisible
		D;JEQ
		
		@NEGATIVE	// D less than 0, one too many subtraction operations
		D;JLT
		
		@remainder
		M=M+1		// increment counter, placed after eq0 and negative so that it doesnt increment counter one too many times
		
		@copyB
		D=M
		@copyA
		M=M-D		// reduce dividend by divisor so that you divide by updated divisor
		
		@POSITIVE	// not finished dividing, return to top of loop
		D;JGT

	(EQ0)
		@remainder
		M=0			// integers are divisible, remainder = 0
		@COPYVALUES
		0;JMP

	(NEGATIVE)
		@copyA
		D=M
		@remainder
		M=D 		// integers arent divisible, remainder = 0 - dividend because dividend is negative and 0 - (-1) = 1
		@COPYVALUES
		0;JMP
		
(COPYVALUES)
	@copyB
	D=M
	@copyA			// store updated B into A
	M=D
	
	@remainder
	D=M
	@copyB
	M=D				// store remainder in B
	
	@copyA
	D=M
	@AEQ0
	D;JEQ			// if A is 0, goto AEQ0
	
	@copyB
	D=M
	@BEQ0
	D;JEQ			// if B is 0, goto BEQ0
	
	@CALCULATEREMAINDER		// else return to calculate remainder
	0;JMP

	
(AEQ0)
	@copyB
	D=M
	@R2			// store B in R2 if A = 0
	M=D
	
	@END
	0;JMP
	

(BEQ0)
	@copyA
	D=M
	@R2			// store A in R2 if B = 0
	M=D
	
	@END
	0;JMP
	
	
(END)
	@END
	0;JMP



