.model small
.stack 100h


.data  

saut db 10,13,"$" 
tableau db 50 DUP (1)
caseblanche db "0$"  
space db  " $"
deux db 2

.code  

main proc
     
    mov ax, @data
    mov ds, ax
    mov cx,0
    
 
    ;le push du tableau:
    mov si,Offset tableau 
    push si 
    ;appel a la procedure d'inisialisation:
    call init

    mov si,Offset tableau
    mov [si],3 
    mov [si+1],4
    mov [si+9],5
    mov [si+18],4
    mov [si+44],3
    mov [si+25],3
    mov [si+32],4  
    mov [si+38],5
    
    
    
    mov si,Offset saut
    push si
    mov si,Offset caseblanche
    push si
    mov si,Offset tableau
    push si  
    mov si,offset space
    push si 
    ;appel a la procedure d'affichage:
    call affichage

    mov ah, 4ch
    int 21h
    
main endp


init proc ;ps:ici il faut pusher dans le main l'adresse du debut de TABLEAU    
    
    push bp
    mov bp,sp
    mov si,[bp+4]
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
    mov si,[bp+6]
    mov cx,10 
    
    boucle0:
    mov ax,cx
    push cx
    mov cx,5
    div deux 
    cmp ah,0   
    jne zerofirst
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
    mov dx,[bp+10]
    int 21h
    pop cx
    loop boucle0

    pop bp
    ret    
    
    affichage endp

end main
