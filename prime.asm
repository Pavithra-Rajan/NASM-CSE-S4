section .data
	msg1: db 'Enter the element to check '
	l1: equ $-msg1
	
	msg4: db 'Enter the element: '
	l4: equ $-msg4
	msg: db 'none of the numbers',0Ah
	l: equ $-msg
	space: db ' '
	le: equ $-space
	
	msg3: db 'Not prime '
	l3: equ $-msg3
	msg5: db 'Prime '
	l5: equ $-msg5

section .bss
	a: resw 1
	b: resw 1
	size1: resw 1
	size2: resw 1
	ele: resw 1
	array: resw 100
	
	num: resw 1
        check: resw 1
	flg: resw 1
	nod: resw 1
	num2: resw 1

dig: resw 1


section .text
	global _start:
	_start:
	mov word[flg],0
	mov word[nod],0
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

	
        
        call read_num
        mov ax,word[num]
	mov word[size1],ax
	mov word[size2],ax
	mov word[check],0
	cmp ax,2
	je else

	dec word[size2]
	
	
	loop1:
	
        mov dx,0
	mov ax,word[size1]
	mov bx,word[size2]
	div bx
	cmp dx,0
	je else1
        
        
        dec word[size2]
        mov ax,word[size2]
        cmp ax,2
        jne loop1
        
        ;pusha
        else1:
        mov eax,4
	mov ebx,1
	mov ecx,msg5
	mov edx,l5
	int 80h
	;popa
	jmp exit
       
       else:
       pusha
       mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,l3
	int 80h
	popa
	
		
         
    
	    exit:
	mov eax,1
	mov ebx,0
	int 80h




	read_num:

		pusha
		mov word[num],0
		loop2:


			

			mov eax,3
			mov ebx,0
			mov ecx,dig
			mov edx,1
			int 80h
		     
			cmp byte[dig],10  ;10 ASCII for new line
			je end_loop
			sub word[dig],30h
			
			mov ax,word[num]
			mov bl,10
			mul bl
			add ax,word[dig]
			mov word[num],ax
			jmp loop2

	end_loop: 
		popa
		ret

print_num:
	pusha
	loop3:
	cmp word[num], 0
	je print_no
	inc word[nod]
	mov dx, 0
	mov ax, word[num]
	mov bx, 10
	div bx
	push dx
	mov word[num], ax
	jmp loop3

	print_no:
	cmp word[nod], 0
	je end_print
	dec word[nod]
	pop dx
	mov word[dig], dx
	add word[dig], 30h
	mov eax,4
	mov ebx,1
	mov ecx,dig
	mov edx,1
	int 80h
	jmp print_no
	
	end_print:
		popa
		ret
