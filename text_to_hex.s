@ text_to_hex - Change a text input to hexadecimal numbers and output it.

@ R2 - hex num of text
                hexNum    .req R2
@ R4 - counter
                counter     .req R4
@ R5 - letter in the text
                letter      .req R5
@ R6 - user's text to convert
                targetText  .req R6

                .global text_to_hex
text_to_hex:
                STMFD  SP!, {LR}

                LDR R0, =textPrompt                 @ Load the prompt to printf
                BL printf                           @ Prompt the user to enter text

                LDR R1, =storage                    @ Location to write text from input
                LDR R0, =format                     @ Loading first parameter of scanf
                BL scanf                            @ Calling scanf

                LDR R1, =storage                    @ Location of user's text input
                LDR R0, =string                     @ Format printf 
                BL printf                           @ 'text' Text to Hexadecimal is:

                LDR targetText, =storage            @ Get the user's text
                MOV counter, #0                     @ Initialize Counter

@ Get each hex character and print it
startLoop:      
                ADD letter, counter, targetText     @ Get letter address at targetText[counter]
                LDRB hexNum, [letter]               @ Load the letter
                CMP hexNum, #0                      @ Check if the string is over
                BEQ _exit                           @   If it is, get out of the loop

                MOV R1, hexNum                      @ Get the hex number ready to print
                LDR R0, =string2                    @ Format printf
                BL printf                           @ Print the hex number

                ADD counter, #1                     @ Increment counter
                b startLoop                         @ Loop back

@ Exit program
_exit:
                LDMFD SP!, {PC}

.data
textPrompt:     .asciz "Enter text: "
format:         .asciz " %[^\n]s"
string:         .asciz "'%s' Text to Hexadecimal is:\n"
string2:        .asciz "%02X "
storage:        .space 80
