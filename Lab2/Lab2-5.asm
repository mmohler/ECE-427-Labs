
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h    

.DATA
ASCII1 DB '2345623456'
ASCII2 DB '5432154321'
BCD1 DB 5 DUP(?)
BCD2 DB 5 DUP(?)
BCD_SUM DB 5 DUP(?)
ASCII_SUM DB 10 DUP(?)

; add your code here
.code             
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    MOV BX, OFFSET ASCII1
    MOV DI, OFFSET BCD1
    MOV CX, 10
    CALL ASCII_TO_BCD
    MOV BX, OFFSET ASCII2
    MOV DI, OFFSET BCD2
    MOV CX, 10
    CALL ASCII_TO_BCD
    CALL ADD_BCD
    MOV SI, OFFSET BCD_SUM
    MOV DI, OFFSET ASCII_SUM
    MOV CX, 05
    CALL BCD_TO_ASCII
    MOV AH,4CH
    INT 21H
MAIN ENDP


ASCII_TO_BCD PROC
    ;Convert ASCII to BCD
    AGAIN: MOV AX,[BX]
    AND AX,0F0FH
    PUSH CX
    MOV CL,4
    SHL AH,CL
    OR AL,AH
    MOV [DI],AL
    ADD BX,2
    INC DI
    POP CX
    LOOP AGAIN
    RET
ASCII_TO_BCD ENDP

ADD_BCD PROC
    MOV BX, OFFSET BCD1
    MOV DI, OFFSET BCD2
    MOV SI, OFFSET BCD_SUM
    MOV CX, 05
    CLC
    BACK: MOV AL,[BX] + 4
    ADC AL, [DI] + 4
    DAA
    MOV [SI] + 4, AL
    DEC BX
    DEC DI
    DEC SI
    LOOP BACK
    RET
ADD_BCD ENDP

BCD_TO_ASCII PROC
    AGAIN2: MOV AL, [SI]
    MOV AH, AL
    AND AX, 0F00FH
    PUSH CX
    MOV CL, 04
    SHR AH, CL
    OR  AX, 3030H
    XCHG AH, AL
    MOV [DI], AX
    INC SI
    ADD DI,2
    POP CX
    LOOP AGAIN2
    RET
BCD_TO_ASCII ENDP

END MAIN