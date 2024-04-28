.model small
.stack 100h

.data

    seed dw 0  
    random db ?      

.code
start:
    mov ax, @data
    mov ds, ax      

    mov ah, 00h     
    int 1Ah         
    mov seed, dx    

 
generate_random_digit:
    mov ax, seed    
    mov dx, 343Dh   
    mul dx         
    add ax, 269Ch   
    mov seed, ax    
    
    xor dx, dx    
    mov cx, 11       
    div cx         
    cmp dl,0
    je generate_random_digit:
    mov random, dl
    mov ah, 4Ch 
    int 21h        

end start
