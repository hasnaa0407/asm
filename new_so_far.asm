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
tour db ?
adresse db ?

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
 
dix db 10
deux db 2

.code  

main proc
     
    mov ax, @data
    mov ds, ax
    mov cx,0
     
    ;appel a la procedure d'inisialisation:
    call init
    
    mov ax,0 
    mov e,al
    mov al,1 
    mov tour,al
    
    repeat:
    ;lecture du message qui demande le i et le j:    
    mov ah, 09h  ;affichage du message5.
    lea dx, message5
    int 21h  
    
    ;lecture de la ligne:
    mov ax,0
    mov ah, 09h  ;affichage du message2.
    lea dx, message7
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
    ; stocker la ligne dans la variable i:
    mov i, bl   
    mov bh ,0
    mov bl,i
    push bx
        
        
    ;lecture de la colonne:    
    mov ah, 09h  ;affichage du message3.
    lea dx, message8
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
    
    mov ah, 02h 
    mov dl,e
    add dl, 30h ; convertir le nombre en caractere ASCII
    int 21h
    
    mov ax,0
    mov al,e
    cmp al,0
    je repeat

    mov ah, 4ch
    int 21h
    
main endp


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
   
   jmp fin_proc_verficasedepart 
   
   case_depart_blanche_noire:
   
   cmp ax,7
   
   jne case_depart_noire
   
   mov ax,0
   mov ah,09h  ;affichage du message.
   lea dx,casedepartblanche
   int 21h 
   
   jmp fin_proc_verficasedepart
   
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
   mov dl,i
   mov dh,j
   
   mov bl,x
   mov bh,y
   mov i,bl;i=x
   mov j,bh;j=y 
   call numero 
   mov ax,0
   mov al,n
   cmp al,0  ;case d'arriver blanche  
   
   je fin_proc_verifcasearivee
           
   cmp al,99 ;case d'arriver inexistante
   
   je fin_proc_verifcasearivee        
           
   ;deja fait i=x , j=y

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

   mov al,i
   add al,tour
   cmp al,x
   jne if2_arriver
   mov al,j
   add al,avancer
   cmp al,y
   jne if2_arriver  
   
   ;verifwithchanges dans le main  

   mov al,1
   cmp verifwithchanges,al

   jne modif_ea_1

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
   mov [si],d   ;affectation
   jmp modif_ea_1 
   
   if2_arriver:
   
   mov ax,0
   mov al,dl ;al=i
   add al,tour
   add al,tour
   
   cmp al,x
   
   jne if3_arriver
   
   mov ax,0
   mov al,dh ;al=j
   add al,avancer 
   add al,avancer 
   
   cmp al,y
   
   jne if3_arriver
   
   mov ax,0
   mov al,dl ;al=i
   add al,tour
   mov i,al
   
   mov bx,0
   mov bl,dh ;bl=j
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
   
   mov i,dl
   mov j,dh
   
   call numero 
   
   mov si,offset tableau
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov bx,0 
   mov bl,[si];recupirer offset damier[numerocase(i,j)]
              ;stocker le contenu de la case de depart dans bl
   
   mov [si],5 ;rendre la case de depart vide
   
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
   dec si     ;recupirer offset damier[numerocase(x, y)]
   mov [si],bl;mettre le changement dans la case d'arriver
   
   mov ax,0
   mov al,dl  ;al=i
   add al,tour
   mov i,al
   
   mov ah,dh  ;ah=j
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
   mov al,x
   
   cmp al,10
   
   je dame
   
   cmp al,1
   
   jne skip
   
   dame:
   
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
   mov [si],d
   
   skip:
   
   jmp modif_eat_1
   
   if3_arriver:
   
   mov i,dl
   mov j,dh
   
   call numero

   mov si,offset tableau 
   mov ax,0
   mov al,n
   add si,ax
   dec si
   mov cl,[si]
   cmp cl,d
   jne fin_proc_verifcasearrivee

   ;int avanceligne=-1
   mov al,i
   cmp i,x
   jge moins
   mov al,1
   mov avanceligne,al

   moins: 
   mov ax,0
   mov al,1
   sub al,2
   mov avanceligne,al
   
   ;int nbrcaseadverssaire =0
   mov ax,0
   mov nbrcaseadverssaire,al 
   ;int l= i+avanceligne;
   mov al,i
   add al,avanceligne
   mov l,al
   ;int co=j+avancer 
   mov al,j
   add al,avancer 
   mov co,al
   ;int all=0
   mov ax,0
   mov all,al       
   ;int ac=0
   mov ac,al

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
    
   mov ax,0
   mov al,1
   mov eat,al 
    
    
   modif_ea_1:
   
   mov ax,0
   mov al,1
   mov ea,al
   
   fin_proc_verifcasearivee: 
    
   pop bp 
   ret
verifcaseariver endp
