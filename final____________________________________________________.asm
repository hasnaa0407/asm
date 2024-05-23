

MACRO $PRINTLINEH  
    
            PUSH CX 
            
            MOV AH,02H
            MOV BH, 00H
            MOV DH, 5
            MOV DL, CONT    
            INT 10H  
            
            MOV AL, 0C4H 
   
            MOV BH, 00B
            MOV CX, 003H
            MOV AH, 09H  
            INT 10H   
ENDM    


MACRO $PRINTLINEH2 
    
            PUSH CX 
            
            MOV AH,02H
            MOV BH, 00H
            MOV DH, 20 
            MOV DL, CONT  
            INT 10H  
            MOV AL, 0C4H 
            MOV BH, 00B
            MOV CX, 003H
            MOV AH, 09H  
            INT 10H   
ENDM     



   



.model small
.stack 100h


.data  

saut db 10,13,"$" 
tableau db 50 DUP (1)
space db " $"
  
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
xxx db ?
yyy db ?
nn db ?  
colonne db ?
ligne db ?

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


casenoire db 10,13,"cette case est noire$" 

message20 db 10,13,"cette case n'existe pas$"
blanche20 db 10,13,"case blanche$"
pionnoir db 10,13,"pion noir$"
pionblanc db 10,13,"pion blanc$"
casevide db 10,13,"case vide$" 
damenoire db 10,13,"dame noire$"
dameblanche db 10,13,"dame blanche$"



choixjeu db 10,13, "Combien de joueurs sont precsents ? (1 ou 2) : $"
message_tour db "tour de: $"  
message_adversaire db 10,13, "tour de l'adversaire $"
bienjouee db 10,13,"bien jouer!$"
jeuterminer db 10,13,"le jeu est terminer$"     

                                            
                                             
dix db 10      -
deux db 2

CONT  db 0  
msg db 10,13,10,"                       bienvenue a notre jeux de dames",10,13,"                                hope you enjoy","$"        
press db 10,13,10,13,10,13,10,"                           press on S to get started","$"    
curX db 0
curY db 0
curB db 0  
charpion db 4  
colorblanc db 0xF4    
chardame db 3  
colornoir db 0xF1
color db 0xE1 
charspace db 177
colorrouge db 0xF2
instructionmsg db 10,13,"Instructions :$"      
nbligne db 10            
casedapartmsg  db 10,13,"choisissez une case de depart$"  
casearriveemsg  db 10,13,"choisissez une case d'arrivee$"       
casesucceemsg  db 10,13,"case choisie avec succee $"     
num db 0 
by db "USTHB-BY:$" 
nettoiespace db "                                                                        " ,10,13, "                                                                        $",10,13, "                                                                        $"
hasnaa db "BENTOURI HASNAA $"
abdou db "BENAMARA ABDERRAHMANE $"
islem db "AOUDIA NOOR ISLEM $"
yasmine db "BEHIH MAROUA YASMINE $"    
attendezmsg db "attendez svp ... $"
nbpionblanc db "blanc : $"   
nbpionnoir db "noir : $"    
vouspouvezmangeranvu db 10,13,"vous devez manger a nouveau vous avez comme depart:$"            

appuyesS db "tappez S pour sortir a la fin de cette manche",10,13,"$"     
appuyesR db "        R pour une nouvelle partie$"
                                                  
                                       
 
 
.code  

main proc
     
        mov ax, @data
        mov ds, ax
        mov cx,0   
     
        w equ 315
        h equ 99                                                                  
             

 
      
        MOV AH, 06H    
        XOR AL, AL     
        XOR CX, CX     
        MOV DX, 184FH  
        MOV BH, 11111001B    
        INT 10H      
        MOV CONT, 00H    
        MOV CX, 0020D
      
        MOV BL, 17
          
        C1:
            $PRINTLINEH  
            POP CX
            $PRINTLINEH2
            ADD CONT,4     
            POP CX     
        LOOP C1   
        mov ah, 02h     
        mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov dh, 7       ; Ligne 0
        mov dl, 0       ; Colonne 0
        int 10h 
        
         
        lea dx,msg  
        mov ah,09h
        int 21h   

        lea dx,press  
        mov ah,09h
        int 21h   
        
       
        mov ah,00
        int 16h
      
        cmp al,"s"
        jne theend 
  
        call nettoiescrean  
      
        MOV AH, 02H
        MOV DH, 24
        MOV DL, 50
        MOV BH, 00H
        INT 10H
      
   
        mov si, offset by                 ; Charger l'adresse du message dans SI
        mov bl, color 
        call printString 
         mov ah, 09h
        lea dx,saut
        int 21h    
         MOV AH, 02H
        MOV DH, 24
        MOV DL, 50
        MOV BH, 00H
        INT 10H
         mov si, offset hasnaa                 ; Charger l'adresse du message dans SI
        mov bl, color 
        call printString
         mov ah, 09h
        lea dx,saut
        int 21h      
         MOV AH, 02H
        MOV DH, 24
        MOV DL, 50
        MOV BH, 00H
        INT 10H
         mov si, offset abdou                 ; Charger l'adresse du message dans SI
        mov bl, color 
        call printString 
         mov ah, 09h
        lea dx,saut
        int 21h    
         MOV AH, 02H
        MOV DH, 24
        MOV DL, 50
        MOV BH, 00H
        INT 10H
         mov si, offset islem                 ; Charger l'adresse du message dans SI
        mov bl, color 
        call printString
         mov ah, 09h
        lea dx,saut
        int 21h 
         MOV AH, 02H
        MOV DH, 24
        MOV DL, 50
        MOV BH, 00H
        INT 10H
         mov si, offset yasmine                 ; Charger l'adresse du message dans SI
        mov bl, color 
        call printString
        jmp yo
        restart_game: 
        call nettoiescrean  
        mov nombrenoir,20 
        mov nombrenoir,20
        yo:  
        mov ah, 02h     ; Déplacer le curseur à la position de départ
        mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov dh, 0       ; Ligne 0
        mov dl, 0       ; Colonne 0
        int 10h      
    
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
    call init
    call nettoiescrean 
        
    plus_grande_while:  
     
    call affichage
    mov ax, 1
    int 33h 
    mov al,tour
    cmp al,1
    jne tour_advr

    mov al,0
    cmp al,nombreblanc
    je fin_while_plus_grande    
    cmp al,nombrenoir
    je fin_while_plus_grande

  do_while_02:

       mov num,0
      call printinstruction
  
       de:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de   
        call RECUPEREPOS_X  
        call RECUPEREPOS_Y    
   
    
    mov al,curX
    mov i,al
    mov al,curY
    mov j,al 
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
    mov num,2
      call printinstruction
      mov num,3
      call printinstruction

      mov num,1  
      call printinstruction

    
    jmp fin_if1;pour eviter tour_advr car c'est un else{}
    ;GG 
    
    tour_advr:  
    
  
    
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
    
    mov ax,0
    mov al,i
    mov ah,j
    mov ii,al
    mov jj,ah
    
    call verifcasedepart  
    
    mov al,e
    cmp al,1
    
  jne do_while_03   
    mov num,2
  call printinstruction 
  mov num,3
  call printinstruction
   
  mov num,1
  call printinstruction
    
    
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
    
  do_while_04: 
    mov num,0
  call printinstruction   
    
   de1:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de1   
        call RECUPEREPOS_X  
        call RECUPEREPOS_Y    
   
    
    mov al,curX
    mov i,al
    mov al,curY
    mov j,al 
    ;saving les valeurs de i et j initiales:
    mov ax,0
    mov al,i
    mov ii,al
    mov ah,j
    mov jj,ah 
    call verifcasedepart     
    mov al,1
    cmp al,e 
    
  jne do_while_04     
  mov num,2
  call printinstruction
  mov num,3
  call printinstruction

  mov num,1
  call printinstruction
    
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
                         
    mov al,1
    mov verifwithchanges,al
    
    cmp al,tour
    jne else_de_if01 
     de2:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de2   
       call RECUPEREPOS_X  
        call RECUPEREPOS_Y   
   
    
    mov al,curX
    mov x,al
    mov al,curY
    mov y,al 
    ;saving les valeurs de i et j initiales:
    mov ax,0
    mov al,x
    mov xx,al
    mov ah,y
    mov yy,ah    
    mov num,3
    call printinstruction
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
    mov x,al;i=random en plus hadik +1 en regler chiiikh   
    
    call generate_random_digit
    
    mov al,random
    mov j,al;j=random  
    
    mov ax,0
    mov al,x
    mov ah,y
    mov xx,al
    mov yy,ah
    mov num,3
    call printinstruction
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
    
    no_affiche_xy: 
    
    jmp no_else1

    esle_de_if02:  
      mov num,1
  call printinstruction
    
       de3:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de3   
       call RECUPEREPOS_X  
        call RECUPEREPOS_Y   
   
    
    mov al,curX
    mov x,al
    mov al,curY
    mov y,al 
    ;saving les valeurs de i et j initiales:
    mov ax,0
    mov al,x
    mov xx,al
    mov ah,y
    mov yy,ah 
    
    mov num,3
    call printinstruction
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
    
    mov ax,0
    mov verifwithchanges,al
    
    mov al,pion
    cmp al,1  
    
    jne sauter_dame
     
    mov al,ii  ;al=i
    add al,tour
    add al,tour
    mov x,al   ;x=i+2*tour
    
    mov al,jj  ;al=j
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
    
    mov al,jj  ;al=j
    sub al,2
    mov y,al   ;y=j-2
    mov yy,al
    
    call verifcaseariver 
    
    mov ax,0
    mov al,ea
    cmp al,1
    
    jne modif_eat_main ;(eat=0) 
    
    if1_interne_1:
    
    ;printf("vous devez manger a nouveau vous avez comme depart i=%d et j=%d\n", i, j);
    
 
            
   
                
        mov num,5
        call printinstruction   

    
    ;if_interne_1_1 (tour=1):
    
    mov ax,0
    mov al,tour
    cmp al,1
    
    jne if_interne_1_2 ;(robot=true) 
    
  do_while:
    
      de4:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de4   
       call RECUPEREPOS_X  
        call RECUPEREPOS_Y    
   
    
    mov al,curX
    mov x,al
    mov al,curY
    mov y,al 

    
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
    
    mov j,al  
    
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
    
     mov al,1
    mov verifwithchanges,al
    
    cmp al,tour
    jne else_de_if01 
      mov num,1
    call printinstruction
    
     de5:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de5   
      call RECUPEREPOS_X  
        call RECUPEREPOS_Y    
   
    
    mov al,curX
    mov x,al
    mov al,curY
    mov y,al 
    ;saving les valeurs de i et j initiales:
    mov ax,0
    mov al,x
    mov xx,al
    mov ah,y
    mov yy,ah   
     mov num,3
    call printinstruction
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    cmp al,1
    
  jne do_while_tour_adversaire 
  mov num,2
  call printinstruction
    
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
    
    jne skip_partie_dame
    
    mov ax,0
    mov al,xx
    mov xxx,al
    mov ah,yy
    mov yyy,ah
    
    mov ax,0
    mov verifwithchanges,al
    mov trouver,al
    
    mov al,2
    mov nn,al
    
  while_interne_1:
    
    mov al,trouver
    cmp al,0 
    
    jne fin_while_interne_1
    
    mov al,xxx
    add al,nn
    cmp al,10
    
    jg fin_while_interne_1
    
    cmp al,0
    
    jle fin_while_interne_1 
    
    mov al,yyy
    add al,nn
    cmp al,10
    
    jg fin_while_interne_1
    
    cmp al,0
    
    jle fin_while_interne_1 
    
    mov ax,0
    mov al,xxx
    mov ii,al ;i=x
    mov ah,yyy
    mov jj,ah ;j=y
    
    mov ax,0
    mov al,xxx 
    add al,nn 
    mov xx,al  ;x=x+n
    mov ah,yyy
    add ah,nn
    mov yy,ah  ;y=y+n
    
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
    
    mov al,xxx
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_2
    
    cmp al,0
    
    jle fin_while_interne_2 
    
    mov al,yyy
    sub al,nn
    cmp al,10
    
    jg fin_while_interne_2
    
    cmp al,0
    
    jle fin_while_interne_2 
    
    mov ax,0
    mov al,xxx
    mov ii,al ;i=x
    mov ah,yyy
    mov jj,ah ;j=y
    
    mov ax,0
    mov al,xxx 
    sub al,nn 
    mov xx,al  ;x=x-n
    mov ah,yyy
    sub ah,nn
    mov yy,ah  ;y=y-n
    
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
    
    mov al,xxx
    add al,nn ;al=x+n
    cmp al,10
    
    jg fin_while_interne_3
    
    cmp al,0
    
    jle fin_while_interne_3 
    
    mov al,yyy
    sub al,nn ;al=y-n
    cmp al,10
    
    jg fin_while_interne_3
    
    cmp al,0
    
    jle fin_while_interne_3 
    
    mov ax,0
    mov al,xxx
    mov ii,al ;i=x
    mov ah,yyy
    mov jj,ah ;j=y
    
    mov ax,0
    mov al,xxx 
    add al,nn 
    mov xx,al  ;x=x+n
    mov ah,yyy
    sub ah,nn
    mov yy,ah  ;y=y-n  
     
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
    
    mov al,xxx
    sub al,nn ;al=x-n
    cmp al,10
    
    jg fin_while_interne_4
    
    cmp al,0
    
    jle fin_while_interne_4 
    
    mov al,yyy
    add al,nn ;al=y+n
    cmp al,10
    
    jg fin_while_interne_4
    
    cmp al,0
    
    jle fin_while_interne_4 
    
    mov ax,0
    mov al,xxx
    mov ii,al ;i=x
    mov ah,yyy
    mov jj,ah ;j=y
    
    mov ax,0
    mov al,xxx 
    sub al,nn 
    mov xx,al  ;x=x-n
    mov ah,yyy
    add ah,nn
    mov yy,ah  ;y=y+n
    
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
    mov num,5
    call printinstruction   

    
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,yyy
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
    
         de6:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de6   
        call RECUPEREPOS_X  
        call RECUPEREPOS_Y    
   
    
    mov al,curX
    mov x,al
    mov al,curY
    mov y,al 
    mov ax,0
    mov al,x
    mov ah,y
    mov xx,al
    mov yy,ah 
    mov num,3
    call printinstruction
    call verifcaseariver 
    
    mov ax,0
    mov al,eat
    cmp al,1
    
  jne do_while_dame  
    mov num,2
  call printinstruction
  
    jmp skip_robot_adversaire_dame
    
    robot_adversaire_dame:
     
    mov ax,0
    mov al,robot 
    cmp al,1
    
    jne adversaire 
     
    do_while_robot_grande_while_dame:
    
    
    call generate_random_digit; random <- x
    
    mov al,random
    
    mov x,al  
    
    call generate_random_digit
    
    mov al,random  
    
    mov j,al  
    
    mov ax,0
    mov al,x
    mov ah,y
    mov xx,al
    mov yy,ah
    
    call verifcaseariver
    
    mov ax,0
    mov al,eat
    
    cmp al,1
    
    jne do_while_robot_grande_while_dame
    
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
   
    jmp skip_robot_adversaire_dame
    
    adversaire:
    
  do_while_dame_adversaire:
    
        de7:
        
        mov ax, 3
        int 33h  ; pour hedik t3 lcursor     
        cmp bx,1
        jne de7   
      call RECUPEREPOS_X  
        call RECUPEREPOS_Y    
   
    
    mov al,curX
    mov x,al
    mov al,curY
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
                         
    skip_partie_dame:                     
    
    jmp while_grande
    
    fin_while_grande:
    
    mov ax,0
    mov al,casearrivee
    cmp al,0 
    
    je do_while_plus_grande
    
      
    ;printf("bien jouee\n");
    mov num,4
    call printinstruction 
    
 
    
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
     mov ah, 01h           ; Fonction BIOS pour vérifier si une touche a été pressée
    int 0x16
    jz continue_playing   ; Si aucune touche n'est pressée, continuer à jouer
    mov ah, 00h           ; Fonction BIOS pour lire la touche
    int 0x16
    cmp al, 's'           ; Comparer avec 'S'
    je theend      ; Si 'S' est pressé, sortir du programme
    cmp al, 'r'           ; Comparer avec 'R'
    je restart_game       ; Si 'R' est pressé, redémarrer la partie

continue_playing:
    
  jmp plus_grande_while
  
  fin_while_plus_grande: 
    mov ax,0             
    mov ah, 09h  
    lea dx, jeuterminer
    int 21h  
    
    theend:
    
     
    mov ah, 4ch
    int 21h 
    
main endp    

generate_random_digit proc
    pusha  
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
    popa
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




numero proc
    pusha  
    
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
    popa
    ret
numero endp  

couleurcase proc 
    pusha

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
    popa
    ret 
    
couleurcase endp 

comparer proc 
        pusha
    
       push bp
       mov bp,sp
       mov dx,0
       mov dl,n ;n 
       
       cmp dx,99 
       
       jne blanche_autres
       
      
       
       jmp fin20
   
   
   blanche_autres:
   
   cmp dx,0
   
   jne autres
 
   
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
   popa
   ret

comparer endp 

verifcasedepart proc 
   pusha
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

   
   jmp modif_e_0 
   
   case_depart_blanche_noire:
   
   cmp ax,7
   
   jne case_depart_noire
   
   mov ax,0

   
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
   jne fin_proc_verficasedepart  ;condition non verifier
   
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
   popa
   ret
verifcasedepart endp 

verifcaseariver proc  
    
   pusha
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
    
   popa 
   ret
verifcaseariver endp 
 nettoiescrean proc
    pusha  
                
        MOV AH, 06H    
        XOR AL, AL     
        XOR CX, CX     
        MOV DX, 184FH  
        MOV BH, 11110000B    
        INT 10H
        popa   
        ret  
        
nettoiescrean endp          
    

    
    
    
    
   
    affichage proc 
        pusha 
        
        
        
        
   mov ah, 02h     ; Déplacer le curseur à la position de départ
   mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   mov dh, 4
   mov dl,30       ; Ligne 0
   int 10h
  
     mov ah, 09h  
    lea dx,appuyesS
    int 21h     
    
    
      mov ah, 02h     ; Déplacer le curseur à la position de départ
   mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   mov dh, 5
   mov dl,30       ; Ligne 0
   int 10h
               
    mov ah, 09h  
    lea dx,appuyesR
    int 21h
    
              
       
   mov ah, 02h     ; Déplacer le curseur à la position de départ
   mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   mov dh, 1       ; Ligne 0
   mov dl, 70       ; Colonne 0
   int 10h  
   
        
    mov ah, 09h  
    lea dx, nbpionblanc
    int 21h 
   
           ;printf("\n%d %d \n", nb_blanc, nb_noir);     
    

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
         
   mov ah, 02h     ; Déplacer le curseur à la position de départ
   mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   mov dh, 2       ; Ligne 0
   mov dl, 70       ; Colonne 0
   int 10h  
   
       mov ah, 09h  
    lea dx, nbpionnoir
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


 
    
   
        
        
   mov ah, 02h     ; Déplacer le curseur à la position de départ
   mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   mov dh, 0       ; Ligne 0
   mov dl, 0       ; Colonne 0
   int 10h
 
      mov ah, 09h
    lea dx,saut
    int 21h  
    
    mov ah, 09h
    lea dx,message_tour
    int 21h

    mov dl,tour; le tour change a la fin de la boucle while   
    cmp dl,-1
    je advr
    
    mov dl,49        
    mov ah, 02h        
    int 21h
    jmp finallu 
    advr: 
    mov dl,50        
    mov ah, 02h        
    int 21h 
    finallu:   
    push bp
    mov bp,sp
    mov si,offset tableau
    mov cx,10  
    
      mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset saut
    int 21h 
              
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset saut
    int 21h
              
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset saut
    int 21h  
    
    boucle_affichage_1: 
       mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset space
    int 21h 
    
     mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset space
    int 21h 
    
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
    
   mov dl,charpion
    mov dh,colornoir
    call print
    
    jmp fin   
   
    
    pionblanc_damenoire_dameblanche_vide: 
    
    cmp dl,2
    
    jne damenoire_dameblanche_vide 
    
       mov dl,charpion
    mov dh,colorblanc
    call print
          
    jmp fin
    
    damenoire_dameblanche_vide: 
    
    cmp dl,3
    
    jne dameblanche_vide 
    
     mov dl,chardame
    mov dh,colornoir
    call print
     
    jmp fin
    
    dameblanche_vide:
    
    cmp dl,4
    
    jne vide 
      mov dl,chardame
    mov dh,colorblanc
    call print
          
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
    
    mov dl,charpion
    mov dh,colornoir
    call print 
    jmp fin2
     
    pionblanc_damenoire_dameblanche_vide2: 
    
    cmp dl,2
    
    jne damenoire_dameblanche_vide2 
     mov dl,charpion
    mov dh,colorblanc
    call print
    
    jmp fin2
    
    damenoire_dameblanche_vide2: 
    
    cmp dl,3
    
    jne dameblanche_vide2 
      mov dl,chardame
    mov dh,colornoir
    call print
    
    jmp fin2
    
    dameblanche_vide2:
    
    cmp dl,4
    
    jne vide2 
    
     mov dl,chardame
    mov dh,colorblanc
    call print
    
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
    
    
          
    lea dx,instructionmsg    
    int 21h  
    
    
   
    
 
    pop bp
    popa
    ret    
    
affichage endp 


 
               
 
    
 print proc
    
    pusha   
              ; Appel de l'interruption BIOS 10h
    mov ah, 09h          ; Fonction BIOS pour écrire un caractère et un attribut
    mov al, dl       ; Charger le caractère à afficher dans AL
    mov bl, dh       ; Charger la couleur dans BL
    mov bh, 0x00          ; Page écran (0 pour la plupart des configurations)
    mov cx, 1             ; Nombre de fois à afficher le caractère
    int 10h 
    ; Déplacer le curseur manuellement après le premier caractère  
    mov ah, 03h           ; Fonction BIOS pour lire la position du curseur
    int 10h 
    inc dl                ; Avancer la colonne d'une position
    mov ah, 02h           ; Fonction BIOS pour déplacer le curseur
    mov dh, dh            ; Conserver la ligne actuelle
    int 10h               ; Appel de l'interruption BIOS 10  
    popa  
    ret 
print endp  
 
 

  
RECUPEREPOS_X proc 
    pusha
                  ;on aura les position dans les registres initial   
          mov curX,0
          cmp dx,32
          jb posinvalidex
          cmp dx,112
          ja posinvalidex
           mov ax,32
          recherchepox:  
          inc curX 
          add ax,8   
          cmp dx,ax
          jb endddx
         
          cmp curX,10
          jb recherchepox
          mov dh,curX
          posinvalidex: 
          mov dx,100 ;;ici g mouvee 100 besh verif case depart drly err
          ;;choisissez une autre case car pos invalide       
          endddx: 
          
          popa
           ret
        
          
RECUPEREPOS_X endp  
        
        
        
 RECUPEREPOS_Y proc
    pusha 
                  ;on aura les position dans les registres initial   
          mov curY,0
          cmp cx,16
          jb posinvalidey
          cmp cx,96
          ja posinvalidey
           mov ax,16
          recherchepoy:  
          inc curY 
          add ax,8   
          cmp cx,ax
          jb endddy
         
          cmp curY,10
          jb recherchepoy
          mov dh,curY
          posinvalidey: 
          mov cx,100 ;;ici g mouvee 100 besh verif case depart drly err
          ;;choisissez une autre case car pos invalide       
          endddy: 
          popa
          ret
          
RECUPEREPOS_Y endp   
    
    
    
    
 
 





   lignee proc 

    pusha
    mov bp,sp 
    
    mov al,50 
    mov bl,1  
    mov cl,n

    cmp cl,al 
    
    jg zero_ligne
    
    cmp cl,bl 
    
    jl zero_ligne
    
    ;else:
    mov bl,5
    mov al,n
    div bl
    cmp ah,0  
    
    je restezero
    
    add al,1
    mov ligne,al
        
    jmp fin_proc_ligne

    restezero:
    mov ligne,al 
    
    jmp fin_proc_ligne
    
    zero_ligne:
    
    mov ax,0
    mov ligne,al 
    
    fin_proc_ligne:
    
    popa
    ret 
lignee endp
              
colonnee proc 

   pusha
    mov bp,sp

    mov al,50
    mov bl,1 
    mov cl,n

    cmp cl,al
    
    jg zero_colonne 
    
    cmp cl,bl
    
    jl zero_colonne

    mov bx,10
    mov al,n
    div bl
    cmp ah,0  
    
    je restezero_colonne 
    
    cmp ah,5  
    
    jg sup
     
    mov al,ah
    mov ah,0  
    mul deux  
    mov colonne,al
    
    jmp fin_proc_colonne
                                          
    sup:
                                                  
    mov al,ah
    mov ah,0
    sub al,5  
    mul deux
    sub al,1
    mov colonne,al
    
    jmp fin_proc_colonne
    
    restezero_colonne:
    
    mov al,9
    mov colonne,al 
    
    jmp fin_proc_colonne  
    
    zero_colonne:
     
    mov ax,0
    mov colonne,al 
   
    fin_proc_colonne: 
    
    popa
    ret  
colonnee endp    




                

;              
printinstruction proc      
    
 
    pusha 
    cmp num,3 ;;;; if num=0 choisissez une case de depart      if 2 case choisie avec succee
    je attendez         
           
    MOV DH, 17
    mov cx,5 
  
    nett:    
       MOV AH, 02H
    MOV DL, 0
    MOV BH, 00H
    INT 10H 
    mov ah, 09h
    push dx       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset nettoiespace  
    int 21h   
    pop dx     
    inc dh
    loop nett
           
    
     MOV AH, 02H
    MOV DH, 17
    MOV DL, 0
    MOV BH, 00H
    INT 10H 
    cmp num,0
    jne casearriveem 
  
    mov ah, 09h       ; case depart 0 , 1 casearrivee, 2  casesucceemsg, 3 attendez ,4 vouspouvezmangeranv , 5 bien jouee
    mov dx,offset casedapartmsg
    int 21h 
    jmp finaff  
    casearriveem:
    cmp num,1
    jne casesuccee
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset casearriveemsg  
    int 21h 
    jmp finaff 
    casesuccee:
    cmp num,2
    jne attendez 
  
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset casesucceemsg  
    int 21h 
    jmp finaff
    attendez: 
    cmp num,3
    jne bienjoue
     MOV AH, 02H
    MOV DH, 19
    MOV DL, 0
    MOV BH, 00H
    INT 10H   
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset attendezmsg  
    int 21h 
    jmp finaff
    bienjoue:    
    cmp num,4 
    jne vouspouvezmangeranv
    MOV AH, 02H
    MOV DH, 19
    MOV DL, 0
    MOV BH, 00H
    INT 10H  
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset bienjouee  
    int 21h    
    
    
    
    jmp finaff
      vouspouvezmangeranv: 
     mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,offset vouspouvezmangeranvu  
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

    finaff:   
 
    popa
ret     
printinstruction endp           


;mov si, offset message                 ; Charger l'adresse du message dans SI
;mov bl, color       


printString proc 
pusha
    
    print_loop: 
    lodsb                           ; Charger le prochain caractère dans AL (et incrémenter SI)
    cmp al, '$'                       ; Comparer le caractère avec 0 (fin de chaîne)
    je done                         ; Si le caractère est nul, sortir de la boucle
    mov ah, 09h 
    push cx
    mov cx,1   
    int 10h   
    pop cx 
    mov ah, 03h           ; Fonction BIOS pour lire la position du curseur
    int 10h 
    inc dl                ; Avancer la colonne d'une position
    mov ah, 02h           ; Fonction BIOS pour déplacer le curseur
    mov dh, dh            ; Conserver la ligne actuelle
    int 10h                             ; Appel de l'interruption BIOS 10h
    jmp print_loop  
    done:

popa 
ret
printString endp



