.MODEL SMALL
 
.STACK 100H


 
.DATA
LF EQU 0AH
CR EQU 0DH
NUM DW 0
NUM1 DW 0
ANS DW 0
CNT DW 0
          
.CODE
MAIN PROC
    MOV AX, @DATA 
    MOV DS, AX 
    
    MOV BX,0
    MOV CX,0
    MOV AH,1
    
    INT 21H
    SUB AL,'0'
    MOV AH,0
    MOV BX,AX
    
LEVEL1:
    MOV AH,1
    INT 21H
    CMP AL,' '
    JE LEVEL2
    SUB AL,48
    MOV AH,0
    MOV NUM,AX
    MOV AX,BX
    MOV CX,10
    MUL CX
    MOV BX,AX
    ADD BX,NUM    
    JMP LEVEL1
    
      
    
LEVEL2:
    MOV AH,1
    
    INT 21H
    SUB AL,'0'
    MOV AH,0
    MOV NUM1,AX


LEVEL3:
    MOV AH,1
    INT 21H
    CMP AL,CR
    JE LEVEL9
    SUB AL,48
    MOV AH,0
    MOV NUM,AX
    MOV AX,NUM1
    MOV CX,10
    MUL CX
    MOV NUM1,AX
    ADD BX,NUM    
    JMP LEVEL3
    
    
    
    
    
    
    
    ;UPTO HERE OKKKKKKKKKKKKKKKKKKK
LEVEL9:
    MOV CX,NUM1    
    ;MOV ANS,CX
    ADD ANS,BX
    MOV AX,BX 
    DIV NUM1
    ADD ANS,AX
    ADD AX,DX
    
LEVEL5:
    CMP AX,NUM1
    JB LEVEL6
    MOV DX,0
    DIV NUM1
    ADD ANS,AX
    ADD AX,DX
    JMP LEVEL5
    
    
    
    
LEVEL6:
    ;SHOW THE OUTPUT
    MOV AX,ANS
LEVEL7:
    CMP AX,0
    JE LEVEL10
    MOV CX,10
    MOV DX,0 ; SEE HERE
    DIV CX
    ADD DX,'0'
    PUSH DX
    INC CNT
    JMP LEVEL7
    
LEVEL10:
    MOV AH,2
    MOV DL,CR
    INT 21H  
    MOV AH,2
    MOV DL,LF
    INT 21H
    
LEVEL8:
    CMP CNT,0
    JE LEVEL4
    POP DX
    DEC CNT
    MOV AH,2
    
    INT 21H
    JMP LEVEL8
    
    
   ;FROM HERE TO LOW PART IS OKKKKKKKKKKKKKK
  
    
LEVEL4:          
 ;interrupt to exit
 MOV AH, 4CH
 INT 21H 
  
MAIN ENDP 
END MAIN