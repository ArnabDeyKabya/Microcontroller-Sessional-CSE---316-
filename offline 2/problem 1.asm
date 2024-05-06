.MODEL SMALL
.STACK 100H
.DATA
N DW ?
K DW ?
TOTAL DW ?

.CODE
MAIN PROC 
    ; Input n
    mov ah, 01h ; function to read character from standard input
    int 21h     ; interrupt to invoke the function
    sub al, '0' ; convert ASCII to integer
    mov n, al   ; store the value in n
    
    ; Input k
    mov ah, 01h
    int 21h
    sub al, '0'
    mov k, al
    
    ; Calculate total number of chocolates
    mov al, n   ; initialize al with n
    mov bl, k   ; initialize bl with k
    div bl      ; al / bl, quotient in al, remainder in ah
    add total, al ; add quotient to total
    
    exchange_loop:
    cmp ah, bl   ; compare remainder with k
    jb no_exchange ; jump if remainder is less than k
    mov al, ah   ; exchange wrappers for chocolates
    div bl       ; al / bl, quotient in al, remainder in ah
    add total, al ; add quotient to total
    jmp exchange_loop ; repeat the exchange loop
    
    
    no_exchange:
    ; Output total
    add total, '0' ; convert total to ASCII
    mov ah, 02h    ; function to print character to standard output
    int 21h        ; interrupt to invoke the function
    
    ; Exit program
    mov ah, 4Ch    ; function to terminate program
    int 21h        ; interrupt to invoke the function  
    
    
     MAIN ENDP
END MAIN
    
    
    

    