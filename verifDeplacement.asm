.model small
.stack 100h

.data
    ; Variables pour stocker les paramètres de la fonction
    i db ?
    j db ?
    tour db ?
    tableau db 50 dup(?) ; Tableau pour stocker les valeurs du damier
    e db ? ;1->true , 0->false
    

.code
main proc


    mov ah, 4ch
    int 21h
main endp

verifcasedepart proc
     
     mov si,offset tableau
     mov e,0 ;inisialiser par 0 car 3*return false
     
     ;i et j deja scanner dans le main
     
     call numero ;return le n
     
     cmp n,0
     je fin_proc
     
     ;affectation de tour dans le main
     cmp tour,-1
     jne tour_1
     
    ;int n=numerocase(i,j)-1 ;
    ;if( damier[n]==2 || damier[n]==4 ){ // la tu utilise la fonction couleur== blanc
    call numero ;i et j deja lue dans le main
    		
    mov al,[si+n]
    cmp al,2
    je next_condition
    cmp al,4
    jne fin_proc
    
    next_condition:
    mov bl,i 
    dec bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5
    je next_et1
    ;rest 3 condition
    
     ;damier[numerocase(i-1,j-1)-1]==5||-> fait
     ;damier[numerocase(i-1,j-1)-1]==1||
	;damier[numerocase(i-1,j-1)-1]==3
    
    ;1:
     mov bl,i 
    dec bl
    mov i,bl
    mov bl,j
    dec bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5
    je next_et1
    ;2:
    mov bl,i 
    dec bl
    mov i,bl
    mov bl,j
    dec bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,1
    je next_et1
    ;3:
     mov bl,i 
    dec bl
    mov i,bl
    mov bl,j
    dec bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,3
    jne fin_proc
    
    
    next_et1: 
    			
    mov bl,i 
    sub bl,2
    mov i,bl
    mov bl,j
    sub bl,2
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5
    je next_et2
    
    ;rest 2 condition
    ;damier[numerocase(i-1,j+1)-1]==1||
    ;damier[numerocase(i-1,j+1)-1]==3 ; toujour si dans la derniere n'est pas verifier -> tous les precedent n'est pas verifier
    ;1: 
    mov bl,i 
    dec bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,1
    je next_et2
    
     mov bl,i 
    dec bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,1
    jne fin_proc
    
    
    next_et2:;regler
    mov bl,i 
    sub bl,2
    mov i,bl
    mov bl,j
    add bl,2
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5 
    je e_1
    jmp fin_proc
    
    

     
     tour1:
     cmp tour,1
     jne fin_proc
     
     call numero ;i et j deja lue dans le main
    		
    mov al,[si+n]
    cmp al,1
    je next_condition1
    cmp al,3
    jne fin_proc
    
    next_condition1:
    ;damier[numerocase(i+1,j+1)-1]==5||
    ;damier[numerocase(i+1,j-1)-1]==5||
    ;damier[numerocase(i+1,j-1)-1]==2||
    ;damier[numerocase(i+1,j-1)-1]==4)
     
    ;1:
    mov bl,i 
    inc bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5
    je next_et11
    ;2:
    mov bl,i 
    inc bl
    mov i,bl
    mov bl,j
    dec bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5
    je next_et11
    ;3:
    mov bl,i 
    inc bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,2
    je next_et11
    ;4:
    mov bl,i 
    inc bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,2
    jne fin_proc
    
    next_et11:
    ;damier[numerocase(i+2,j-2)-1]==5||
    ;damier[numerocase(i+1,j+1)-1]==2||
    ;damier[numerocase(i+1,j+1)-1]==4)
    ;1:
    mov bl,i 
    add bl,2
    mov i,bl
    mov bl,j
    sub bl,2
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5
    je next_et12
    ;2:
    mov bh,i 
    inc bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,2
    je next_et12
    ;3:
    mov bh,i 
    inc bl
    mov i,bl
    mov bl,j
    inc bl
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,4
    jne fin_proc
    
    next_et12:
    ;damier[numerocase(i+2,j+2)-1]==5
    
    mov bh,i 
    add bl,2
    mov i,bl
    mov bl,j
    add bl,2
    mov j,bl ;les 7 instruction pour ne pas toucher les valeur de i et j
    call numero; nouvelle valeur de n
    mov al,[si+n]
    cmp al,5
    jne fin_proc
     
    e_1: 
    mov e,1 
    fin_proc:
    ret
verifcasedepart endp
