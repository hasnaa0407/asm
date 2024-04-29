.model small
.stack 100h


.data
robot db 1 ;jouer avec un robot
msg_01 db "Combien de joueurs sont precsents ? (1 ou 2) : $" 
msg_02 db "tour de: $"
msg_03 db 10,13, "tour de l'adversaire $"
saut db 10,13,"$"
tour db 1; inisialer dans le programme C
nb_blanc db 20
nb_noir db 20 
i db ?
j db ?
x db ?
y db ?
n db ?
xx db ?
yy db ?
tableau db 50 DUP (1)
dix db 10
eat db ?;bool
pion db ?;bool
dame db ?;bool
e db 0
ea db ?
random db ?
casearrivee db ?
verifwithchanges db ?
seed dw 0  
    

message7 db 10,13,"i=$"
message8 db 10,13,"j=$"
message9 db 10,13,"x=$"
message10 db 10,13,"y=$"

.code

generate_random_digit:
    mov ah, 00h     
    int 1Ah         
    mov seed, dx 

    mov ax, seed    
    mov dx, 343Dh   
    mul dx         
    add ax, 269Ch   
    mov seed, ax    
    
    xor dx, dx    
    mov cx, 11       
    div cx         
    cmp dl,0
    je generate_random_digit:
    mov random, dl
    
endp generate_random_digit


main:
mov ax, @data
mov ds, ax
    
mov ah, 09h
lea dx,msg_01
int 21h

do_while_01:

mov ah, 01h         
int 21h
sub al,30h  
cmp al,1
je aff_robot
cmp al,2
je aff_robot

mov ah, 09h
lea dx,saut
int 21h
 
jmp do_while_01

aff_robot:
cmp al,1
je next01
mov al,0; ne jouer pas avec le robot
mov robot,al

next01:
;init damier
;affiche damier
;les declarations dans .data

;while loop lkbira ga3 tbda 3nd islam tkhlas 3end abdou

;condition while lkbira
;affication de les conditions ikon and abdou meme jmp

mov al,0
cmp al,nb_blanc
je fin_while_kbira
cmp al,nb_noir
je fin_while_kbira
;int x,y,i,j
;bool eat pion,dame


mov al,1
cmp al,tour
jne tour_advr

mov ah, 09h
lea dx,saut
int 21h
mov ah, 09h
lea dx,msg_02
int 21h

mov dl,tour; le tour change a la fin de la boucle while
add dl,48        
mov ah, 02h        
int 21h

do_while_02:
;affectation le nobre pour le i
mov ah, 09h
lea dx,message7
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al 
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h        
sub al, 30h 
add bl,al
;stocker la ligne dans la variable i:
mov i, bl   
mov bh ,0
mov bl,i

;affectation le nobre pour le j
mov ah, 09h
lea dx,message8
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h    
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al     
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h         
sub al, 30h 
add bl,al
; stocker la colonne dans la variable j:
mov j, bl   
mov bh ,0
mov bl,j        

call verifcasedepart
;return vrai (1) ou false (0) affecter le resultat vers -> e
mov al,1
cmp al,e
jne do_while_02
jmp fin_if1;pour eviter tour_advr car c'est un else{}
;GG
tour_advr:
; 2 adver soit le robot ou un joueur
mov ah, 09h
lea dx,msg_03
int 21h

mov al,1
cmp al,robot
jne joueur_advr

; avec le robot 
do_while_03:
call generate_random_digit; random <- x
mov al,random
mov i,al;i=random en plus hadik +1 en regler chiiikh
call generate_random_digit
mov al,random
mov j,al;j=random
call verifcasedepart
mov al,e
cmp al,1
jne do_while_03 
;print i 
;print j
jmp fin_if1
;GG
joueur_advr:

do_while_04:
;affectation le nobre pour le i
mov ah, 09h
lea dx,message7
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al 
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h        
sub al, 30h 
add bl,al
;stocker la ligne dans la variable i:
mov i, bl   
mov bh ,0
mov bl,i

;affectation le nobre pour le j
mov ah, 09h
lea dx,message8
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h    
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al     
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h         
sub al, 30h 
add bl,al
; stocker la colonne dans la variable j:
mov j, bl   
mov bh ,0
mov bl,j        

call verifcasedepart
mov al,1
cmp al,e
jne do_while_04 

fin_if1:
mov cl,i
mov ch,j

;call numero;recupirer n
mov ax,0
mov al,n
mov si,offset tableau
add si,ax
dec si
mov bl,[si]
cmp bl,1
je svt_inst
cmp bl,1
jne else_de_if

svt_inst:
mov al,1
mov pion,al
mov al,0
mov dame,al
jmp no_else

else_de_if:
mov al,0
mov pion,al
mov al,1
mov dame,al

no_else:

;bool casearrivee 

do_while_lkbira:;tkon while ta3ha end abdou
;bool verifwithchanges=true
mov al,1
mov verifwithchanges,al

cmp al,tour
jne else_de_if01

;affectation le nobre pour le x
mov ah, 09h
lea dx,message9
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al 
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h        
sub al, 30h 
add bl,al
;stocker la ligne dans la variable x:
mov x, bl
mov xx,bl   


;affectation le nobre pour le y
mov ah, 09h
lea dx,message10
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h    
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al     
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h         
sub al, 30h 
add bl,al
; stocker la colonne dans la variable j:
mov y, bl
mov yy,bl;kima 9olt babdou

call verifcasearrivee
mov al,ea
mov casearrivee,al   
jmp no_else1
   
else_de_if01:
mov al,robot
cmp al,1
jne esle_de_if02

call generate_random_digit; random <- x
mov al,random
mov i,al;i=random en plus hadik +1 en regler chiiikh
call generate_random_digit
mov al,random
mov j,al;j=random
call verifcasearrivee
mov al,ea
mov casearrivee,al
cmp al,1
jne no_affiche_xy
;print x
;print y

no_affiche_xy:
jmp no_else1

esle_de_if02:
;affectation le nobre pour le x
mov ah, 09h
lea dx,message9
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al 
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h        
sub al, 30h 
add bl,al
;stocker la ligne dans la variable x:
mov x, bl
mov xx,bl   
;affectation le nobre pour le y
mov ah, 09h
lea dx,message10
int 21h
;lecture du premier chiffre:
mov ah, 01h 
int 21h    
sub al, 30h 
mov  ah,0
mul dix 
mov bl,al     
;lecture du deuxieme chiffre:
mov ah, 01h 
int 21h         
sub al, 30h 
add bl,al
; stocker la colonne dans la variable j:
mov y, bl
mov yy,bl;kima 9olt babdou

call verifcasearrivee
mov al,ea
mov casearrivee,al

no_else1:
; ba9i 3end abdou




fin_do_while_lkbira:;3end abdou

fin_while_kbira:;3emd abdou


mov ah, 4Ch        
int 21h 


end main 
