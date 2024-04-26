

    name "vga"

org  100h  

.data  


saut db 10,13,"$" 
dames db 50 DUP (1)
espace db "0$"  
space db  " $"
deux db 2
 msg db 10,13,10,13,10,13,10,13,10,13,10,13,10,13,10,13,"    bienvenue a notre jeux de dames",10,13,"             hope you enjoy","$"        
 press db 10,13,10,13,10,13,10,13,10,13,10,13,"        press on S to get started","$"  
 
 viderscreen db "                                        $"  
 
 rappel db 10,13, "                 voici un petit rappel",10,13,10,13,"                    sur les nombres",10,13,10,13,"$"  
 joueur db 10,13,"joueur : $"
  numerodujoueur  db 1                                                                        
.code
start:
main proc

; dimensions of the rectangle:
; width: 10 pixels
; height: 5 pixels
w equ 319
h equ 100                                                                  
             

; set video mode 13h - 320x200


    mov ax, 13h
    int 10h

       
        lea dx,msg  
         mov ah,09h
        int 21h   
                  
    
           
           
; draw upper line:

    mov cx, w  ; column
    mov dx, 50     ; row
    mov al, 15     ; white
u1: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 1
    jae u1
 
; draw bottom line:

    mov cx, w  ; column
    mov dx, 50+h   ; row
    mov al, 15     ; white
u2: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 1
    ja u2
 
; draw left line:


 
    lea dx,press  
         mov ah,09h
        int 21h   
        
; pause the screen for dos compatibility:

;wait for keypress
  mov ah,00
  int 16h
  
  cmp al,"s"
  jne theend 
 
  
         
    mov si,Offset dames 
    push si
    call init
     
     mov si,offset joueur
    push si        
    mov ah,0
    mov al,numerodujoueur
    mov si, ax 
    push si
    mov si,offset rappel 
    push si
    mov si,Offset saut
    push si
    mov si,Offset espace
    push si
    mov si,Offset dames
    push si  
    mov si,offset space
    push si 
    mov si,offset viderscreen                
    push si
    call untour         
              
           

; return to text mode:

theend:
 
       
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
    
     mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+14]
    int 21h 
    
    mov ah, 02h       ; Fonction AH=2 pour afficher le caractère
    mov al,[bp+12] 
    add al,48
    int 21h 
    
     mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+10]
    int 21h 
              
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+10]
    int 21h
              
    mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+10]
    int 21h  
    
    boucle0: 
    
     mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h 
    
     mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    mov dx,[bp+4]
    int 21h 
    
    mov ax,cx
    push cx
    mov cx,5
    div deux 
    cmp ah,0   
    jne zerofirst
    
    boucle1:
    
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h 
    
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h
    
    mov ah, 02h       ; Fonction AH=2 pour afficher le caractère
    mov dl,[si]
    cmp dl,1
    jne vide_ou_blanc
    mov dl,4
    int 21h
    jmp fin 
    
    vide_ou_blanc:
    cmp dl,5
    jne blanc
    mov dl,176
    int 21h
    jmp fin
    
    blanc:
    mov dl,3
    int 21h   
    
    fin:
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h
    
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h
    
    mov ah, 02h       ; Fonction AH=2 pour afficher le caractère
    mov dx,178
    int 21h
     
    inc si 
    loop boucle1
    
    jmp suite
   
    zerofirst:
    
    boucle6: 
    
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h 
    
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h
    
    mov ah, 02h       ; Fonction AH=2 pour afficher le caractère
    mov dx,178
    int 21h
    
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h  
    
    ;mov ah, 09h       ; Fonction AH=2 pour afficher le caractère
    ;mov dx,[bp+4]
    ;int 21h 
    
    mov ah, 02h       ; Fonction AH=2 pour afficher le caractère
    mov dl,[si]
    ;
    cmp dl,1
    jne vide_ou_blanc1
    mov dl,4
    int 21h
    jmp fin1 
    
    vide_ou_blanc1:
    cmp dl,5
    jne blanc1
    mov dl,176
    int 21h
    jmp fin1
    
    blanc1:
    mov dl,3
    int 21h
    
    fin1:
    
      
    
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

    
    affichagerappel proc
     push bp
     mov bp,sp
     
       mov ah,09h
     mov dx,[bp+8]       ;;kteb le big espace
     int 21h
     
     mov cx,10
     mov si,1 
     
     lignes:
     push cx
     mov cx,17
 
     printbigespace:
      mov ah,09h
     mov dx,[bp+4]       ;;kteb le big espace
     int 21h
     loop printbigespace
     pop cx  
      
     mov ax,cx
     mov bx,2
     div bl
     cmp ah,0
     je commenceparnb
       
     push cx                           ;;douq ndir bsh ykteb le reste des num binethm espace ken nl9a kifh ndirhm en clr khir
     mov cx,5
     colonne:                                  ;hna kifkif ybda ligne commence par un vide wla 
     mov dx,[bp+4]         
     mov ah,09h
     int 21h
     mov dx,[bp+4]         
     mov ah,09h
     int 21h
     
     mov ax,si
     mov bx,10
     div bl
     mov bx,ax         ;nbda b al le quotient 
     
     mov ah, 02h
     add bl,48
     mov dl, bl    
     int 21h
     mov ah, 02h 
     add bh,48
     mov dl, bh    
     int 21h    
      
      inc si 
     loop colonne   
     
     pop cx 
     jmp fin2 
     
     
     commenceparnb: 
      
     push cx                           ;;douq ndir bsh ykteb le reste des num binethm espace ken nl9a kifh ndirhm en clr khir
     mov cx,5
     colonne2:                                  ;hna kifkif ybda ligne commence par un vide wla 
    
     
     mov ax,si
     mov bx,10
     div bl
     mov bx,ax         ;nbda b al le quotient 
     
     mov ah, 02h      
     add bl,48
     mov dl, bl   
     int 21h
     mov ah, 02h  
     add bh,48
     mov dl, bh    
     int 21h    
      mov dx,[bp+4]         
     mov ah,09h
     int 21h 
     mov dx,[bp+4]         
     mov ah,09h
     int 21h
     
     inc si  
     loop colonne2
      pop cx
       
     fin2:
     mov ah,09h
     mov dx,[bp+6]
     int 21h  
     
      ;;;saut de ligne       
           
     loop lignes
     
     pop bp
     ret
    affichagerappel endp  
    
    
    
    
    
    untour proc  ;;cette fonction permet d afficher l etatat actuelle du jeux de dames et des press qu il faut faire 
        ;; comme paramettre elle aura besoin du numero du joueur comme entier
        push bp
        mov bp,sp 
         
        push [bp+4]              ;bp+4==viderscreen 
        call nettoiescrean   
        pop si
        
        push [bp+14]             
        push [bp+12]            
        push [bp+6]            
        call affichagerappel   
        pop si
        pop si 
        pop si 
        
        
          mov ah, 02h     ; Déplacer le curseur à la position de départ
         mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov dh, 0       ; Ligne 0
         mov dl, 0       ; Colonne 0
         int 10h      
         
        push [bp+18]
        push [bp+16]
        mov si,[bp+12]
        push si
        mov si,[bp+10]
        push si
        mov si,[bp+8]
        push si  
        mov si,[bp+6]
        push si 
        call affichage
        
        
        
        
        pop bp
        ret
        
    untour endp  
    
    
    
    nettoiescrean proc
        push bp
        mov bp,sp    
    mov ah, 02h     ; Déplacer le curseur à la position de départ
    mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov dh, 0       ; Ligne 0
    mov dl, 0       ; Colonne 0
    int 10h      
    
    mov dx,[bp+4]  
    mov cx,24
    
    vider:
    mov ah,09h
    int 21h
    loop vider   
    
       mov ah, 02h     ; Déplacer le curseur à la position de départ
    mov bh, 0       ; Page numéro 0                                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov dh, 0       ; Ligne 0
    mov dl, 0       ; Colonne 0
    int 10h 
         
        
       pop bp  
       ret
    nettoiescrean endp
    
