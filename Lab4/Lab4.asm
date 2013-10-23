
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data                  
    ASC_INP DB 3,?,3 DUP(0)
    DECIMAL DB 3,?,3 DUP(0) ;ACTUALLY BACKWARDS, BUT WORKS FOR THE MOST PART
    ASC_OUT DB ' -> ',2 DUP(0),'$'
.code

MOV AX,@DATA
MOV DS,AX   

;CLEAR THE SCREEN
MOV AX,0600H
MOV BH,07
MOV CX,0
MOV DX,184FH
INT 10H

;GET THE DATA
MOV AX,0A00H
MOV DX,OFFSET ASC_INP
INT 21H

;CONVERT ASCII TO BCD    
MOV BX, OFFSET ASC_INP
MOV DI, OFFSET DECIMAL
MOV AX,[BX+2] 
XCHG AH,AL
AND AX,0F0FH
MOV [DI], AX 

;MULT AH by 10
        MOV CX,9
        MOV DL,AH
MULT:   ADD AH,DL
        LOOP MULT

;NOW SUM
ADD AL,AH

;NOW SPLIT
MOV AH,AL
AND AL,0FH
AND AH,0F0H
SHR AH,4
XCHG AH,AL

;CONVERT TO ASCII
        ADD AL,30H
        CMP AL,3AH
        JB  NEXT
        ADD AL,07H 

NEXT:   ADD AH,30H
        CMP AH,3AH
        JB  DONE  
        ADD AH,07H
DONE:   MOV BX,OFFSET ASC_OUT
        ADD BX,4
    
;STORE VALUE
        MOV [BX],AX 

;PRINT VALUE
        MOV AH,09
        MOV DX,OFFSET ASC_OUT
        INT 21H

ret