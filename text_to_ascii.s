@ text_to_ascii - Change a text input to ascii numbers and output it.

@ R2 - ASCII num of text
                asciiNum    .req R2
@ R4 - counter
                counter     .req R4
@ R5 - letter in the text
                letter      .req R5
@ R6 - user's text to convert
                targetText  .req R6

                .global text_to_ascii
text_to_ascii:
                STMFD  SP!, {LR}

                LDR R0, =textPrompt                 @ Load the prompt to printf
                BL printf                           @ Prompt the user to enter text

                LDR R1, =storage                    @ Location to write text from input
                LDR R0, =format                     @ Loading first parameter of scanf
                BL scanf                            @ Calling scanf

                LDR R1, =storage                    @ Location of user's text input
                LDR R0, =string                     @ Format printf 
                BL printf                           @ 'text' Text to ASCII is:

                LDR targetText, =storage            @ Get the user's text
                MOV counter, #0                     @ Initialize counter

@ Get each ASCII character and print it
startLoop:      
                ADD letter, counter, targetText     @ Get letter address at targetText[counter]
                LDRB asciiNum, [letter]             @ Load the letter
                CMP asciiNum, #0                    @ Check if the string is over
                BEQ _exit                           @   If it is, get out of the loop

                MOV R1, asciiNum                    @ Get the ASCII number ready to print
                LDR R0, =string2                    @ Format printf
                BL printf                           @ Print the ASCII number

                ADD counter, #1                     @ Increment counter
                b startLoop                         @ Loop back

@ Exit program
_exit:  
                //=============
                //LDR R0, =timePrompt                 @ Load the time output text
                //BL printf                           @ Print amount of time it took to convert

                LDMFD SP!, {PC}

.data
textPrompt:     .asciz "Enter text: "
timePrompt:     .asciz "\n\nConversion took %f seconds\n"
format:         .asciz " %[^\n]s"
string:         .asciz "'%s' Text to ASCII is:\n"
string2:        .asciz "%d "
storage:        .space 80
