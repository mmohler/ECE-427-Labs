
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h ;Start from memory location 100h
                                   
;Allocate Memory
.data
MSG1 DB 'Enter your first name: ','$'
MSG2 DB 'Enter your last name: ','$'
FIRSTNAME DB 8,?,8 DUP (255), '$'
LASTNAME DB 8,?,8 DUP (?),'$'                                  

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
LEA DX,MSG1
MOV AH,09
INT 21H       

;Get FIRSTNAME from Keyboard
MOV AH,0AH
LEA DX,FIRSTNAME
INT 21H
       
;Move Cursor to line 2
MOV AH,02
MOV BH,00
MOV DL,00
MOV DH,01
INT 10H

;Display a message                 
LEA DX,MSG2
MOV AH,09
INT 21H

;Get LASTNAME from Keyboard
MOV AH,0AH
LEA DX,LASTNAME
INT 21H       

;Move Cursor to line 3
MOV AH,02
MOV BH,00
MOV DL,00
MOV DH,02
INT 10H

;Move Cursor Position                   
MOV AH,02
MOV BH,00
MOV DL,08
MOV DH,02
INT 10H

;Display Last Name
MOV DX,OFFSET LASTNAME
ADD DX,02H
MOV AH,09
INT 21H
              
;Display First name                
LEA DX,FIRSTNAME
MOV AH,09
INT 21H

;Wait for user input
MOV AH,01
INT 21H

;CLEAR SCREEN  
MOV AH,06
MOV AL,00
MOV BH,07
MOV CH,00
MOV CL,00
MOV DH,24
MOV DL,79
INT 10H

;end program
ret