.model small
.stack 100h


.data  

saut db 10,13,"$" 
tableau db 50 DUP (1)
space db  " $"
  
couleur db ?
n db ?  
i db ?
j db ?
x db ?
y db ? 

a db ?
b db ?
c db ?
d db ?
e db ? 
k db ?
tour db 1 
pion db ?
dame db ? 
casearrivee db ?   
casearivevalide db ?
lignee db ?
colonnee db ? 


ii db ?
jj db ?
xx db ?
yy db ?
xxx db ?
yyy db ?
nn db ?
compteur db ?   
compteurbis db ?

avancer db ?
avanceligne db ?
nbrcaseadverssaire db ?
l db ?
co db ?
all db ?
ac db ? 
verifwithchanges db ?  
eat db ?
ea db ?
caneat db ?
goodchoice db ?
tryeat db ? 
caneattmp db ? 

trouver db ?
random db ?
seed dw 0
robot db ?
choix db ?
nombrenoir db 20
nombreblanc db 20 
tmp db ?
 
message db 10,13,"N=$" 
message2 db 10,13,"L=$"
message3 db 10,13,"C=$" 
message4 db 10,13,"faite entrez la ligne et la colonne et je te donne le contenu s'il exist:$"
message5 db 10,13,"faite entrez la ligne et la colonne de depart:$"  
message6 db 10,13,"faite entrez la ligne et la colonne d'ariver:$"

message7 db 10,13,"i=$"
message8 db 10,13,"j=$"
message9 db 10,13,"x=$"
message10 db 10,13,"y=$"

casedepartnexistepas db 10,13,"cette case de depart n'existe pas choisir une autre !$"
casedepartblanche db 10,13,"cette case de depart est blanche$"
casenoire db 10,13,"cette case est noire$" 

message20 db 10,13,"cette case n'existe pas$"
blanche20 db 10,13,"case blanche$"
pionnoir db 10,13,"pion noir$"
pionblanc db 10,13,"pion blanc$"
casevide db 10,13,"case vide$" 
damenoire db 10,13,"dame noire$"
dameblanche db 10,13,"dame blanche$"

eatagain db 10,13,"vous devez manger a nouveau vous avez comme depart:$" 

choixjeu db 10,13, "Combien de joueurs sont precsents ? (1 ou 2) : $"
message_tour db "tour de: $"  
message_adversaire db 10,13, "tour de l'adversaire $"
bienjouer db 10,13,"bien jouer!$"
jeuterminer db 10,13,"le jeu est terminer$"

dix db 10      -
deux db 2

.code  

main proc
     
    mov ax, @data
    mov ds, ax
    mov cx,0   
    
    mov ah, 09h
    lea dx,choixjeu
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
    
    je robot_true
    
    mov al,0; ne pas jouer avec le robot
    mov robot,al

    robot_true:
    
    mov robot,al  
    
    ;init damier
    
    call init 
    
    ;affiche damier 
    
    mov ah, 09h
    lea dx,saut
    int 21h
    
    call affichage
    
    ;les declarations dans .data
   
    ;la plus grande while:
    
  plus_grande_while:  

    ;condition plus grande while:

    mov al,0
    cmp al,nombreblanc
    je fin_while_plus_grande    
    cmp al,nombrenoir
    je fin_while_plus_grande
    
    ;int x,y,i,j
    ;bool eat pion,dame
    
    ;1er bloc
    
    ;bool caneat 
    ;int k 
    
    mov al,0
    mov compteurbis,al 
    
    mov al,0
    mov caneat,al
    
    mov al,tour
    cmp al,1 
    
    je boucle_tour_1
    
    mov al,50
    mov k,al ;k=50
    
    while001:
    
    mov al,caneat
    cmp al,0
    jne sort_while001
    
    mov al,compteurbis
    cmp al,nombreblanc
    je  sort_while001
    
    mov al,k
    cmp al,0
    jle sort_while001
    
    mov ax,0
    mov al,k
    mov n,al 
    
    mov si,offset tableau
    add si,ax
    dec si
    mov al,[si]
    
    cmp al,5
    
    je saut_dec_k 
    
    mov bx,0
    mov bl,tour
    cmp bl,1
    
    jne tour_de_adversaire_fisrt_ 
    
    cmp al,1  
    
    je faire_travail
    
    cmp al,3
    
    jne saut_dec_k
      
    jmp skip_tour_de_adversaire_fisrt_
      
    tour_de_adversaire_fisrt_:
    
    cmp al,2
    
    je faire_travail
    
    cmp al,4
    
    jne saut_dec_k
     
    skip_tour_de_adversaire_fisrt_:
    
    faire_travail:
    
    call ligne 
    
    call colonne  
    
    mov ax,0
    mov al,lignee
    mov ah,colonnee
    mov ii,al
    mov jj,ah
   
    call verifcasedepart ; recupierer le bool e
    
    mov al,e
    cmp al,1
    jne saut_dec_k
    
    call thereisfood ; en affecter deja les valeur de ii et jj aant le call verifcasedepart 
    
    saut_dec_k:
    
    mov al,k
    dec al
    mov k,al 
    
    mov al,compteurbis
    inc al
    mov compteurbis,al 
    
    jmp while001  
    
    sort_while001:
    
    jmp skip_boucle_tour_1
    
    boucle_tour_1:
    
    mov al,1
    mov k,al ;k=1
    
    while002:
    
    mov al,caneat
    cmp al,0
    jne sort_while002
    
    mov al,compteurbis
    cmp al,nombrenoir
    je  sort_while002
    
    mov al,k
    cmp al,50
    jg sort_while002
    
    mov ax,0
    mov al,k
    mov n,al 
    
    mov si,offset tableau
    add si,ax
    dec si
    mov al,[si]
    
    cmp al,5
    
    je saut_inc_k 
    
    mov bx,0
    mov bl,tour
    cmp bl,1
    
    jne tour_de_adversaire_fisrt_2 
    
    cmp al,1  
    
    je faire_travail_2
    
    cmp al,3
    
    jne saut_inc_k
      
    jmp skip_tour_de_adversaire_fisrt_2
      
    tour_de_adversaire_fisrt_2:
    
    cmp al,2
    
    je faire_travail_2
    
    cmp al,4
    
    jne saut_inc_k
     
    skip_tour_de_adversaire_fisrt_2:
    
    faire_travail_2:
    
    call ligne 
    
    call colonne  
    
    mov ax,0
    mov al,lignee
    mov ah,colonnee
    mov ii,al
    mov jj,ah
   
    call verifcasedepart ; recupierer le bool e
    
    mov al,e
    cmp al,1
    jne saut_inc_k
    
    call thereisfood ; en affecter deja les valeur de ii et jj aant le call verifcasedepart 
    
    saut_inc_k:
    
    mov al,k
    inc al
    mov k,al
    
    mov al,compteurbis
    inc al
    mov compteurbis,al  
    
    jmp while002  
    
    sort_while002:
    
    skip_boucle_tour_1:
    
    mov al,tour
    cmp al,1
    jne tour_advr

    mov ah, 09h
    lea dx,saut
    int 21h  
    
    mov ah, 09h
    lea dx,message_tour
    int 21h

    mov dl,tour; le tour change a la fin de la boucle while
    add dl,48        
    mov ah, 02h        
    int 21h 
    
    mov al,0
    mov goodchoice,al

  do_while_02:
    
    ;affecter le nombre a i:
    mov ah, 09h
    lea dx,message7   ;"i="
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
    ;affecter le nombre a j:
    mov ah, 09h
    lea dx,message8  ;"j="
    int 21h
    ;lecture du premier chiffre:
    mov ah, 01h 
    int 21h    
    sub al, 30h 
    mov ah,0
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
    
    ;saving les valeurs de i et j initiales:
    mov ax,0
    mov al,i
    mov ii,al
    mov ah,j
    mov jj,ah
    
    mov ax,0
    mov al,caneat
    mov caneattmp,al
    
    mov al,caneat
    cmp al,1
    jne else_if01
     
    call verifcasedepart
    
    mov al,e
    cmp al,1
    
    jne no_else_if01  
    
    call thereisfood 
    
    mov al,caneat
    mov goodchoice,al  
    
    jmp no_else_if01
    
    else_if01:
    
    call verifcasedepart

    mov al,e
    mov goodchoice,al
    
    no_else_if01:
    
    mov al,caneattmp
    mov caneat,al
    
    
    mov al,goodchoice
    cmp al,0
     
  je do_while_02 
    
    jmp fin_if1;pour eviter tour_advr car c'est un else{}
    ;GG 
    
    tour_advr:
    
    ; 2 adver soit le robot ou un joueur
    mov ah, 09h
    lea dx,message_adversaire
    int 21h  
    
    mov al,0
    mov goodchoice,al
    
    mov al,robot
    cmp al,1
    jne joueur_advr
    
    ; avec le robot 
    
    mov ax,0
    mov al,caneat
    cmp al,1   
    
    je skip_il_faut_random  
    
  do_while_03:
    
    call generate_random_digit; random <- x 
    
    mov al,random
    mov ii,al;i=random
    mov ah,0
    div deux
    cmp ah,0
    
    je i_pair
    
    do_j_pair:
    
    call generate_random_digit
    mov al,random
    mov ah,0
    div deux
    cmp ah,0 
    
    jne do_j_pair
    
    jmp skip_i_pair  
    
    i_pair:
    
    do_j_impaire:
    
    call generate_random_digit
    mov al,random
    mov ah,0
    div deux
    cmp ah,1 
    
    jne do_j_impaire
    
    skip_i_pair:
    
    mov al,random
    mov jj,al 
    
    mov al,ii
    mov i,al
    mov al,jj
    mov j,al
    
    call numero 
    
    mov ax,0
    mov al,n
    mov si,offset tableau 
    add si,ax 
    dec si
    mov al,[si]
    cmp al,2
    
    je do_work
    
    cmp al,4
    
    jne do_while_03
    
    do_work:
    
    mov ax,0
    mov al,caneat
    mov caneattmp,al
    
    mov al,caneat
    cmp al,1
    jne else_if02
     
    call verifcasedepart  
    
    mov al,e
    cmp al,1
    
    jne no_else_if02  
    
    call thereisfood 
    
    mov al,caneat
    mov goodchoice,al  
    
    jmp no_else_if02
    
    else_if02:
    
    call verifcasedepart
    
    mov al,e
    mov goodchoice,al
    
    no_else_if02:
    
    mov al,caneattmp
    mov caneat,al
    
    mov al,goodchoice
    cmp al,0
  
  je do_while_03 
  
    skip_il_faut_random: 
    
    ;affichage de la ligne i:
    mov ax,0
    mov ah, 09h  
    lea dx, message7
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,ii
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h 
    
    ;affichage de la colonne j:
    mov ax,0
    mov ah, 09h  
    lea dx, message8
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,jj
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h
    
    jmp fin_if1
    ;GG
    joueur_advr:
    
    mov al,0
    mov goodchoice,al
    
  do_while_04:    
    
    ;affectation pour i:
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
    
    ;conserver i et j dans ii et jj: 
    mov ax,0
    mov al,i
    mov ii,al
    mov ah,j
    mov jj,ah
    
    mov ax,0
    mov al,caneat
    mov caneattmp,al 
    
    mov al,1
    cmp al,caneat
    jne else_if03
     
    call verifcasedepart 
    
    mov al,e
    cmp al,1  
    
    jne no_else_if03
     
    call thereisfood
    
    mov al,caneat
    mov goodchoice,al  
    
    jmp no_else_if03
    
    else_if03: 
    
    call verifcasedepart
    
    mov al,e
    mov goodchoice,al
    
    no_else_if03:
    
    mov al,caneattmp
    mov caneat,al
    
    mov al,goodchoice
    cmp al,0 
    
  je do_while_04 
    
    fin_if1:
    
    mov ax,0
    mov al,ii
    mov i,al
    mov ah,jj
    mov j,ah
    
    call numero
    
    mov ax,0
    mov al,n
    mov si,offset tableau
    add si,ax
    dec si
    mov bl,[si]
    cmp bl,1
    
    je svt_inst
    
    cmp bl,2 
    
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
    
  do_while_plus_grande:
    
    ;bool verifwithchanges=true
    mov al,1
    mov verifwithchanges,al
    
    cmp al,tour
    jne else_de_if01 
    
  do_while_tour_de_1:  
    
    ;affectation le nombre pour le x
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
    
    ;conserver les valeurs de x et y dans xx et yy:
    
    mov ax,0
    mov al,x
    mov xx,al
    mov ah,y
    mov yy,ah  
    
    mov al,0
    mov verifwithchanges,al
   
    call verifcaseariver  
    
    mov al,ea
    mov casearrivee,al
    
    mov al,casearrivee
    cmp al,0 
    
    je do_while_tour_de_1
    
    mov al,eat
    cmp al,0 
    
    jne sort_do_while_tour_de_1 
    
    mov al,caneat
    cmp al,1  
    
    je do_while_tour_de_1
    
    sort_do_while_tour_de_1: 
    
    mov al,1  
    mov verifwithchanges,1
    
    call verifcaseariver   
    
       
    jmp no_else1
       
    else_de_if01: 
    
    mov al,robot
    cmp al,1
    jne esle_de_if02 
    
    mov ax,0
    mov compteur,al 
    
    call numero
    
    mov al,n
    mov si,offset tableau
    add si,ax
    dec si
    mov al,[si]
    cmp al,4
    
    je robot_avec_dame
    
    do_while_tour_de_robot:
    
    mov al,compteur
    cmp al,0
    
    jne cas_1_cas_2_cas_3
    
    mov al,ii
    dec al
    mov xx,al
    
    mov al,jj
    inc al
    mov yy,al 
    
    jmp faire_travail_random
    
    cas_1_cas_2_cas_3: 
    
    cmp al,1 
    
    jne cas_2_cas_3
    
    mov al,ii
    dec al
    mov xx,al
    
    mov al,jj
    dec al
    mov yy,al 
    
    jmp faire_travail_random
    
    cas_2_cas_3:
    
    cmp al,2 
    
    jne cas_3
    
    mov al,ii
    sub al,2
    mov xx,al
    
    mov al,jj
    add al,2
    mov yy,al 
    
    jmp faire_travail_random
    
    cas_3:
    
    mov al,ii
    sub al,2
    mov xx,al
    
    mov al,jj
    sub al,2
    mov yy,al
    
    faire_travail_random: 
    
    mov al,0
    mov verifwithchanges,al
    
    call verifcaseariver 
    
    mov al,ea
    mov casearrivee,al 
    
    mov al,compteur
    inc al
    mov compteur,al
    
    mov al,casearrivee
    cmp al,0
    je do_while_tour_de_robot
        
    mov al,eat
    cmp al,0
    jne sort_do_while_tour_de_robot
    mov al,caneat
    cmp al,1
    je do_while_tour_de_robot
        
    sort_do_while_tour_de_robot:
    
    jmp skip_robot_avec_dame 
    
    robot_avec_dame: 
    
  do_while_tour_de_robot_dame:
    
    call generate_random_digit
    
    mov al,random
    mov x,al;  
    
    call generate_random_digit
    
    mov al,random
    mov y,al;  
    
    mov ax,0
    mov al,x
    mov ah,y
    mov xx,al
    mov yy,ah 
    
    mov al,0
    mov verifwithchanges,al
    
    call verifcaseariver
    mov al,ea
    mov casearrivee,al
    
    mov al,casearrivee
    cmp al,0
    je do_while_tour_de_robot_dame
        
    mov al,eat
    cmp al,0
    jne sort_do_while_tour_de_robot_dame
    mov al,caneat
    cmp al,1
    je do_while_tour_de_robot_dame 
    
    sort_do_while_tour_de_robot_dame:  
    
    skip_robot_avec_dame:
    
    mov al,1
    mov verifwithchanges,al
    
    call verifcaseariver
    
    ;affichage de la ligne d'arriver x:
    mov ax,0
    mov ah, 09h  
    lea dx, message9
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,xx
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h 
    
    ;affichage de la colonne j:
    mov ax,0
    mov ah, 09h  
    lea dx, message10
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,yy
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h
     
    jmp no_else1

    esle_de_if02:
    
  do_while_tour_de_adversaire:
    
    ;affectation le nombre pour le x
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
    ;affectation le nombre pour le y
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
    
    ;conserver le x et y dans xx et yy:
    mov ax,0
    mov al,x
    mov xx,al
    mov ah,y
    mov yy,ah  
    
    mov al,0
    mov verifwithchanges,al
    
    call verifcaseariver
    
    mov al,ea
    mov casearrivee,al
    
    mov al,casearrivee
    cmp al,0
    
    je do_while_tour_de_adversaire
    
    mov al,eat
    cmp al,0
    
    jne sort_do_while_tour_de_adversaire
    
    mov al,caneat
    cmp al,1   
    
    je do_while_tour_de_adversaire
    
    sort_do_while_tour_de_adversaire:
     
    mov al,1
    mov verifwithchanges,al

    call verifcaseariver
    
    mov ax,0
    mov al,ea
    mov casearrivee,al
    
    no_else1: 
     
    ;stocker les valeurs de x et y dans xx et yy respectivement:
    mov ax,0
    mov al,x
    mov xx,al ;xx=x initial
    mov ah,y
    mov yy,ah ;yy=y initial  
    
    
    
    
  while_grande:
    
    mov ax,0
    mov al,eat
    cmp al,1
    
    jne fin_while_grande
    
    mov ax,0
    mov al,xx
    mov i,al ;i=x
    mov ah,yy
    mov j,ah ;j=y 
    
    mov ax,0
    mov al,i
    mov ii,al
    mov ah,j
    mov jj,ah   
    
    mov al,tour
    cmp al,1
    
    jne moins_noir
     
    mov al,nombreblanc
    sub al,1
    mov nombreblanc,al
    
    jmp skip_moins_noir
    
    moins_noir:
    
    mov al,nombrenoir
    sub al,1
    mov nombrenoir,al
    
    skip_moins_noir:
    
    call thereisfood
    
    mov ax,0
    mov al,caneat
    cmp al,1
    jne modif_eat_main 
    
    ;printf("vous devez manger a nouveau vous avez comme depart i=%d et j=%d\n", i, j);
    
    mov ah, 09h  ;affichage du eat again.
    lea dx, eatagain
    int 21h 
    
    ;affichage du i:
    mov ax,0
    mov ah, 09h  
    lea dx, message7
    int 21h
             
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,ii
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h
    
    ;affichage du j:
    mov ax,0
    mov ah, 09h  
    lea dx, message8
    int 21h  
    
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,jj
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h  
    
    mov ax,0
    mov verifwithchanges,al
   
    ;if_interne_1_1 (tour=1):
    
    mov ax,0
    mov al,tour
    cmp al,1
    
    jne if_interne_1_2 ;(robot=true) 
    
  do_while:
    
    ;lecture de la ligne d'arriver:
    mov ax,0
    mov ah, 09h  ;affichage du message "x=".
    lea dx, message9
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
    ; stocker la ligne dans la variable x:
    mov x, bl   
    mov bh ,0
    mov bl,x
         
    ;lecture de la colonne d'arriver:    
    mov ah, 09h  ;affichage du message "y=".
    lea dx, message10
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
    ; stocker la colonne dans la variable y:
    mov y, bl   
    mov bh ,0
    mov bl,y
    
    mov ax,0
    mov al,x
    mov ah,y
    mov xx,al
    mov yy,ah
     
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    cmp al,1
    
  jne do_while 
  
    jmp skip_robot_adversaire 
    
    if_interne_1_2: ;(robot=true)
    
    mov ax,0
    mov al,robot
    cmp al,1
    
    jne if_interne_1_2_2 ;(tour=-1) 
    
    do_while_robot_grande_while:
    
    
    call generate_random_digit; random <- x
    
    mov al,random
    
    mov x,al  
    
    call generate_random_digit
    
    mov al,random  
    
    mov y,al  
    
    mov ax,0
    mov al,x
    mov ah,y
    mov xx,al
    mov yy,ah
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    
    cmp al,1
    
    jne do_while_robot_grande_while
    
    ;affichage de la ligne d'arriver x:
    mov ax,0
    mov ah, 09h  
    lea dx, message9
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,x
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h 
    
    ;affichage de la colonne j:
    mov ax,0
    mov ah, 09h  
    lea dx, message10
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,y
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h
    
    jmp skip_robot_adversaire
    
    if_interne_1_2_2:
    
  do_while_tour_adversaire:
    
    ;lecture de la ligne d'arriver:
    mov ax,0
    mov ah, 09h  ;affichage du message "x=".
    lea dx, message9
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
    ; stocker la ligne dans la variable x:
    mov x, bl   
    mov bh ,0
    mov bl,x
        
    ;lecture de la colonne d'arriver:    
    mov ah, 09h  ;affichage du message "y=".
    lea dx, message10
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
    ; stocker la colonne dans la variable y:
    mov y, bl   
    mov bh ,0
    mov bl,y  
    
    mov ax,0
    mov al,x
    mov xx,al
    mov ah,y
    mov yy,ah
    
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    cmp al,1
    
  jne do_while_tour_adversaire 
    
    skip_robot_adversaire:  
    
    mov ax,0
    mov al,1
    mov verifwithchanges,al
    
    call verifcaseariver
     
    jmp skip_modif_eat_main
    
    modif_eat_main:
    
    mov ax,0
    mov eat,al
    
    skip_modif_eat_main:
    
    jmp while_grande
    
    fin_while_grande:
    
    mov ax,0
    mov al,casearrivee
    cmp al,0 
    
    je do_while_plus_grande
    
      
    ;printf("bien jouee\n");
    mov ax,0
    mov ah, 09h  
    lea dx, bienjouer
    int 21h   
    
    ;printf("\n%d %d \n", nb_blanc, nb_noir);     
    
    mov ax,0
    mov ah, 09h  
    lea dx, saut
    int 21h  
    
    ;printf(nombreblanc);
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,nombreblanc
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h    
    
    ;printf(nombrenoir);
    mov ax,0
    mov ah, 09h  
    lea dx, saut
    int 21h  
    
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,nombrenoir
    mov al,bl
    div dix
    mov bx,ax
    
    mov ah, 02h 
    mov dl,bl
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h      
    
    mov ah, 02h
    mov dl,bh
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h  
    
    mov ax,0
    mov ah,09h
    lea dx,saut 
    int 21h
    
    call affichage  
    
    mov ax,0
    mov al,tour 
    cmp al,1
    
    jne tour1
    
    sub al,2
    mov tour,al
    
    jmp skip_tour1 
                        
    tour1:
    
    add al,2 
    mov tour,al
    
    skip_tour1: 
    
  jmp plus_grande_while
  
  fin_while_plus_grande: 
  
  
    mov ax,0             
    
    mov ah, 09h  
    lea dx, jeuterminer
    int 21h
    
     
    mov ah, 4ch
    int 21h 
    
main endp    

generate_random_digit proc
      
    push bp
    mov bp,sp 
             
    regenerate:
             
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
    je regenerate 
    
    mov random, dl
   
    pop bp
    ret   
    
generate_random_digit endp 

ligne proc 

 
    push bp
    mov bp,sp
    
    mov cl,n 

    mov al,50
    mov bl,1

    cmp cl,al
    jg outt_ligne
    cmp cl,bl
    jl outt_ligne

    mov bx,5
    mov ax,cx
    div bl
    cmp ah,0
    je restezero
    add al,1
    mov ah,0 
    mov lignee,al
    jmp fin_ligne

    restezero:
    mov lignee,al
    jmp fin_ligne
    outt_ligne: 
    mov al,0
    mov lignee,al

    fin_ligne:
    
    pop bp
    ret  
ligne endp
              
colonne proc 

    push bp
    mov bp,sp
    
    mov cl,n 

    mov al,50
    mov bl,1

    cmp cl,al
    jg outt_colonne
    cmp cl,bl
    jl outt_colonne

    mov bx,10
    mov ax,cx
    div bl
    cmp ah,0
    je restezero2
    cmp ah,5
    jg sup_colonne 
    mov al,ah
    mov ah,0  
    mul deux  
    mov colonnee,al
    jmp fin_colonne:                                       
    sup_colonne:                                              
    mov al,ah
    mov ah,0
    sub al,5  
    mul deux
    sub al,1
    mov colonnee,al
    jmp fin_colonne:
    restezero2:
    mov al,9
    mov colonnee,al
    jmp fin_colonne:
    outt_colonne: 
    mov al,0
    mov colonnee,al

    fin_colonne: 
    
    pop bp
    ret 
colonne endp

init proc     
    
    push bp
    mov bp,sp
    mov si,offset tableau
    mov di,si
    add di,49
    mov cx,20 
    ;une boucle qui remplit le tableau de [1,20] avec des 1 (pion noir), et de [31,50] avec des 2 (pion blanc):
    boucle_init_1: 
    mov [di],2
    mov [si],1
    inc si
    dec di
    loop boucle_init_1
    ;une boucle pour remplir de [21,30] avec des 5 (case vide):
    mov cx,10
    boucle_init_2:
    mov [si],5 
    inc si
    loop boucle_init_2

    pop bp
    ret   
    
init endp

affichage proc 
    
    push bp
    mov bp,sp
    mov si,offset tableau
    mov cx,10 
    
    boucle_affichage_1:
    mov ax,cx
    push cx
    mov cx,5
    div deux 
    cmp ah,0   
    je zerofirst
    ;une boucle pour afficher les lignes avec un modulo sur deux egal a 1:
    boucle_affichage_2:
    
    mov ah, 02h       
    mov dl,[si]
    cmp dl,1
    
    jne pionblanc_damenoire_dameblanche_vide
    
    mov dl,1
    int 21h
    jmp fin 
    
    pionblanc_damenoire_dameblanche_vide: 
    
    cmp dl,2
    
    jne damenoire_dameblanche_vide 
    
    mov dl,2
    int 21h
    jmp fin
    
    damenoire_dameblanche_vide: 
    
    cmp dl,3
    
    jne dameblanche_vide 
    
    mov dl,3
    int 21h
    jmp fin
    
    dameblanche_vide:
    
    cmp dl,4
    
    jne vide 
    
    mov dl,4
    int 21h
    jmp fin
    
    vide:
    
    mov dl,32
    int 21h   
    
    fin:
    
    mov ah, 02h      
    mov dx,178
    int 21h
     
    inc si 
    loop boucle_affichage_2
    
    jmp suite
   
    zerofirst:
    
    boucle_affichage_3: 
    
    mov ah, 02h       
    mov dx,178
    int 21h
    
    mov ah, 02h       
    mov dl,[si]
    cmp dl,1
    
    jne pionblanc_damenoire_dameblanche_vide2
    
    mov dl,1
    int 21h
    jmp fin2
     
    pionblanc_damenoire_dameblanche_vide2: 
    
    cmp dl,2
    
    jne damenoire_dameblanche_vide2 
    
    mov dl,2
    int 21h
    jmp fin2
    
    damenoire_dameblanche_vide2: 
    
    cmp dl,3
    
    jne dameblanche_vide2 
    
    mov dl,3
    int 21h
    jmp fin2
    
    dameblanche_vide2:
    
    cmp dl,4
    
    jne vide2 
    
    mov dl,4
    int 21h
    jmp fin2
    
    vide2:
    
    mov dl,32
    int 21h   
    
    fin2:
   
    inc si 
    loop boucle_affichage_3
    
    suite:

    

    mov ah, 09h       
    lea dx,saut
    int 21h
    pop cx
    loop boucle_affichage_1

    pop bp
    ret    
    
affichage endp 

numero proc  
    
    push bp
    mov bp,sp
    mov cx,0
     
    mov ax,0
    mov bx,0
    mov al,10      ;verifier le i et le j s'ils sont bien dans l'intervalle [1,10].
    mov bl,1
    mov cl,i
    cmp cl,al
    jg numeronexistepas
    cmp cl,bl
    jl numeronexistepas
    mov cl,j
    cmp cl,al
    jg numeronexistepas
    cmp cl,bl
    jl numeronexistepas
    
    mov ax,0
    mov al,i
    div deux
    cmp ah,1 
    jne switch_numero
    
    mov ax,0
    mov al,j 
    div deux
    cmp ah,0 
    jne switch_numero 
    
    mov ax,0
    mov al,i 
    mul dix
    mov bx,0
    mov bl,j  
    add al,bl
    sub al,10
    div deux 
    mov n,al 
    
    jmp fin_numero
    
    switch_numero:
    
    mov ax,0
    mov al,j
    div deux
    cmp ah,1
    jne case_blanche_numero
    
    mov ax,0
    mov al,i
    div deux
    cmp ah,0
    jne case_blanche_numero
    
    mov ax,0 
    mov al,i 
    mov bl,j
    mul dix 
    add al,bl
    sub al,9
    div deux 
    mov n,al  
    
    jmp fin_numero 
    
    numeronexistepas: 
    mov ax,99
    mov n,al
    
    jmp fin_numero 
    
    case_blanche_numero:
    mov ax,0
    mov n,al
    
    fin_numero: 
    
    pop bp
    ret
numero endp  

couleurcase proc

    push bp
    mov bp,sp
     
    mov ax,0
    mov al,n
    
    cmp ax,99 
    
    jne case_noire_blanche
    
    mov bx,0
    mov bl,6
    mov couleur,bl
    jmp fin_couleur_case
    
    case_noire_blanche:
    
    cmp ax,0
    
    jne case_noire 
       
    mov bx,0
    mov bl,7
    mov couleur,bl
    jmp fin_couleur_case 
    
    case_noire:
    
    mov bx,0
    mov bl,8
    mov couleur,bl

    fin_couleur_case: 
    
    
    pop bp
    ret 
    
couleurcase endp 

comparer proc 
    
   push bp
   mov bp,sp
   mov dx,0
   mov dl,n ;n 
   
   cmp dx,99 
   
   jne blanche_autres
   
   mov ah,09h
   lea dx,casedepartnexistepas
   int 21h 
   
   jmp fin20
   
   
   blanche_autres:
   
   cmp dx,0
   
   jne autres
   
   mov ah,09h
   lea dx,casedepartblanche
   int 21h
   
   jmp fin20
   
   autres:
   mov dx,0
   mov dl,n
   mov si,0
   mov si,offset tableau   
   add si,dx 
   sub si,1
   

   cmp [si],1
   
   jne pionblanc_damenoir_dameblanche_casevide
   
   mov ah,09h
   lea dx,pionnoir
   int 21h 
   
   jmp fin20
    
   pionblanc_damenoir_dameblanche_casevide:
    
   cmp [si],2
   
   jne damenoir_dameblanche_casevide 
   
   mov ah,09h
   lea dx,pionblanc
   int 21h
   
   jmp fin20
   
   damenoir_dameblanche_casevide: 
   
   cmp [si],3  
   
   jne dameblanche_casevide
   
   mov ah,09h
   lea dx,damenoire
   int 21h
   
   jmp fin20
   
   dameblanche_casevide:
   
   cmp [si],4
   
   jne casevide20
   
   mov ah,09h
   lea dx,dameblanche
   int 21h  
   
   jmp fin20
   
   casevide20:
   
   mov ah,09h
   lea dx,casevide
   int 21h
    
   fin20:
   
   pop bp
   ret

comparer endp 

verifcasedepart proc 
    
   push bp
   mov bp,sp  
   mov si,offset tableau 
   
   ;appel a numero pour obtenir le numero de la case si elle existe:
   mov ax,0
   mov al,ii
   mov i,al
   mov ah,jj
   mov j,ah
   
   call numero
   call couleurcase
    
   mov ax,0
   mov al,couleur
   cmp ax,6  
    
   jne case_depart_blanche_noire
   
   mov ax,0
   mov ah,09h  ;affichage du message.
   lea dx,casedepartnexistepas
   int 21h 
   
   jmp modif_e_0 
   
   case_depart_blanche_noire:
   
   cmp ax,7
   
   jne case_depart_noire
   
   mov ax,0
   mov ah,09h  ;affichage du message.
   lea dx,casedepartblanche
   int 21h 
   
   jmp modif_e_0
   
   case_depart_noire: 
   
   ;verifier tour et initialiser a,b,c,d:
   mov ax,0
   mov al,tour
   cmp al,1
   jne switching_depart
   
   mov bx,0
   mov bl,2
   mov a,bl 
   mov bl,4
   mov b,bl
   mov bl,1
   mov c,bl
   mov bl,3
   mov d,bl 
   
   jmp apres_init
   
   switching_depart: 
   
   mov bx,0
   mov bl,1
   mov a,bl 
   mov bl,3
   mov b,bl
   mov bl,2
   mov c,bl
   mov bl,4
   mov d,bl
   
   apres_init:
    
   mov ax,0 
   mov cx,0
   mov cl,n
   add si,cx
   dec si
   mov al,[si]
   cmp al,c  
   
   je if2  
   
   cmp al,d 
   
   jne modif_e_0
   
   if2:
   
   ;conserver le i et le j dans dl et dh respectivement: 
   mov dx,0
   mov ax,0
   mov al,ii  
   mov dl,al
   add al,tour 
   mov i,al
   
   mov bx,0
   mov bl,jj
   mov dh,bl
   add bl,1 
   mov j,bl
   
   call numero
   
   mov si,offset tableau 
   mov ax,0
   mov al,n 
   mov cx,0
   add si,ax   
   dec si
   mov cl,[si]
   cmp cl,5
   
   je modif_e_1  
   
   mov al,ii
   add al,tour
   mov i,al 
   
   mov bl,jj
   sub bl,1
   mov j,bl
   
   call numero
             
   mov si,offset tableau 
   mov ax,0
   mov al,n
   add si,ax 
   dec si
   mov cx,0
   mov cl,[si]
   cmp cl,5
    
   je modif_e_1
    
   cmp cl,a
   
   je next_and_1
   
   cmp cl,b
   
   je next_and_1
   
   jmp next_or_4
    
   next_and_1: 
   
   mov al,ii
   add al,tour
   add al,tour
   mov i,al 
   
   mov bl,jj
   sub bl,2
   mov j,bl
   
   call numero 
   
   mov si,offset tableau 
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0
   mov cl,[si]
   cmp cl,5 
   
   je modif_e_1
   
   next_or_4:
    
   mov al,ii
   add al,tour
   mov i,al 
   
   mov bl,jj
   add bl,1
   mov j,bl
   
   call numero 
   
   mov si,offset tableau  
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0
   mov cl,[si]
   cmp cl,a
   
   je next_and_2 
   
   cmp cl,b  
   
   je next_and_2
   
   jmp verif_dame
   
   next_and_2:
    
   mov al,ii
   add al,tour 
   add al,tour
   mov i,al 
   
   mov bl,jj
   add bl,2
   mov j,bl
   
   call numero 
   
   mov si,offset tableau 
   mov ax,0
   mov al,n
   add si,ax 
   dec si      
   mov cx,0
   mov cl,[si]
   cmp cl,5
    
   je modif_e_1
   
   verif_dame:
   ;partie si c'est une dame:
   
   mov ax,0
   mov al,ii
   mov i,al
   mov ah,jj
   mov j,ah
   
   call numero
   
   mov si,offset tableau 
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0
   mov cl,[si] 
   cmp cl,d
   jne modif_e_0  ;condition non verifier
   
   ;1
   mov al,ii
   mov ah,jj
   sub al,tour
   inc ah
   mov i,al
   mov j,ah
   call numero
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0
   mov cl,[si]
   cmp cl,5
   je modif_e_1
    
   ;vrifier next||:
   ;2
   mov al,ii;al=i
   mov ah,jj;ah=j
   sub al,tour
   dec ah
   mov i,al
   mov j,ah
   call numero
   mov si,offset tableau
   mov ax,0
   mov al,n 
   add si,ax
   dec si
   mov cx,0 
   mov cl,[si]
   cmp cl,5
   je modif_e_1
     
   ;vrifier next || 
   ;3
   mov al,ii;al=i
   mov ah,jj;ah=j
   sub al,tour
   dec ah
   mov i,al
   mov j,ah
   call numero
   mov si,offset tableau
   mov si,0  
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0 
   mov cl,[si]
   cmp cl,5
   
   je next_et_1
   
   cmp cl,b
   
   jne next_ou_4
   
   next_et_1:
   ;1
   mov al,ii;al=i
   mov ah,jj;ah=j
   sub al,tour
   sub al,tour
   sub ah,2
   mov i,al
   mov j,ah
   call numero 
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0 
   mov cl,[si]
   cmp cl,5 
   
   je modif_e_1
   
   next_ou_4: 
   
   ;2
   mov al,ii;al=i
   mov ah,jj;ah=j
   sub al,tour
   inc ah
   mov i,al
   mov j,ah
   call numero 
   mov si,offset tableau
   mov ax,0
   mov al,n 
   add si,ax
   dec si
   mov cx,0  
   mov cl,[si]
   cmp cl,a  
   
   je  next_et_2
   
   cmp cl,b  
   
   jne modif_e_0 
   
   next_et_2:
   
   mov al,ii;al=i
   mov ah,jj;ah=j
   sub al,tour
   sub al,tour
   add ah,2
   mov i,al
   mov j,ah
   call numero 
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0  
   mov cl,[si]
   cmp cl,5  
   
   jne modif_e_0 ;tous la condition if n'est pas juste
  
   modif_e_1:
   
   mov bx,0
   mov bl,1
   mov e,bl
   
   jmp skip_modif_e_0
   
   modif_e_0:
   
   mov bx,0
   mov e,bl
   
   skip_modif_e_0:
   
   fin_proc_verficasedepart:
     
   pop bp 
   ret
verifcasedepart endp 

verifcaseariver proc  
    
   push bp
   mov bp,sp 
   
   mov dx,0
   mov bx,0 
   
   ;conserver le i et le j dans dl et dh respectivement(dl=i,dh=j):
   
   mov bl,xx
   mov bh,yy
   mov i,bl;i=x
   mov j,bh;j=y 
   call numero 
   mov ax,0
   mov al,n
   cmp al,0  ;case d'arriver blanche  
   
   jne skip_modif_ea_et_eat_0_1 
   
   mov ax,0
   mov ea,al
   mov eat,al 
   
   jmp fin_proc_verifcaseariver
   
   skip_modif_ea_et_eat_0_1:
           
   cmp al,99 ;case d'arriver inexistante
   
   jne skip_modif_ea_et_eat_0_2 
   
   mov ax,0
   mov ea,al
   mov eat,al 
   
   jmp fin_proc_verifcaseariver
   
   skip_modif_ea_et_eat_0_2:        
           
   ;deja fait i=x , j=y

   mov ax,0
   mov al,n
   mov si,offset tableau
   add si,ax
   dec si
   mov cl,[si]
   cmp cl,5   
   
   je skip_modif_ea_et_eat_0_3 
   
   mov ax,0
   mov ea,al
   mov eat,al 
   
   jmp fin_proc_verifcaseariver 
   
   skip_modif_ea_et_eat_0_3:

   ;int avancer declaration
   ;avancer =-1
   mov al,1
   sub al,2
   mov avancer,al

   mov al,jj ;al=j
   cmp al,yy
   jg next
   mov al,1
   mov avancer,al
   next:

   ;verifier tour et initialiser a,b,c,d:
   mov ax,0
   mov al,tour
   cmp al,1
   
   jne switching_arriver
   
   mov bx,0
   mov bl,2
   mov a,bl 
   mov bl,4
   mov b,bl
   mov bl,1
   mov c,bl
   mov bl,3
   mov d,bl 
   
   jmp if1_arriver
   
   switching_arriver: 
   
   mov bx,0
   mov bl,1
   mov a,bl 
   mov bl,3
   mov b,bl
   mov bl,2
   mov c,bl
   mov bl,4
   mov d,bl
   
   if1_arriver:

   mov al,ii
   add al,tour
   cmp al,xx
   jne if2_arriver
   mov al,jj
   add al,avancer
   cmp al,yy
   jne if2_arriver  
   
   ;verifwithchanges dans le main  

   mov al,1
   cmp verifwithchanges,al

   jne modif_ea_1_et_eat_0_4 
  
   mov bl,xx
   mov bh,yy
   mov i,bl;i=x
   mov j,bh;j=y
   call numero
   mov ax,0
   mov al,n
   mov si,offset tableau
   add si,ax
   dec si;recupirer offset damier[numerocase(x, y)]
   
   mov ax,0
   mov al,ii
   mov i,al
   mov ah,jj
   mov j,ah
   call numero
   mov ax,0
   mov al,n
   mov di,offset tableau
   add di,ax 
   dec di ;recupirer offset damier[numerocase(i, j)] 

   ;afectation
   mov al,[di]
   mov [si],al 
   mov [di],5

   mov al,xx
   cmp al,10
   je next_condt
   cmp al,1
   jne modif_ea_1_et_eat_0_4

   next_condt:
   mov al,d  
   mov [si],al   ;affectation pour transformer le pion a une dame. 
   
   modif_ea_1_et_eat_0_4:
   
   mov ax,0
   mov eat,al
   mov ah,1
   mov ea,ah
   
   jmp fin_proc_verifcaseariver
   
   if2_arriver:
   
   mov ax,0
   mov al,ii ;al=i
   add al,tour
   add al,tour
   
   cmp al,xx
   
   jne if3_arriver
   
   mov ax,0
   mov al,jj ;al=j
   add al,avancer 
   add al,avancer 
   
   cmp al,yy
   
   jne if3_arriver
   
   mov ax,0
   mov al,ii ;al=i
   add al,tour
   mov i,al
   
   mov bx,0
   mov bl,jj ;bl=j
   add bl,avancer 
   mov j,bl
   
   call numero
   
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0  
   mov cl,[si]
   cmp cl,a
   
   je next_if_interne_1
   
   cmp cl,b
   
   jne if3_arriver  
   
   next_if_interne_1:
   
   mov ax,0
   mov al,verifwithchanges
   cmp al,1
   
   jne modif_ea_1_et_eat_1_5
   
   ;mettre le contenu de la case de depart dans la case d'ariver:
   
   mov ax,0
   mov al,ii
   mov i,al
   mov ah,jj
   mov j,ah
   
   call numero 
   
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov bx,0 
   mov bl,[si]
   mov tmp,bl ;recupirer offset damier[numerocase(i,j)]
              ;stocker le contenu de la case de depart dans tmp 
   
   mov [si],5 ;rendre la case de depart vide
   
   mov ax,0
   mov al,xx
   mov i,al
   mov ah,yy
   mov j,ah
   
   call numero
    
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si  
   mov al,tmp ;recupirer offset damier[numerocase(x, y)]
   mov [si],al;mettre le changement dans la case d'arriver
   
   mov ax,0
   mov al,ii  ;al=i
   add al,tour
   mov i,al
   
   mov ah,jj  ;ah=j
   add ah,avancer
   mov j,ah
   
   call numero 
   
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si  
   mov [si],5;rendre la case au milieu vide 
   
   mov ax,0
   mov al,xx
   
   cmp al,10
   
   je dame_arriver
   
   cmp al,1
   
   jne modif_ea_1_et_eat_1_5 
   
   dame_arriver:
   
   mov ax,0
   mov al,xx
   mov i,al
   mov ah,yy
   mov j,ah
   
   call numero
    
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov al,d  
   mov [si],al
   
   modif_ea_1_et_eat_1_5:
   
   mov ax,0
   mov al,1
   mov eat,al
   mov ea,al
   
   jmp fin_proc_verifcaseariver
   
   if3_arriver:
   
   mov ax,0
   mov al,ii
   mov i,al
   mov ah,jj
   mov j,ah
   
   call numero

   mov si,offset tableau 
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cl,[si]
   cmp cl,d
   jne modif_ea_0_et_eat_0_6
   
   ;int avanceligne=-1
   mov al,ii
   cmp al,xx
   jge moins
   
   mov al,1
   mov avanceligne,al
   jmp skip_moins

   moins: 
   mov ax,0
   mov al,1
   sub al,2
   mov avanceligne,al
   skip_moins:
   
   ;int nbrcaseadverssaire =0
   mov ax,0
   mov nbrcaseadverssaire,al 
   ;int l= i+avanceligne;
   mov al,ii ;al=i
   add al,avanceligne
   mov l,al
   ;int co=j+avancer 
   mov al,jj
   add al,avancer 
   mov co,al
   ;int all=0
   mov ax,0
   mov all,al       
   ;int ac=0
   mov ac,al

   ;while loop
 while_arriver:
   
   mov ax,0 
   mov al,l
   cmp al,xx
   jne next_and_arv_1
   mov al,co
   cmp al,yy
   je fin_while_arriver 
   
   next_and_arv_1:
   mov al,co
   cmp al,10 
   jge fin_while_arriver
  
   cmp al,0
   jle fin_while_arriver
   
   mov al,l
   cmp al,10
   jge fin_while_arriver 
   
   cmp al,0
   jle fin_while_arriver
   ;faire 

   ;1er if:
   
   mov ax,0
   mov al,l
   mov ah,co
   mov i,al
   mov j,ah 
   
   call numero
   
   mov si,offset tableau
   mov ax,0 
   mov al,n
   add si,ax
   dec si
   mov cl,[si]
   cmp cl,c
   je modif_ea_0_et_eat_0_6   
   
   ;next condition 
   cmp cl,d 
   
   je modif_ea_0_et_eat_0_6

   ;2eme if:

   cmp cl,a 
   
   je if2_interne_3 
   
   cmp cl,b
   
   jne condition_while

   if2_interne_3:
   
   mov al,nbrcaseadverssaire
   cmp al,0
   jne modif_ea_0_et_eat_0_6

   mov al,l
   mov all,al
   mov al,co
   mov ac,al  
   
   mov ax,0
   mov al,nbrcaseadverssaire
   add al,1
   mov nbrcaseadverssaire,al

   condition_while:
   mov al,l
   add al,avanceligne
   mov l,al
   ;next affectation
   mov al,co
   add al,avancer
   mov co,al

 jmp while_arriver

   fin_while_arriver:
   
   mov ax,0
   mov al,l
   cmp al,xx
   jne modif_ea_0_et_eat_0_6
   
   mov al,co
   cmp al,yy
   jne modif_ea_0_et_eat_0_6
   
   ;if((l == x)&&(co == y))
   
   mov al,verifwithchanges
   cmp al,1
   
   jne if2_interne_4_2 
   
   ;recuperer les valeurs initiales de i et j:
   
   mov ax,0
   mov al,ii 
   mov i,al
   mov ah,jj
   mov j,ah
   
   call numero
   
   mov si,offset tableau
   mov ax,0 
   mov al,n
   add si,ax
   dec si
   
   mov ax,0
   mov al,l
   mov i,al
   mov al,co
   mov j,al
   
   call numero
   
   mov di,offset tableau
   mov ax,0 
   mov al,n
   add di,ax
   dec di 
   
   mov ax,0
   mov al,[si]
   mov [di],al 
   mov [si],5
   
   mov ax,0
   mov al,x
   cmp al,10
   
   je  dame_4
   
   cmp al,1 
   jne if2_interne_4_1_2
   
   dame_4:
   
   mov ax,0
   mov al,x
   mov i,al
   mov ah,y
   mov j,ah
   
   call numero 
   
   mov si,offset tableau
   mov ax,0 
   mov al,n
   add si,ax
   dec si 
   mov ax,0
   mov al,d
   mov [si],al
   
   if2_interne_4_1_2:
   
   mov ax,0
   mov al,nbrcaseadverssaire
   cmp al,0 
   
   je if2_interne_4_2
   
   mov ax,0
   mov al,all
   mov i,al
   mov ah,ac
   mov j,ah
   
   call numero 
   
   mov si,offset tableau
   mov ax,0 
   mov al,n
   add si,ax
   dec si
   mov [si],5 
   
   if2_interne_4_2:
   
   mov ax,0
   mov al,nbrcaseadverssaire
   cmp al,0
   jne eat_true
   
   mov ax,0
   mov eat,al
   
   jmp skip_eat_true
   
   eat_true: 
   
   mov ax,0
   mov al,1 
   mov eat,al 
   
   skip_eat_true:
   
   mov ax,0
   mov al,1
   mov ea,al
   
   jmp fin_proc_verifcaseariver 
   
   modif_ea_0_et_eat_0_6:
   
   mov ax,0
   mov eat,al
   mov ea,al
   
   fin_proc_verifcaseariver: 
    
   pop bp 
   ret
verifcaseariver endp 

thereisfood proc
    
   push bp
   mov bp,sp 

    mov ax,0
    mov verifwithchanges,al
    mov caneat,al 
    
    mov ax,0
    mov al,ii
    mov i,al
    mov ah,jj
    mov j,ah
    
    call numero
    
    mov ax,0
    mov al,n
    mov si,offset tableau
    add si,ax
    dec si
    mov bl,[si]
    cmp bl,1    
    
    je if_verifier 
    
    cmp bl,2
    
    je if_verifier
     
    ;else
    mov al,0
    mov pion,al
    mov al,1
    mov dame,al 
    
    jmp saute_next
     
    if_verifier:  
    
    mov al,1
    mov pion,al
    mov al,0
    mov dame,al
    
    saute_next:
    
    ;if_pion
    mov al,1
    cmp al,pion 
    
    jne saute_dame 
    
    mov al,0
    mov tryeat,al
    
    ;affecter les valeur de x et y
    
    mov al,tour
    add al,tour
    add al,ii
    mov xx,al
    
    mov al,jj
    add al,2
    mov yy,al
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    mov tryeat,al
    
    mov al,1
    cmp al,tryeat
    
    jne saute_next1
    
    mov al,1
    mov caneat,al
    
    saute_next1:
    
    ;affecter les valeur de x et y
    mov al,tour
    add al,tour
    add al,ii
    mov xx,al
    mov al,jj
    sub al,2
    mov yy,al
    
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    mov tryeat,al
    
    mov al,1
    cmp al,tryeat
    
    jne saute_dame 
    
    mov al,1
    mov caneat,al


    saute_dame:

    mov al,1
    cmp al,dame
    jne fin_proc_tryeat    

    mov al,0
    mov verifwithchanges,al
  
    mov al,2
    mov nn,al
    
    while_interne_1:
    
    mov al,caneat
    cmp al,0 
    
    jne fin_while_interne_1
    
    mov al,ii
    add al,nn
    cmp al,10
    
    jg fin_while_interne_1 
    
    cmp al,0
    
    jle fin_while_interne_1
    
    mov al,jj
    add al,nn
    cmp al,10
    
    jg fin_while_interne_1 

    cmp al,0
    
    jle fin_while_interne_1 
    
    mov al,ii
    add al,nn
    mov xx,al
    mov al,jj
    add al,nn
    mov yy,al
    
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    mov caneat,al
    
    mov al,nn
    inc al
    mov nn,al
    
    jmp while_interne_1
    
    fin_while_interne_1:
    
    
    mov al,2
    mov nn,al
    
    while_interne_2:
  
    mov al,caneat
    cmp al,0 
    
    jne fin_while_interne_2
    
    mov al,ii
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_2  
    
    cmp al,0
    
    jle fin_while_interne_2
    
    mov al,jj
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_2 
  
    cmp al,0
    
    jle fin_while_interne_2
    
    mov al,ii
    sub al,nn
    mov xx,al
    mov al,jj
    sub al,nn
    mov yy,al
    
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    mov caneat,al
    
    mov al,nn
    inc al
    mov nn,al
    
    jmp while_interne_2
    
    
    fin_while_interne_2:

    mov al,2
    mov nn,al
    
  
    while_interne_3: 
    
    mov al,caneat
    cmp al,0 
    
    jne fin_while_interne_3
    
    mov al,ii
    add al,nn
    cmp al,10
    
    jg fin_while_interne_3
    
    cmp al,0
    
    jle fin_while_interne_3
    
    mov al,jj
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_3 
    
    cmp al,0
    
    jle fin_while_interne_3
     
    mov al,ii
    add al,nn
    mov xx,al
    mov al,jj
    sub al,nn
    mov yy,al
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    mov caneat,al
    
    mov al,nn
    inc al
    mov nn,al
    
    jmp while_interne_3
    
    
    fin_while_interne_3: 
    
    
    while_interne_4: 
    
    mov al,caneat
    cmp al,0 
    
    jne fin_while_interne_4
    
    mov al,ii
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_4  
    
    cmp al,0
    
    jle fin_while_interne_4
    
    mov al,jj
    add al,nn
    cmp al,10
    
    jg fin_while_interne_4 
   
    cmp al,0
    
    jle fin_while_interne_4
     
    mov al,ii
    sub al,nn
    mov xx,al
    mov al,jj
    add al,nn
    mov yy,al
    
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    mov caneat,al
    
    mov al,nn
    inc al
    mov nn,al
    
    jmp while_interne_4
    
    
    fin_while_interne_4:
   
    fin_proc_tryeat:

    pop bp 
    ret
thereisfood endp
