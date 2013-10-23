
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h ;Start from memory location 100h
                                   
;Allocate Memory
.data
ERROR DB 'Hello World  ','$'
ENTERED_DATA DB 9,?,9,'$'
                                   

;Clear the screen
.code
MOV AH,06
MOV AL,00
MOV BH,07
MOV CH,00
MOV CL,00
MOV DH,24
MOV DL,79
INT 10H
                 
;Display a message                 
LEA DX,ERROR
MOV AH,09
INT 21H       

;Get User Input from Keyboard
MOV AH,01
INT 21H ;AL will be the input Char
       
;Move Cursor to line 2
MOV AH,02
MOV BH,00
MOV DL,00
MOV DH,01
INT 10H       

MOV DL,AL ;Move the Char
INT 21H

ret