.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH 
input_msg db 'Enter three lowercase letters: $'
output_msg db cr, lf, 'The second-highest letter is: $'
output_msg1 db cr, lf, 'All letters are equal$'
newline db 0xA
 
CHAR1 DB ?
CHAR2 DB ?
CHAR3 DB ?  

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    
    ;display input message
    MOV AH,9
    LEA DX,input_msg
    INT 21H
    
    ;take input three letters
    MOV AH, 1
    INT 21H
    MOV CHAR1, AL
    
    MOV AH, 1
    INT 21H
    MOV CHAR2, AL
    
    MOV AH, 1
    INT 21H
    MOV CHAR3, AL
     
    ;move the characters into three registers
    MOV AL,CHAR1
    MOV BL,CHAR2
    MOV CL,CHAR3
    
    CMP AL,BL
    JG  first_second_comparison
    je change_first_third
    CMP BL,CL
    JE output_result
    XCHG AL,BL 
    
    
    first_second_comparison:
    CMP AL,CL
    JL  output_result
    je first_third_comparison
    XCHG AL,CL
    
    second_third_comparison:
    CMP AL,BL
    JG  output_result 
    je output_result
    XCHG AL,BL
    CMP AL, BL
    JG output_result
    JMP all_letters_equal 
    
    first_third_comparison:
    cmp al, cl
    je change_first_second
    
    change_first_second:
    XCHG AL, BL
    JMP output_result
    
    change_first_third:
    CMP AL, CL
    JG change_first_third2 
    je all_letters_equal
    CMP al, bl
    je output_result
    XCHG AL, CL
    JMP output_result
    
    change_first_third2:
    XCHG AL, CL
    JMP output_result
    
    
    output_result:
    ;display the output message
    MOV BL,AL 
    LEA DX, output_msg
    MOV AH, 9
    INT 21H  
    
    ;display the output   
    MOV AH, 2
    MOV DL, BL
    INT 21H    
    JMP EXIT

     ;display the message when all letters are equal
    all_letters_equal:
    MOV AH,9
    LEA DX,output_msg1
    INT 21H
    
        
    EXIT:
    MOV AH,4CH
    INT 21H    
    MAIN ENDP 0
END MAIN




