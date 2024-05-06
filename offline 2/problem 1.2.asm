.MODEL SMALL
.STACK 100H
.DATA
LF EQU 0AH
CR EQU 0DH 
input_msg db 'Enter the value of n and k: $'
input_invalid db 0DH, 0AH, 'Invalid Input $'
result DW 0
count DW 0
number_1 DW 0
number_2 DW 0

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ;Display input message
    MOV AH,9
    LEA DX,input_msg
    INT 21H
    
    XOR BX, BX
    XOR CX, CX
    
    ;Input the first digit of the n
    MOV AH, 1
    INT 21H 
    CMP AL, '0'
    JL INVALID_INPUT
    CMP AL, '9'
    JG INVALID_INPUT
    SUB AL, 48
    XOR AH, AH
    MOV BX, AX
    
    INPUT_LEVEL_1:
        MOV AH, 1
        INT 21H;
        CMP AL,32
        JE INPUT_LEVEL_2
        CMP AL, '0'
        JL INVALID_INPUT
        CMP AL, '9'
        JG INVALID_INPUT
        SUB AL, '0'
        XOR AH, AH
        MOV number_1, AX
        MOV AX, BX
        MOV CX, 10
        MUL CX
        MOV BX, AX
        ADD BX, number_1
        jmp INPUT_LEVEL_1
        
    INPUT_LEVEL_2:
        ;Input the first digit of k
        MOV AH,1
        INT 21H
        CMP AL, '0'
        JL INVALID_INPUT
        CMP AL, '9'
        JG INVALID_INPUT    
        SUB AL,'0'
        XOR AH,AH
        MOV number_2,AX
        
    INPUT_LOOP:
        MOV AH, 1
        INT 21H
        CMP AL, CR
        JE RESULT_GENERATE
        CMP AL, '0'
        JL INVALID_INPUT
        CMP AL, '9'
        JG INVALID_INPUT
        SUB AL, '0'
        XOR AH, AH
        MOV number_1, AX
        MOV AX, number_2
        MOV CX, 10
        MUL CX
        MOV number_2, AX
        MOV AX, number_1
        ADD AX, number_2
        MOV number_2, AX
        JMP INPUT_LOOP
        
        
    RESULT_GENERATE:
        MOV CX, number_2
        ADD result, BX,
        MOV AX, BX
        DIV number_2
        ADD result, AX
        ADD AX, DX
        
    RESULT_GENERATE_2:
        CMP AX, NUMBER_2
        JB DISPLAY
        XOR DX, DX
        DIV number_2
        ADD result, AX
        ADD AX, DX
        JMP RESULT_GENERATE_2
        
        
    DISPLAY:
        MOV AX, result
        
    LEVEL_1:
        CMP AX,0
        JE LEVEL_2
        MOV CX,10
        XOR DX, DX
        DIV CX
        ADD DX, 48
        PUSH DX
        MOV BX, COUNT
        INC BX
        MOV COUNT, BX
        JMP LEVEL_1
        
    LEVEL_2:
        MOV AH,2
        MOV DL,CR
        INT 21H  
        MOV AH,2
        MOV DL,LF
        INT 21H 
        
    LEVEL_3:
        CMP count,0
        JE EXIT
        POP DX
        MOV BX, COUNT
        DEC BX
        MOV COUNT, BX
        MOV AH,2
        INT 21H
        JMP LEVEL_3     
            
        
    INVALID_INPUT:
        MOV AH,9
        LEA DX,input_invalid
        INT 21H
        
    EXIT:
         MOV AH, 4CH
         INT 21H  
         MAIN ENDP 
END MAIN
          
            
        
        
        
        





