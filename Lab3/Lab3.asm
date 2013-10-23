
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data

LIST DW 12,23,45,67,88,123,4,21,98,67,43,47,888,32,12,322,80,65,432,44
MAX DW 00
MIN DW 00
MAXLOC DW 0
MINLOC DW 0


.code

MAIN   PROC FAR
       MOV AX,@DATA
       MOV DS,AX
       MOV CX,20
       MOV BX,OFFSET LIST
       SUB AX,AX ;AL will hold the highest number
       SUB DX,DX ;AH will hold the location of the highest number
AGAIN1:CMP AX,[BX]
       JA NEXT1
       MOV AX,[BX]
      
       ;GET LOCATION
       MOV DX,21
       SUB DX,CX     
      
NEXT1: INC BX 
       INC BX
       LOOP AGAIN1
       MOV MAX,AX
       MOV MAXLOC,DX   
       
       
       ;REPEAT FOR THE MIN          
       MOV AX,@DATA
       MOV DS,AX
       MOV CX,20
       MOV BX,OFFSET LIST
       SUB AX,AX ;AL will hold the lowest number
       SUB DX,DX ;AH will hold the location of the lowest number
       MOV AX,[BX] ;SET the first list value as the minimum
       MOV DX,1 ;SET the location of the min to be the first value
AGAIN2:CMP AX,[BX]
       JB NEXT2
       MOV AX,[BX]
       
       ;GET LOCATION
       MOV DX,21 ;One more than the number of items in the list
       SUB DX,CX ;Subtract the Counter Value from 21 and store
       
NEXT2: INC BX
       INC BX
       LOOP AGAIN2
       MOV MIN,AX
       MOV MINLOC,DX
                 
                 
       MOV AH,4CH
       INT 21H
MAIN   ENDP                                                                  
                                                                         
ret




