
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA
    ASCII_INPUT DB 100,?,100 DUP(0) ;INPUT SHOULD BE TERMINATED BY A '.'
    CHAR_COUNT  DB 0
    WORD_COUNT  DB 0
.CODE 

      ;CLEAR THE SCREEN
      MOV AX,0600H
      MOV BH,07
      MOV CX,0
      MOV DX,184FH
      INT 10H
    
      ;GET THE DATA
      MOV AX,0A00H
      MOV DX,OFFSET ASCII_INPUT
      INT 21H
    
      ;STORE CURRENT CHARS IN DX
      ;STORE CHAR COUNT IN AH, AND WORD COUNT IN AL
      MOV BX,OFFSET ASCII_INPUT 
      ADD BX,2
      MOV AH,00
      MOV AL,00
NEXT: MOV DX,[BX]
      INC AH
      CMP DL,2EH ;CHECK IF FIRST CHAR IS A PERIOD
      JE  DONE
      INC AH
      CMP DH,2EH ;CHECK IF SECOND CHAR IS A PERIOD
      JE  DONE
      
      CMP DL,20H ;CHECK IF FIRST CHAR IS A SPACE
      JE SPACE
      CMP DH,20H ;CHECK IF SECOND CHAR IS A SPACE
      JE SPACE
      INC BX
      INC BX
      CMP AL,AL
      JE  NEXT
SPACE:INC AL
      INC BX
      INC BX
      CMP AL,AL
      JE  NEXT         
      
      ;THE PERIOD WAS FOUND, START STORING DATA
DONE: INC AL; ADD ONE WORD, SINCE WE END WITH A PERIOD, NOT A SPACE :D
      MOV BX,OFFSET CHAR_COUNT 
      MOV [BX],AH
      MOV BX,OFFSET WORD_COUNT
      MOV [BX],AL             
ret




