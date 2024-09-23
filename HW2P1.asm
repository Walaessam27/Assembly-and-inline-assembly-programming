org 100h
.model small
.8086


.data
    request db 'PLease Enter 20 characters: $'
    sortedmsg db 'The Sorted list is: $'
    input db 21 
    elist db 21 
    slist db 21   
    
.code
start:
mov ax,@data
mov dx,ax                                 
   
  
   ; mov es:[di],elist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    mov ah, 9
    lea dx, request
    int 21h
   
    ; Read 
    mov ah, 0Ah
    lea dx, input
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    call extracting 
    call sortProc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; print 
    MOV dl, 10
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
     
    mov ah, 9
    lea dx, sortedmsg
    int 21h

    mov ah, 9
    lea dx, slist
    int 21h
    
    ; Exit
    mov ah, 4Ch
    int 21h
      
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
extracting: 
push bx  
mov bx,0
    lea si, input
    ;lea di,elist 
    mov bx,1000h
    mov es,bx  
    mov di,2000h 
    mov dx,0 
    mov dl,elist
    mov dx,es:[di]
   
    xor cx, cx  ; Clearing

    extract:
        mov al, [si] 
        cmp bl, 20 
        je edone   
         inc bl

       
        cmp al, '0'
        jb notd
        cmp al, '9'
        jbe isd

        cmp al, 'A'
        jb notlu
        cmp al, 'Z'
        jbe isl

        cmp al, 'a'
        jb notll
        cmp al, 'z'
        jbe isl

        
        jmp notdorl

    isd:
       
        mov [di], al
        inc di
        inc cx
        jmp nechar

    isl:
       
        mov [di], al
        inc di
        inc cx
        jmp nechar

    notdorl:
       
        jmp nechar

    notd:
        
        jmp nechar

    notlu:
        
        jmp nechar

    notll:
   
        jmp nechar

    nechar:
        inc si  
        jmp extract

    edone:
        
    ;mov byte [di], 0   
    pop bx 
     
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sortProc proc

    lea si, elist
   ; lea di, slist

    copy:
        mov al, [si]
        cmp al, 0 
       mov cx,0
        je codone  
        jcxz codone
        
        mov [di], al
        inc di
        inc si  
        dec cx
        jmp copy

    codone:
        
        mov byte [di], 0    
        mov cx, 20

    loop1:
        jcxz sdone 
        lea di, slist 

    loop2:
        mov al, [di]
        mov bl, [di + 1]
        cmp al, bl
        jbe nothing

        ; Swaping
        mov [di], bl
        mov [di + 1], al

    nothing:
        inc di 
        dec cx 
        jcxz loop1
        loop loop2

    sdone:
        ret
sortProc ENDP
