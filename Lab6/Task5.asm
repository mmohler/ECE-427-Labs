org 100h
.DATA 
    LIST DB 7,6,1,3,9,1,8,2,4,3,5 ;Length 11
.CODE
        ;Loop Start
AGAIN:  MOV DI,OFFSET LIST ;Prep the pointer
        MOV CX,10 ;LIST LENGTH - 1                                       
        MOV AX,0 ;IF AX = 0, no changes, but if AX = 1, there was an exchange
        
NEXT:   MOV BH,[DI]
        MOV BL,[DI+1]
        CMP BH,BL
        JBE SKIP ;No exchange needed        

        ;Exchange Needed...
        MOV AX,1 ;Set a flag        
        ;Replace in reverse order
        MOV [DI],BL 
        MOV [DI+1],BH
SKIP:   INC DI   
        LOOP NEXT ;Iterate through all elems
        
        CMP AX,1
        JE  AGAIN
ret