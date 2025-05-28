@ num_to_binary - Convert an integer number to binary

@ R2 - ASCII of text
                asciiNum    .req R2
@ R4 - counter
                counter     .req R4
@ R5 - letter in the text
                letter      .req R5
@ R6 - user's text to convert
                targetText  .req R6
@ R9 - quotient value for binary algorithm
                quotient    .req R9
@ R10 - binary string counter
                binCounter  .req R10

                .global num_to_binary
num_to_binary:
                STMFD  SP!, {LR}

                LDR R0, =textPrompt                 @ Load the prompt to printf
                BL printf                           @ Prompt the user to enter text

                LDR R1, =storage                    @ Location to write text from input
                LDR R0, =format                     @ Loading first parameter of scanf
                BL scanf                            @ Calling scanf

                LDR targetText, =storage            @ Get the user's text
                MOV counter, #0                     @ Initialize Counter

@ For each character in the input, check if its a digit
startLoop:      
                ADD letter, counter, targetText     @ Get letter address at targetText[counter]
                LDRB asciiNum, [letter]             @ Load the letter
                CMP asciiNum, #0                    @ Check if the string is over
                BEQ success                         @   If it is, get out of the loop

                MOV R0, asciiNum                    @ Get the ascii digit
                BL isdigit                          @ Call isdigit
                CMP R0, #0                          @   If isdigit returns 0, then, input isn't a number
                BEQ _error                          @   Go to error

                ADD counter, #1                     @ Increment counter
                b startLoop                         @ Loop back

@ Output the hexadecimal number if the error checking passed
success:    
                LDR R1, =storage                    @ Location of user's text input
                LDR R0, =string                     @ Format printf 
                BL printf                           @ 'text' Text to Binary is:

@   Get the decimal integer from the user
                LDR R0, =storage                    @ Get the user's input
                BL atoi                             @ Call atoi to convert from ascii to integer, stored in R0

@   Prepare registers to get binary numbers through divide
                MOV R1, #2                          @ Divisor
                MOV quotient, #5                    @ Store temporary quotient value of 5
                MOV R3, #0                          @ Store temporary number

@       Calculate the binary number
innerLoop:
                CMP quotient, #0                    @ Check if quotient is 0
                BEQ getBinary                       @   If it is, get out of the loop

                BL divide
                MOV quotient, R0                    @ Get the quotient value, R1 is still remainder
                
@           Add in all of the binary digits to make one whole binary number
                MOV R3, R1
                LDR R2, =binaryString
                LDR R1, =formatter4
                LDR R0, =binaryString
                BL sprintf                          @ sprintf(binaryString, "%s%d", binaryString, remainder)
                
                MOV R0, quotient                    @ Prepare the dividend by putting in the quotient
                MOV R1, #2                          
                MOV R3, #0
                B innerLoop                         @ Loop 
                
@       End inner loop
getBinary:     
@   Reverse the binary string to get the true binary number
                MOV binCounter, #0 		            @ Initialize the counter to 0
	            LDR R0, =binaryString               @ Load string to reverse
	            LDR R1, =reversedBinary             @ Load string to reverse to

@   Get the length of the binary string
getStringLength:
                LDRB R2, [R0]                       @ Load in first value of binaryString
                CMP R2, #0		                    @ Check if the string is empty
                BEQ startReverse	                @   Reached end of string
                ADD binCounter, #1                  @ Increment binCounter
                ADD R0, #1		                    @ Move to next character
                B getStringLength		            @ Loop again

@   Length of string acquired, start reverse process
startReverse:			                            
                SUB R0, #1                          @ Get the character before the null value
                MOV R9, binCounter                  @ The total characters is binCounter-1

@   Loop to reverse the characters from the string
reverseString:				                                
                LDRB R3, [R0]		                @ Load the last character
                STRB R3, [R1]		                @ Store the letter
                SUB R9, #1		                    @ Decrement down the string
                ADD R1, #1		                    @ Go to next char in reversedBinary
                SUB R0, #1		                    @ Move backwards from binaryString
                CMP R9, #0xffffffff	                @ Check if finished counting backwards
                BEQ print 		                    @   Branch to print if done counting
                B reverseString                     @ Loop back
    
@   Print the binary number
print:
                LDR R1, =reversedBinary
                LDR R0, =string2                 
                BL printf                           @ printf("%s", reversedBinary)
                B _exit

@ If the user didn't input a number, show error
_error:
                LDR R0, =errorMsg                   @ Load the error message into printf
                BL printf                           @ Print error message
                B _exit

@ Exit program
_exit:
                LDMFD SP!, {PC}

.data
textPrompt:     .asciz "Enter number: "
errorMsg:       .asciz "\nERROR: Must enter a positive number."
format:         .asciz " %[^\n]s"
string:         .asciz "'%s' Number to Binary is:\n"
string2:        .asciz "%s "
storage:        .space 80

formatter4:     .asciz "%s%d"

binaryString:   .space 1024
emptyString:    .space 1024
reversedBinary: .asciz ""
