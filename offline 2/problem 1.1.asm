.MODEL SMALL
.STACK 100H
.DATA 
N DB 4
K DB 3
TOTAL DB 0
WRAPPER DB 0
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV CL, N
    MOV BL, K
    MOV CH, WRAPPER
    MOV BH, TOTAL
    
    WHILE:
    CMP CL, 0
    JG EAT_CHOCOLATE
    CMP CH, BL
    JGE EAT_CHOCOLATE
    JMP END_WHILE
    
    
    EAT_CHOCOLATE:
    DEC CL ;EAT A CHOCOLATE
    INC BH ;EAT A CHOCOLATE
    INC CH ;COLLECT WRAPPER
    
    CMP CH, BL
    JGE EXCHANGE_WRAPPER
    jmp WHILE
    
    EXCHANGE_WRAPPER:
    ; NEW CHOCOLATES = WRAPPERS / K
    MOV AL, CH
    MOV BL, BL
    DIV BL
   ; MOV CH, AL ;STORE NEW CHOCOLATES
    
    ADD BH, AL  ; TOTAL += NEW CHOCOLATES
    ADD CH, AL   ; WRAPPER += NEW CHOCOLATE
    
    MOV AL, AL
    MUL BL
    SUB CH, AL
    
    CMP CL, 0
    JG WHILE
    CMP CH, BL
    JGE WHILE
    JMP END_WHILE
    
    END_WHILE:
    MOV AH,2
    MOV DL,BH
    INT 21H
    JMP EXIT
    
    EXIT:
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
     
    
    
    
     
    
    
    
    
    



