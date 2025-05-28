@ converter - main converter program that takes user input and converts it to various formats

@ R4 - menu choice from the user
                    menuChoice      .req R4

                    .global main
main:
@ Display first and last name using printf
                    LDR R0, =name
                    BL printf

@ Prompt the menu until the user quits
_while:
                    LDR R0, =menu
                    BL printf

@   Read input from keyboard
                    MOV R0, #0
                    LDR R1, =choice
                    MOV R2, #41
                    MOV R7, #3
                    SWI 0                       @ SWI call
                    LDR R3, =choice             @ Load =choice into R3

@   If the menu choice is '1', go to 1st case
                    LDRB menuChoice, [R3]       @ Check the byte of user's choice
                    CMP menuChoice, #49         @ Check if it's ASCII '1'
                    BEQ _case1                  @   Go to the 1st case for text_to_ascii()

@   If the menu choice is '2', go to the 2nd case
                    LDRB menuChoice, [R3]       @ Check the byte of user's choice
                    CMP menuChoice, #50         @ Check if it's ASCII '2'
                    BEQ _case2                  @   Go to the 2nd case for text_to_binary()

@   If the menu choice is '3', go to the 3rd case
                    LDRB menuChoice, [R3]       @ Check the byte of user's choice
                    CMP menuChoice, #51         @ Check if it's ASCII '3'
                    BEQ _case3                  @   Go to the 3nd case for text_to_binary()

@   If the menu choice is '4', go to the 4th case
                    LDRB menuChoice, [R3]       @ Check the byte of user's choice
                    CMP menuChoice, #52         @ Check if it's ASCII '4'
                    BEQ _case4                  @ Go to the 4th case for num_to_ascii()

@   If the menu choice is '5', go to the 5th case
                    LDRB menuChoice, [R3]       @ Check the byte of user's choice
                    CMP menuChoice, #53         @ Check if it's ASCII '5'
                    BEQ _case5                  @ Go to the 5th case for num_to_binary()

@   If the menu choice is '6', go to the 6th case
                    LDRB menuChoice, [R3]       @ Check the byte of user's choice
                    CMP menuChoice, #54         @ Check if it's ASCII '6'
                    BEQ _case6                  @ Go to the 6th case for num_to_hex()

@   If the menu choice is 'Q', go to the Quit case
                    LDRB menuChoice, [R3]       @ Check the byte of user's choice
                    CMP menuChoice, #81         @ Check if it's ASCII 'Q'
                    BEQ _exit                   @ Go to the quit case

@   If the menu choice is invalid, go to the default error case
                    B _caseError                @ Go to the error case

// ===============================

@ Case 1
_case1: 
                    BL text_to_ascii            @ Branch to text_to_ascii()
                    B _while                    @ After execution, go back to menu

@ Case 2
_case2: 
                    BL text_to_binary           @ Branch to text_to_binary()
                    B _while                    @ After execution, go back to menu

@ Case 3
_case3:
                    BL text_to_hex              @ Branch to text_to_hex()
                    B _while                    @ After execution, go back to menu

@ Case 4
_case4: 
                    BL num_to_ascii             @ Branch to num_to_ascii()
                    B _while                    @ After execution, go back to menu

@ Case 5
_case5: 
                    BL num_to_binary            @ Branch to num_to_binary()
                    B _while                    @ After execution, go back to menu

@ Case 6
_case6: 
                    BL num_to_hex               @ Branch to num_to_hex()
                    B _while                    @ After execution, go back to menu

@ Case Error
_caseError: 
                    LDR R0, =caseErrorMsg       @ Print out the error message      
                    BL printf
                    B _while                    @ Go back to the menu

@ Exit out of program
_exit: 
    MOV R7, #1
    SWI 0

// ==============================================================

.data
name:               .asciz "Converter"
menu:               .asciz "\n\n===========Menu===========\n[1] Text to ASCII\n[2] Text to Binary\n[3] Text to Hexadecimal\n[4] Number to ASCII\n[5] Number to Binary\n[6] Number to Hexadecimal\n[Q] Quit\nChoose an option:\n"
choice:             .space 41
caseErrorMsg:       .asciz "\nERROR: Option not found.\n"
textPrompt:         .asciz "Enter text: "
numberPrompt:       .asciz "Enter a number: "
format:             .asciz " %[^\n]s"
