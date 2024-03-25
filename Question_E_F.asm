.model small
.stack 100h


.data
n db ? 

saut db 10,13,10,13,"$" 
dames db 50 DUP (1)
espace db "0$"  
space db  " $"
deux db 2

.code
main proc 
    mov ax, @data
    mov ds, ax
    mov cx,0
    
 

mov si,Offset dames 
push si
call init


mov si,Offset saut
push si
mov si,Offset espace
push si
mov si,Offset dames
push si  
mov si,offset space
push si 
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
boucle: 
mov [di],2
mov [si],1
inc si
dec di
loop boucle

mov si,[bp+4]
add si,20
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
    
    boucle1:
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h 
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h
    
    mov ah, 02h       ; Fonction AH=2 pour afficher le caractère
    mov dl,[si]
    add dl,48
    int 21h  
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+8]
    int 21h
     
    inc si 
    loop boucle1
    
    jmp suite
   
    zerofirst:
    
    boucle6: 
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h 
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+8]
    int 21h
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h  
    
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h 
    
    mov ah, 02h       ; Fonction AH=2 pour afficher le caractère
    mov dl,[si]
    add dl,48
    int 21h  
    
    inc si 
    loop boucle6
    
    suite:

    

    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+10]
    int 21h
    pop cx
    loop boucle0

     pop bp
     ret
    affichage endp

end main
