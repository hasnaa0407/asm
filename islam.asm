verifcasedepart proc
; i,j,tour,damier, 
;a.b.c.d andou
mov si,offset tableau 
;
;
;
;
;
; abdouuuuu     

condition_islam:;ta3 else
call numero; i et j deja lue dans le main
;la valeur de n modifier dans la fonction numero 
mov cl,[si+n]
cmp cl,d
jne fin_proc_verficasedepart;condition non verifier

mov dl,i;store i 
mov dh,j;store j

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
mov al,e
inc al
mov e,al


fin_proc_verficasedepart:
ret
verifcasedepart endp 
