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
tour db 1 
pion db ?
dame db ? 
casearrivee db ?

ii db ?
jj db ?
xx db ?
yy db ?
nn db ? 

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
    lea dx,message_adversaire
    int 21h
    
    mov al,robot
    cmp al,1
    jne joueur_advr
    
    ; avec le robot 
  do_while_03:  
    
    call generate_random_digit; random <- x 
    
    mov al,random
    mov i,al;i=random 
    
    call generate_random_digit 
    
    mov al,random
    mov j,al;j=random 
    
    call verifcasedepart  
    
    mov al,e
    cmp al,1
    
  jne do_while_03  
    
    ;affichage de la ligne i:
    mov ax,0
    mov ah, 09h  
    lea dx, message7
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,i
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
    mov bl,j
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
    
    call verifcasedepart 
    
    mov al,1
    cmp al,e 
    
  jne do_while_04 
    
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
    
    call verifcaseariver 
    
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
    
    call verifcaseariver
    
    mov al,ea
    mov casearrivee,al 
    
    cmp al,1  
    
    jne no_affiche_xy
    
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
    
    no_affiche_xy: 
    
    jmp no_else1

    esle_de_if02:
    
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
    
    call verifcaseariver 
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
    
    mov ax,0
    mov verifwithchanges,al
    
    mov al,pion
    cmp al,1  
    
    jne sauter_dame
     
    mov al,i  ;al=i
    add al,tour
    add al,tour
    mov x,al   ;x=i+2*tour
    
    mov al,j  ;al=j
    add al,2
    mov y,al   ;y=j+2
    
    ;conserver x et y dans xx et yy:
    mov ax,0
    mov al,x
    mov xx,al
    mov ah,y
    mov yy,ah
    
    call verifcaseariver 
    
    mov ax,0
    mov al,ea
    cmp al,1
    
    je if1_interne_1
    
    mov al,j  ;al=j
    sub al,2
    mov y,al   ;y=j-2
    
    call verifcaseariver 
    
    mov ax,0
    mov al,ea
    cmp al,1
    
    jne modif_eat_main ;(eat=0) 
    
    if1_interne_1:
    
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
    mov bl,i
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
    mov bl,j
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
    
    
    ;hna ndirou tae robot b random wla ai. 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    push bx
        
        
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
    
    ;if (dame):
   
    sauter_dame:
    
    mov ax,0
    mov al,dame
    cmp al,1
    
    jne fin_while_grande
    
    mov ax,0
    mov verifwithchanges,al
    mov trouver,al
    
    mov al,2
    mov nn,al
    
  while_interne_1:
    
    mov al,trouver
    cmp al,0 
    
    jne fin_while_interne_1
    
    mov al,xx
    add al,nn
    cmp al,10
    
    jg fin_while_interne_1
    
    cmp al,0
    
    jle fin_while_interne_1 
    
    mov al,yy
    add al,nn
    cmp al,10
    
    jg fin_while_interne_1
    
    cmp al,0
    
    jle fin_while_interne_1 
    
    mov ax,0
    mov al,xx
    mov i,al ;i=x
    mov ah,yy
    mov j,ah ;j=y
    
    mov ax,0
    mov al,xx 
    add al,nn 
    mov x,al  ;x=x+n
    mov ah,yy
    add ah,nn
    mov y,ah  ;y=y+n
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    mov trouver,al
    
    mov al,nn
    inc al
    mov nn,al
    
  jmp while_interne_1
    
    fin_while_interne_1:
    
    mov al,2
    mov nn,al
    
  while_interne_2:
    
    mov al,trouver
    cmp al,0 
    
    jne fin_while_interne_2
    
    mov al,xx
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_2
    
    cmp al,0
    
    jle fin_while_interne_2 
    
    mov al,yy
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_2
    
    cmp al,0
    
    jle fin_while_interne_2 
    
    mov ax,0
    mov al,xx
    mov i,al ;i=x
    mov ah,yy
    mov j,ah ;j=y
    
    mov ax,0
    mov al,xx 
    sub al,n 
    mov x,al  ;x=x-n
    mov ah,yy
    sub ah,n
    mov y,ah  ;y=y-n
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    mov trouver,al
    
    mov al,nn
    inc al
    mov nn,al
    
  jmp while_interne_2
    
    fin_while_interne_2:
    
    mov al,2
    mov nn,al
    
    while_interne_3:
    
    mov al,trouver
    cmp al,0 
    
    jne fin_while_interne_3
    
    mov al,xx
    add al,nn ;al=x+n
    cmp al,10
    
    jg fin_while_interne_3
    
    cmp al,0
    
    jle fin_while_interne_3 
    
    mov al,yy
    sub al,nn ;al=y-n
    cmp al,10
    
    jg fin_while_interne_3
    
    cmp al,0
    
    jle fin_while_interne_3 
    
    mov ax,0
    mov al,xx
    mov i,al ;i=x
    mov ah,yy
    mov j,ah ;j=y
    
    mov ax,0
    mov al,xx 
    add al,n 
    mov x,al  ;x=x+n
    mov ah,yy
    sub ah,n
    mov y,ah  ;y=y-n
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    mov trouver,al
    
    mov al,nn
    inc al
    mov nn,al
    
  jmp while_interne_3
    
    fin_while_interne_3:
    
    mov al,2
    mov nn,al
    
    while_interne_4:
    
    mov al,trouver
    cmp al,0 
    
    jne fin_while_interne_4
    
    mov al,xx
    sub al,nn ;al=x-n
    cmp al,10
    
    jg fin_while_interne_4
    
    cmp al,0
    
    jle fin_while_interne_4 
    
    mov al,yy
    add al,nn ;al=y+n
    cmp al,10
    
    jg fin_while_interne_4
    
    cmp al,0
    
    jle fin_while_interne_4 
    
    mov ax,0
    mov al,xx
    mov i,al ;i=x
    mov ah,yy
    mov j,ah ;j=y
    
    mov ax,0
    mov al,xx 
    sub al,n 
    mov x,al  ;x=x-n
    mov ah,yy
    add ah,n
    mov y,ah  ;y=y+n
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    mov trouver,al
    
    mov al,nn
    inc al
    mov nn,al
    
  jmp while_interne_4
    
    fin_while_interne_4: 
    
    ;if (trouvee == true):
    mov ax,0
    mov al,trouver
    cmp al,1
    
    jne modif_eat_main_0
    
    ;printf("vous devez manger a nouveau vous avez comme depart i=%d et j=%d\n", x, y);
    
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
    
    ;affichage du j:
    mov ax,0
    mov ah, 09h  
    lea dx, message8
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
    
    mov ax,0
    mov verifwithchanges,al
    
    mov al,tour
    cmp al,1    
    
    jne robot_adversaire_dame
    
  do_while_dame:
    
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
    
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    cmp al,1
    
  jne do_while_dame
  
    jmp skip_robot_adversaire_dame
    
    robot_adversaire_dame:
     
    mov ax,0
    mov al,robot 
    cmp al,1
    
    jne adversaire 
    
    
    
    ;hna tan random
    
    
    
    

    
    
    
    jmp skip_robot_adversaire_dame
    
    adversaire:
    
  do_while_dame_adversaire:
    
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
    
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    cmp al,1
    
  jne do_while_dame_adversaire
    
    skip_robot_adversaire_dame:
    
    mov ax,0
    mov al,1
    mov verifwithchanges,al
    
    call verifcaseariver
    
    jmp skip_modif_eat_main_0
    
    modif_eat_main_0:
    
    mov ax,0
    mov eat,al 
    
    skip_modif_eat_main_0:
   
    
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
   
   jne fin_proc_verficasedepart
   
   if2:
   
   ;conserver le i et le j dans dl et dh respectivement: 
   mov dx,0
   mov ax,0
   mov al,i  
   mov dl,al
   add al,tour 
   mov i,al
   
   mov bx,0
   mov bl,j
   mov dh,bl
   add bl,1 
   mov j,bl
   
   call numero
   
   mov si,offset tableau 
   mov ax,0
   mov al,n 
   mov cx,0
   add si,ax
   mov cl,[si]
   cmp cl,5
   
   je modif_e_1  
   
   mov al,dl
   add al,tour
   mov i,al 
   
   mov bl,dh
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
   
   mov al,dl
   add al,tour
   add al,tour
   mov i,al 
   
   mov bl,dh
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
    
   mov al,dl
   add al,tour
   mov i,al 
   
   mov bl,dh
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
    
   mov al,dl
   add al,tour 
   add al,tour
   mov i,al 
   
   mov bl,dh
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
   
   mov i,dl
   mov j,dh
   
   call numero
   
   mov si,offset tableau 
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cx,0
   mov cl,[si] 
   cmp cl,d
   jne fin_proc_verficasedepart  ;condition non verifier
   
   ;1
   mov al,dl
   mov ah,dh
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
   mov al,dl;al=i
   mov ah,dh;ah=j
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
   mov al,dl;al=i
   mov ah,dh;ah=j
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
   cmp cl,a
   
   je next_et_1
   
   cmp cl,b
   
   jne next_ou_4
   
   next_et_1:
   ;1
   mov al,dl;al=i
   mov ah,dh;ah=j
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
   mov al,dl;al=i
   mov ah,dh;ah=j
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
   
   jne fin_proc_verficasedepart 
   
   next_et_2:
   
   mov al,dl;al=i
   mov ah,dh;ah=j
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
   
   jne fin_proc_verficasedepart ;tous la condition if n'est pas juste
  
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
   
   je fin_proc_verifcaseariver
           
   cmp al,99 ;case d'arriver inexistante
   
   je fin_proc_verifcaseariver        
           
   ;deja fait i=x , j=y

   mov ax,0
   mov al,n
   mov si,offset tableau
   add si,ax
   dec si
   mov cl,[si]
   cmp cl,5
   jne modif_eat_0

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

   jne modif_ea_1

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
   jne modif_ea_1

   next_condt:
   mov al,d  
   mov [si],al   ;affectation pour transformer le pion a une dame.
   jmp modif_ea_1 
   
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
   
   jne skip
   
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
   
   jne skip
   
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
   
   skip:
   
   jmp modif_eat_1
   
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
   jne fin_proc_verifcaseariver

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
   je fin_proc_verifcaseariver 

   ;next condition 
   cmp cl,d 
   
   je fin_proc_verifcaseariver

   ;2eme if:

   cmp cl,a 
   
   je if2_interne_3 
   
   cmp cl,b
   
   jne condition_while

   if2_interne_3:
   
   mov al,nbrcaseadverssaire
   cmp al,0
   jne fin_proc_verifcaseariver

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

 jmp while_arriver

   fin_while_arriver:
   
   mov ax,0
   mov al,l
   cmp al,xx
   jne fin_proc_verifcaseariver
   
   mov al,co
   cmp al,yy
   jne fin_proc_verifcaseariver
   
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
   jne modif_eat_1
   
   jmp modif_ea_1
   
   ;modifier eat=1 (eat=true):
   modif_eat_1:
    
   mov ax,0
   mov al,1
   mov eat,al 
   
   ;return true (ea=1): 
   modif_ea_1:
   
   mov ax,0
   mov al,1
   mov ea,al
   
   jmp fin_proc_verifcaseariver 
   
   modif_eat_0:
   
   mov ax,0
   mov eat,al 
   
   modif_ea_0:
   
   mov ax,0
   mov ea,al
   
   fin_proc_verifcaseariver: 
    
   pop bp 
   ret
verifcaseariver endp 

