.MODEL SMALL
.MODEL SMALL
.STACK 100H
.DATA
INPUT_MSG DB 'Enter the value of n :$' 
input_invalid db 0DH, 0AH, 'Invalid Input $'
number_1 DW 0
sum DW 0
count DW 0

.code
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9
    LEA DX, INPUT_MSG
    INT 21H
    
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
        CMP AL, 0DH
        JE  START
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
 START:       
        
    MOV AX, BX
    CALL FUNCTION
    
    SUM_CALCULATION:
    XOR DX, DX
    MOV CX, 10
    DIV CX
    ADD DX, 48
    PUSH DX
    INC count
    CMP AX, 0
    JE BEFORE_DISPLAY
    JMP SUM_CALCULATION
    
    BEFORE_DISPLAY:
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    DISPLAY:
    POP DX
    MOV AH,02H
    INT 21H 
    DEC count
    MOV BX, count
    CMP BX, 0
    JE EXIT
    JMP DISPLAY   
    
    INVALID_INPUT:
    MOV AH,9
    LEA DX, INPUT_MSG
    INT 21H
    JMP EXIT
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP 
    
    
    FUNCTION PROC
        CMP AX, 0
        JE RETURN
        XOR DX, DX
        MOV CX, 10
        DIV CX
        PUSH DX
        CALL FUNCTION
        POP DX
        ADD AX, DX
        RETURN: RET
        FUNCTION ENDP
        
        
     
END MAIN
        
    
   
 
    



