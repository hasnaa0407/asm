.model small
.stack 100h

.data
n db ?  
i db ?
j db ?
message db "N=$" 
message2 db 10,13,"C=$"
message3 db 10,13,"L=$" 
message4 db 10,13,"maintement faite entrez la ligne et la colonne et je te donne le contenu s'il exist:$"
message5 db 10,13,"L=$"
message6 db 10,13,"C=$" 
message7 db 10,13,"N=$"
 
dix db 10
deux db 2

.code
main proc

    mov ax, @data
    mov ds, ax
    mov cx,0
   
    ; Afficher un message pour demander a l'utilisateur d'entrer un entier.
    mov ah, 09h
    lea dx, message
    int 21h      
    
    ; Lire l'entier a partir du clavier
    mov ah, 01h ; fonction de lecture.
    int 21h
    sub al, 30h ; convertir le caractère ASCII en nombre.
     
    mov  ah,0
    mul dix 
    mov bl,al
    mov ah, 01h ; fonction de lecture.
    int 21h
    sub al, 30h ; convertir le caractère ASCII en nombre.
    add bl,al
    mov n, bl   ; stocker le nombre dans la variable n.
    mov bh ,0
    mov bl,n
    push bx 
    
    
    
    call colonne         
    pop bx



       

    mov ah, 09h  ;affichage du message2.
    lea dx, message2
    int 21h
     
     
     
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).
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

 
     
    mov bx,0
    mov bl,n
    push bx
    call ligne         
    pop bx
    
    mov ax,0
    mov ah, 09h ;affichage du message3.
    lea dx, message3
    int 21h
      
    
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).
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
    mov ah, 09h  ;affichage du message4.
    lea dx, message4
    int 21h
     mov ax,0
    mov ah, 09h  ;affichage du message5.
    lea dx, message5
    int 21h
 
      
    ; Lire l'entier a partir du clavier
    mov ah, 01h ; fonction de lecture.
    int 21h
    sub al, 30h ; convertir le caractère ASCII en nombre.
     
    mov  ah,0
    mul dix 
    mov bl,al
    mov ah, 01h ; fonction de lecture.
    int 21h
    sub al, 30h ; convertir le caractère ASCII en nombre.
    add bl,al
    mov i, bl   ; stocker le nombre dans la variable n.
    mov bh ,0
    mov bl,i
    push bx
        
        
        
       mov ah, 09h  ;affichage du message6.
    lea dx, message6
    int 21h
    
    ; Lire l'entier a partir du clavier
    mov ah, 01h ; fonction de lecture.
    int 21h
    sub al, 30h ; convertir le caractère ASCII en nombre.
     
    mov  ah,0
    mul dix 
    mov bl,al
    mov ah, 01h ; fonction de lecture.
    int 21h
    sub al, 30h ; convertir le caractère ASCII en nombre.
    add bl,al
    mov j, bl   ; stocker le nombre dans la variable n.
    mov bh ,0
    mov bl,j     
    push bx    
    
    call numero
     pop bx
    
     mov ax,0
    mov ah, 09h  ;affichage du message4.
    lea dx, message7
    int 21h         
  
    mov ax,0     ;injection dans la pile pour pouvoir affiche deux digits(chiffres).
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
            
    
              
    mov ah, 4ch  ;la coupure de l'interruption 21H.
    int 21h
   
   
main endp

ligne proc 

 
    mov bp,sp
     mov dx,[bp]
    mov cl,[bp+2] 

    mov al,50
    mov bl,1

    cmp cl,al
    jg outt
    cmp cl,bl
    jl outt

    mov bx,5
    mov ax,cx
    div bl
    cmp ah,0
    je restezero
    add al,1
    mov ah,0 
    push ax
    jmp fin:

    restezero:
    push ax
    jmp fin:
    outt: 
    mov al,0
    push ax

    fin:
    mov bp,dx
    push dx
    ret 
ligne endp
              
colonne proc 

 
    mov bp,sp
    mov dx,[bp]
    mov cl,[bp+2] 

    mov al,50
    mov bl,1

    cmp cl,al
    jg outt2
    cmp cl,bl
    jl outt2

    mov bx,10
    mov ax,cx
    div bl
    cmp ah,0
    je restezero2
    cmp ah,5
    jg sup 
    mov al,ah
    mov ah,0  
    mul deux  
    push ax
    jmp fin2:                                       
    sup:                                              
    mov al,ah
    mov ah,0
    sub al,5  
    mul deux
    sub al,1
    push ax
    jmp fin2:
    restezero2:
    mov al,9
    push ax
    jmp fin2:
    outt2: 
    mov al,0
    push ax

    fin2:
    mov bp,dx
    push dx
    ret 
colonne endp

numero proc
    mov bp,sp
    mov dx,[bp]
    mov cx,0
     

    mov al,10      ;verifier le i et le j s'ils sont bien dans l'intervalle [1,10].
    mov bl,1
    mov cl,[bp+4]
    cmp cl,al
    jg outt3
    cmp cl,bl
    jl outt3
    mov cl,[bp+2]
    cmp cl,al
    jg outt3
    cmp cl,bl
    jl outt3 
    
    mov ax,0
    mov al,[bp+4]
    div deux
    cmp ah,1 
    jne switch
    
    mov ax,0
    mov al,[bp+2] 
    div deux
    cmp ah,0 
    jne switch 
    
    mov ax,0
    mov al,[bp+4] 
    mul dix
    mov bx,0
    mov bl,[bp+2]  
    add al,bl
    sub al,10
    div deux 
    push ax 
    
    jmp fin3
    
    switch:
    
    mov ax,0
    mov al,[bp+2] 
    div deux
    cmp ah,1
    jne outt3
    
    mov ax,0
    mov al,[bp+4]
    div deux
    cmp ah,0
    jne outt3
    
    mov ax,0 
    mov al,[bp+4] 
    mov bl,[bp+2]
    mul dix 
    add al,bl
    sub al,9
    div deux 
    push ax
    
    outt3: 
    mov ax,0
    push ax
    fin3: 
    mov bp,dx
    push dx
    ret
numero endp

              
              
end main
