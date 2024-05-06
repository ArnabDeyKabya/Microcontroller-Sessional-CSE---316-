.MODEL SMALL
.STACK 100H
.DATA 
CR EQU 0DH
LF EQU 0AH
input_msg db 'Enter a single character: $'
output_msg db 'Character classification: $' 
uppercase_msg db CR,LF, 'Uppercase letter$'
lowercase_msg db CR,LF, 'Lowercase letter$'
number_msg db CR,LF, 'Number$'
other_msg db CR,LF, 'Not an alphanumeric value$'
newline db 0xA
char db ?

.CODE
MAIN PROC
    ;INITIALIZE DS
    MOV AX, @DATA
    MOV DS, AX
    
    ;DISPLAY MESSAGE
    LEA DX, input_msg
    MOV AH, 9
    INT 21H  
    
    ;INPUT A CHARACTER
    MOV AH, 1
    INT 21H
    MOV char, AL 
    
     
    check_lowercase:
    ; Check for lowercase letter
    cmp al, 'a'
    jl check_uppercase
    cmp al, 'z'
    jle display_lowercase
    jmp display_other 
    
    check_uppercase:
    ; Check for uppercase letter
    cmp al, 'A'
    jl check_number
    cmp al, 'Z'
    jle display_uppercase
    jmp check_number
   
    
    check_number:
    ; Check for number
    cmp al, '0'
    jl display_other
    cmp al, '9'
    jle display_number
    jmp display_other
    
    display_uppercase:
    
    ; Display uppercase letter message
    mov ah, 09h
    lea dx, uppercase_msg
    int 21h
    jmp exit_program
    
    display_lowercase:
    ; Display lowercase letter message
    mov ah, 09h
    lea dx, lowercase_msg
    int 21h
    jmp exit_program
    
    display_number:
    ; Display number message
    mov ah, 09h
    lea dx, number_msg
    int 21h
    jmp exit_program
    
    display_other:
    ; Display other message
    mov ah, 09h
    lea dx, other_msg
    int 21h
    
   exit_program:
    ; Terminate program
    mov ah, 4Ch
    int 21h
    
MAIN ENDP
    END MAIN