section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	msg2: db 'Length of largest repeated block : '
	l2: equ $-msg2
	
	
	el: db 0Ah
        le: equ $-el

	space: db ' '
        sl: equ $-space

section .bss
	string: resb 100
	stringlength: resb 1
	char: resb 1
	
	string2: resb 1
	temp: resb 1
	max_len: resb 1
	word_len: resb 1
	min_len:resb 1
	num: resb 1
	dig: resb 1
	nod: resb 1
section .data
	global _start:
	_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

        mov edi,string
	call read_string                 

	mov al,1
	mov byte[num],al
	mov byte[max_len],al
	
	cld
	
	mov esi,string
	
	repeated_str:
	lodsb
	mov byte[temp],al
	loop:
	
		lodsb
	
		cmp al,byte[temp]
		je rep_block
		mov byte[temp],al
		mov cl,byte[max_len]
		cmp byte[num],cl
		ja update_max
		cmp al,0
		je print_final
		jmp loop
		
		
		
		
	rep_block:
	inc byte[num]
	jmp loop
	
	update_max:
	mov cl,byte[num]
	mov byte[max_len],cl
	mov cl,1
	mov byte[num],cl
	cmp al,0
	je print_final
	jmp loop
	
	
	
	print_final:
		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,l2
		int 80h
	
	mov al,byte[max_len]
	mov byte[num],al
	call print_num




	mov eax,1
		mov ebx,0
		int 80h
		


	read_string:
	pusha
		read_string_loop:

		mov eax,3
		mov ebx,0
		mov ecx,char
		mov edx,1
		int 80h

		cmp byte[char],10
		je end_read

		inc byte[stringlength]
		mov al,byte[char]
		stosb
		jmp read_string_loop

	end_read:
	mov byte[edi],0
	popa
	ret	     


	print_string:
	pusha
		printloop:
		
		lodsb
		mov byte[char],al

		cmp al,0
		je end_print

		mov eax,4
		mov ebx,1
		mov ecx,char
		mov edx,1
		int 80h
		jmp printloop

	end_print:

	popa
	ret


	print_space:
	pusha
		mov eax,4
		mov ebx,1
		mov ecx,space
		mov edx,sl
		int 80h
	popa 
	ret

	print_endline:
	pusha
		mov eax,4
		mov ebx,1
		mov ecx,el
		mov edx,le
		int 80h
	popa 
	ret





	read_num:

	pusha
	mov byte[num],0
	loop2:

		mov eax,3
		mov ebx,0
		mov ecx,dig
		mov edx,1
		int 80h
	     
		cmp byte[dig],10  ;10 ASCII for new line
		je end_loop
		cmp byte[dig],32
		je end_loop
		sub byte[dig],30h
		mov dx,0
		mov al,byte[num]
		mov bx,10
		mul bx
		add al,byte[dig]
		mov byte[num],al
		jmp loop2

	end_loop: 
	popa
	ret







	print_num:
	pusha
	cmp byte[num],0
	je printzero
	loop3:
		cmp byte[num], 0
		je print_no
		inc byte[nod]
		mov dx,0
		mov al, byte[num]
		mov bx, 10
		div bx
		push dx
		mov byte[num], al
		jmp loop3

		print_no:
		cmp byte[nod], 0
		je endprint
		dec byte[nod]
		pop dx
		mov byte[dig], dl
		add byte[dig], 30h
	mov eax,4
	mov ebx,1
	mov ecx,dig
	mov edx,1
	int 80h
	jmp print_no
	endprint:
	popa
	ret

		

	printzero:
	add byte[num],30h
	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,1
	int 80h
	jmp end_print	


	print_char:
	pusha
		mov eax,4
		mov ebx,1
		mov ecx,char
		mov edx,1
		int 80h
	popa
	ret
