
verifcasearrivee proc 
;recupirer le x et y et i et j
mov eat,0;inisialiser eat pas 1 
mov ea,0;inisialiser ea par 0

mov dl,i
mov dh,j
mov bl,x
mov bh,y
mov i,bl;i=x
mov j,bh;j=y 
call numero
cmp n,0
je fin_proc_verifcasearivee;verifier
;deja fait i=x , j=y

call numero

mov ax,0
mov al,n
mov si,offset tableau
add si,ax
dec si
mov cl,[si]
cmp cl,5
jne fin_proc_verifcasearivee



;int avancer declaration
;avancer =-1
mov al,1
sub al,2
mov avancer,al

mov al,j
cmp al,y
jg next
mov avancer,1
next:



;verifier tour et initialiser a,b,c,d:
   mov ax,0
   mov al,tour
   cmp al,1
   jne switching01
   
   mov bx,0
   mov bl,2
   mov a,bl 
   mov bl,4
   mov b,bl
   mov bl,1
   mov c,bl
   mov bl,3
   mov d,bl 
   
   jmp next_code
   
   switching01: 
   
   mov bx,0
   mov bl,1
   mov a,bl 
   mov bl,3
   mov b,bl
   mov bl,2
   mov c,bl
   mov bl,4
   mov d,bl
   
   nexte_code:

mov al,i
add al,tour
cmp al,x
jne abdou1
mov al,j
add al,avancer
jne abdou1 
;verifwithchanges dans le main  


cmp verifwithchanges,1
jne modif_ea_1

mov dl,i
mov dh,j
mov bl,x
mov bh,y
mov i,bl;i=x
mov j,bh;j=y
call numero
mov ax,0
mov al,n
mov si,offset tableau
add si,ax
dec si;recupirer offset damier[numerocase(x, y)]


mov i,dl
mov j,dh
call numero
mov ax,0
mov al,n
mov di,offset tableau
add di,ax 
dec di ;recupirer offset damier[numerocase(i, j)] 

;afectation
mov [si],[di] 
mov [di],5

mov al,x
cmp al,10
je next_condt
cmp al,1
jne modif_ea_1

next_condt:  
mov [si],d;affectation
jmp modif_ea_1 

abdou1:
 

 

 
   
islam1:
mov i,dl
mov j,dh
call numero
mov ax,0
mov si,offset tableau
mov al,n
add si,ax
dec si
mov cl,[si]
cmp cl,d
jne fin_proc_verifcasearrivee

;int avanceligne=-1
mov al,i
cmp i,x
jge next01
mov al,1
mov avanceligne ,al

next01:
;int nbrcaseadverssaire =0
;int l
;int all=0
;int ac=0
;int co=j+avancer

mov al,i
add al,vanceligne
mov l,al
mov al,j
add al,avancer


;while loop
loop01:
mov al,co
cmp al,10
jge fin_while
;|| 
mov al,l
cmp al,x
jne next_codt
mov al,co
cmp al,y
je fin_while

next_codt:

mov al,l
cmp al,10
jge fin_while 

mov al,l
cmp al,0
jle fin_while;fait 

mov al,co
cmp al,0
jle fin_while;fait
;1er if:

mov al,l
mov ah,co
mov i,al
mov j,ah
call numero
mov ax,0 
mov al,n
mov si,offset tableau
add si,al
dec si
mov cl,[si]
cmp cl,c
je fin_proc_verifcasearrivee 

;next condition 
mov al,l;hna dert copier coller
mov ah,co
mov i,al
mov j,ah
call numero
mov ax,0 
mov al,n
mov si,offset tableau
add si,al
dec si
mov cl,[si]
cmp cl,d
je fin_proc_verifcasearrivee

;2eme if
mov al,l;hna dert copier coller
mov ah,co
mov i,al
mov j,ah
call numero
mov ax,0 
mov al,n
mov si,offset tableau
add si,ax
dec si
mov cl,[si]
cmp cl,a
je next03 

mov al,l;hna dert copier coller
mov ah,co
mov i,al
mov j,ah
call numero
mov ax,0 
mov al,n
mov si,offset tableau
add si,al
mov cl,[si]
cmp cl,b
jne condition_while

next03:
;2.1 eme if:

mov al,nbrcaseadverssaire
cmp al,0
jne fin_proc_verifcasearrivee

mov al,l
mov all,al
mov al,co
mov ac,al 

condition_while:
mov al,l
add al,avanceligne
mov l,al
;next affectation
mov al,co
add al,avancer
mov co,al

jmp loop01

fin_while:

abdou2:
 





   
modif_eat_1:
mov eat,1

modif_ea_1:
mov ea,1
    
fin_proc_verifcasearrivee:


ret

verifcasearrivee endp
