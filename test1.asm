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
    
    ;appel a la procedure d'affichage:
    call affichage 
    
    ;affichage du message qui demande d'entrer la ligne et la colonne:
    
    mov ax,0
    mov ah, 09h  ;affichage du message4.
    lea dx, message4
    int 21h 
    
    ;lecture de la ligne:
    mov ax,0
    mov ah, 09h  ;affichage du message2.
    lea dx, message2
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
        
        
    ;lecture de la colonne:    
    mov ah, 09h  ;affichage du message3.
    lea dx, message3
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
    
    call numero
    
    ;affichage du numero obtenu:
    mov ax,0
    mov ah, 09h  
    lea dx, message
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).   
    mov bx,0
    mov bl,n
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
    
    call couleurcase 
    
    cmp couleur,6
    
    jne case_blanche_noir0
    
    mov ax,0
    mov ah, 09h  
    lea dx,casedepartnexistepas 
    int 21h
    jmp suitee
    
    case_blanche_noir0:
    
    cmp couleur,7
    
    jne case_noir0
    
    mov ax,0
    mov ah, 09h  
    lea dx,casedepartblanche 
    int 21h
    jmp suitee
    
    case_noir0:
    
    mov ax,0
    mov ah, 09h  
    lea dx,casenoire 
    int 21h
    
    suitee:
    
    call comparer
    
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


init proc ;ps:ici il faut pusher dans le main l'adresse du debut de TABLEAU    
    
    push bp
    mov bp,sp
    mov si,offset tableau
    mov di,si
    add di,49
    mov cx,20 
    ;une boucle qui le tableau de [1,20] avec des 1 (pion noir), et de [31,50] avec des 2 (pion blanc):
    boucle: 
    mov [di],2
    mov [si],1
    inc si
    dec di
    loop boucle
    ;une boucle pour remplir de [21,30] avec des 5 (case vide):
    mov cx,10
    boucle2:
    mov [si],5 
    inc si
    loop boucle2

pop bp
ret
init endp

affichage proc 
    push bp
    mov bp,sp
    mov si,offset tableau
    mov cx,10 
    
    boucle0:
    mov ax,cx
    push cx
    mov cx,5
    div deux 
    cmp ah,0   
    je zerofirst
    ;une boucle pour afficher les lignes avec un modulo sur deux egal a 1:
    boucle1:
    
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
    loop boucle1
    
    jmp suite
   
    zerofirst:
    
    boucle6: 
    
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
    loop boucle6
    
    suite:

    

    mov ah, 09h       
    lea dx,saut
    int 21h
    pop cx
    loop boucle0

    pop bp
    ret    
    
affichage endp 

numero proc  
    
    mov bp,sp
    mov dx,[bp]
    mov cx,0
     
    mov ax,0
    mov bx,0
    mov al,10      ;verifier le i et le j s'ils sont bien dans l'intervalle [1,10].
    mov bl,1
    mov cl,i
    cmp cl,al
    jg existepas
    cmp cl,bl
    jl existepas
    mov cl,j
    cmp cl,al
    jg existepas
    cmp cl,bl
    jl existepas
    
    mov ax,0
    mov al,i
    div deux
    cmp ah,1 
    jne switch
    
    mov ax,0
    mov al,j 
    div deux
    cmp ah,0 
    jne switch 
    
    mov ax,0
    mov al,i 
    mul dix
    mov bx,0
    mov bl,j  
    add al,bl
    sub al,10
    div deux 
    mov n,al 
    
    jmp fin3
    
    switch:
    
    mov ax,0
    mov al,j
    div deux
    cmp ah,1
    jne case_blanche4
    
    mov ax,0
    mov al,i
    div deux
    cmp ah,0
    jne case_blanche4
    
    mov ax,0 
    mov al,i 
    mov bl,j
    mul dix 
    add al,bl
    sub al,9
    div deux 
    mov n,al  
    
    jmp fin3 
    
    existepas: 
    mov ax,99
    mov n,al
    
    jmp fin3 
    
    case_blanche4:
    mov ax,0
    mov n,al
    
    fin3: 
    
    mov bp,dx
    push dx
    ret
numero endp  

couleurcase proc

    mov bp,sp
    mov dx,[bp]
     
    mov ax,0
    mov al,n
    
    cmp ax,99 
    
    jne case_noire_blanche
    
    mov bx,0
    mov bl,6
    mov couleur,bl
    jmp fin5
    
    case_noire_blanche:
    
    cmp ax,0
    
    jne case_noire 
       
    mov bx,0
    mov bl,7
    mov couleur,bl
    jmp fin5 
    
    case_noire:
    
    mov bx,0
    mov bl,8
    mov couleur,bl

    fin5: 
    
    
    mov bp,dx
    ret
couleurcase endp 

comparer proc 
    
   mov bp,sp
   mov bx,[bp]
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
   
   mov bp,bx
   push bx
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
    
   jne case_blanche_noire_20
   
   mov ax,0
   mov ah,09h  ;affichage du message.
   lea dx,casedepartnexistepas
   int 21h 
   
   jmp fin_proc_verficasedepart 
   
   case_blanche_noire_20:
   
   cmp ax,7
   
   jne case_noire_20
   
   mov ax,0
   mov ah,09h  ;affichage du message.
   lea dx,casedepartblanche
   int 21h 
   
   jmp fin_proc_verficasedepart
   
   case_noire_20: 
   
   ;verifier tour et initialiser a,b,c,d:
   mov ax,0
   mov al,tour
   cmp al,1
   jne switching
   
   mov bx,0
   mov bl,2
   mov a,bl 
   mov bl,4
   mov b,bl
   mov bl,1
   mov c,bl
   mov bl,3
   mov d,bl 
   
   jmp suite_10
   
   switching: 
   
   mov bx,0
   mov bl,1
   mov a,bl 
   mov bl,3
   mov b,bl
   mov bl,2
   mov c,bl
   mov bl,4
   mov d,bl
   
   suite_10:
   
   mov ax,0
   mov al,[si+n] 
   cmp al,c
   je suite_11
   cmp al,d
   jne fin_proc_verficasedepart
   
   suite_11:
   
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
   add bl,tour 
   mov j,bl
   
   call numero
   
   mov cx,0
   mov cl,[si+n]
   cmp cl,5
   
   je next_and_1  
   
   mov al,dl
   add al,tour
   mov i,al 
   
   mov bl,dh
   sub bl,tour
   mov j,bl
   
   call numero
   
   mov cx,0
   mov cl,[si+n]
   cmp cl,5
    
   je next_and_1
    
   cmp cl,a
   
   je next_and_1
   
   cmp cl,b
   
   je next_and_1
   
   jmp condition_islam
    
   next_and_1: 
   
   mov al,dl
   add al,tour
   add al,tour
   mov i,al 
   
   mov bl,dh
   sub bl,2
   mov j,bl
   
   call numero 
   
   mov cx,0
   mov cl,[si+n]
   cmp cl,5 
   
   je next_and_2
    
   mov al,dl
   add al,tour
   mov i,al 
   
   mov bl,dh
   add bl,1
   mov j,bl
   
   call numero 
   
   mov cx,0
   mov cl,[si+n]
   cmp cl,a
   
   je next_and_2 
   
   cmp cl,b  
   
   je next_and_2
   
   jmp condition_islam
   
   next_and_2:
    
   mov al,dl
   add al,tour 
   add al,tour
   mov i,al 
   
   mov bl,dh
   add bl,2
   mov j,bl
   
   call numero 
   
   mov cx,0
   mov cl,[si+n]
   cmp cl,5
    
   je modif_e_1 
   
   condition_islam:
   
   mov i,dl
   mov j,dh
   
   call numero; i et j deja lue dans le main
   ;la valeur de n modifier dans la fonction numero 
   mov cl,[si+n]
   cmp cl,d
   jne fin_proc_verficasedepart;condition non verifier
    
    ;1
    mov al,dl
    mov ah,dh
    sub al,tour
    inc ah
    mov i,al
    mov j,ah
    call numero 
    mov cl,[si+n]
    cmp cl,5
    je next_et1
    
    ;vrifier next ||
    ;2
    mov al,dl;al=i
    mov ah,dh;ah=j
    sub al,tour
    dec ah
    mov i,al
    mov j,ah
    call numero 
    mov cl,[si+n]
    cmp cl,5
    je next_et1
     
    ;vrifier next || 
    ;3
    mov al,dl;al=i
    mov ah,dh;ah=j
    sub al,tour
    dec ah
    mov i,al
    mov j,ah
    call numero 
    mov cl,[si+n]
    cmp cl,b
    jne fin_proc_verficasedepart
    
    ;dernier || vrai
    
    next_et1:
    ;1
    mov al,dl;al=i
    mov ah,dh;ah=j
    sub al,tour
    sub al,tour
    sub ah,2
    mov i,al
    mov j,ah
    call numero 
    mov cl,[si+n]
    cmp cl,5
    je next_et2 
    
    ;2
    mov al,dl;al=i
    mov ah,dh;ah=j
    sub al,tour
    inc ah
    mov i,al
    mov j,ah
    call numero 
    mov cl,[si+n]
    cmp cl,a
    je next_et2 
    
    ;3
    mov al,dl;al=i
    mov ah,dh;ah=j
    sub al,tour
    inc ah
    mov i,al
    mov j,ah
    call numero 
    mov cl,[si+n]
    cmp cl,b
    jne fin_proc_verficasedepart  
    
    ;dernier || vrai
     
    next_et2:
    mov al,dl;al=i
    mov ah,dh;ah=j
    sub al,tour
    sub al,tour
    add ah,2
    mov i,al
    mov j,ah
    call numero 
    mov cl,[si+n]
    cmp cl,5
    jne fin_proc_verficasedepart:;tous la condition if n'est pas juste 
    
    modif_e_1:
   
    mov bx,0
    mov bl,1
    mov e,bl
   
    fin_proc_verficasedepart:
     
    pop bp 
    ret
verifcasedepart endp
