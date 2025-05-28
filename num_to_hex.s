@ num_to_hex - Convert an integer number to hexadecimal

@ R2 - ASCII of text
                asciiNum    .req R2
@ R4 - counter
                counter     .req R4
@ R5 - letter in the text
                letter      .req R5
@ R6 - user's text to convert
                targetText  .req R6

                .global num_to_hex
num_to_hex:
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
                BL printf                           @ 'text' Text to Hexadecimal is:

@   Convert to hex and print
                LDR R0, =storage                    @ Get the user's input
                BL atoi                             @ Call atoi to convert from ascii to integer
                MOV R1, R0                          @   Got the integer
                LDR R0, =string2                    @ Load the hexadecimal Number in printf
                BL printf                           @ Print hex num
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
string:         .asciz "'%s' Number to Hexadecimal is:\n"
string2:        .asciz "%02X "
storage:        .space 80
