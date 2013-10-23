
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h    

.data
ASCII1 DB '1234512345'
ASCII2 DB '5432154321'
BCD1 DB 5 DUP(?)
BCD2 DB 5 DUP(?)

; add your code here
.code
ASCTOBCD MACRO ASCII,BCD,COUNT
       ;This macro converts from ASCII to BCD
       MOV CX,COUNT
       MOV BX,OFFSET ASCII
       MOV DI,OFFSET BCD
AGAIN: MOV AX,WORD PTR [BX]
       AND AX,0F0FH
       XCHG AH,AL
       SHL AH,4
       OR AL,AH
       MOV WORD PTR [DI],AX
       ADD DI,2
       ADD BX,2
       LOOP AGAIN
ENDM

ASCTOBCD ASCII1,BCD1,5

ret