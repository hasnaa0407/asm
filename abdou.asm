verifcasedepart proc 
    
   mov bp,sp
   mov dx,[bp]  
   mov si,offset tableau 
   mov ax,0
   mov e,al
   
   ;appel a numero pour obtenir le numero de la case si elle existe:
   call numero
   call couleurcase
    
   mov ax,0
   mov al,couleur
   cmp ax,6  
    
   jne case_blanche_noire
   
   mov ax,0
   mov ah,09h  ;affichage du message.
   lea dx,casedepartnexistepas
   int 21h 
   
   jmp fin_proc_verficasedepart 
   
   case_blanche_noire:
   
   cmp ax,7
   
   jne case_noire
   
   mov ax,0
   mov ah,09h  ;affichage du message.
   lea dx,casedepartblanche
   int 21h 
   
   jmp fin_proc_verficasedepart
   
   case_noire: 
   
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
   
   
   
   
   
   
   
   
   
   
   
   
   
   modif_e_1:
   
   mov bx,0
   mov bl,1
   mov e,bl
   
   fin_proc_verficasedepart:
    
   mov bp,dx
   push dx
   ret
verifcasedepart endp
