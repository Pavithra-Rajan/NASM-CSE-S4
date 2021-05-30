section .bss
	array: resd 50
	n: resd 1
	temp: resd 1
	sum: resd 10
	

	num: resd 1
	digit: resb 1
	length: resd 1
	a: resd 1
	b: resd 1

section .data
	msg1: db "Enter the number of elements : "
	size1: equ $-msg1
	msg2: db "Enter a number:"
	size2: equ $-msg2
	
	msg3: db "Average: "
	size3: equ $-msg3
	msg4: db "Sum: "
	size4: equ $-msg4
	
	newline: db " ",10
	newline_size: equ $-newline
	decimal: db "."
	decimal_size equ $-decimal
	
section .text
	global _start:
	_start:
	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, size1
	int 80h
	popa
	
	call input
	mov eax,[num]
	mov [n],eax
	
	mov [temp],eax
	mov ebx,array

	;reading array
	read:
	
		pusha
		mov eax, 4
		mov ebx, 1
		mov ecx, msg2
		mov edx, size2
		int 80h
		popa
		
		push ebx
		call input
		pop ebx
		mov eax,[num]
		mov [ebx],eax
		add ebx,4
		dec byte[temp]
		cmp byte[temp],0
		ja read

	mov ebx,array
	mov eax,[n]
	mov [temp],eax
	mov dword[sum],0

	add:
		mov ecx,dword[ebx]
		add [sum],ecx
		dec byte[temp]
		add ebx,4
		cmp byte[temp],0
		jnz add

	pusha
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,size3
	int 80h
	popa
	
	mov eax,[sum]
	mov ebx,[n]
	div ebx
	mov [num],eax
	call print_number
	;print decimals

	pusha
	mov eax,4
	mov ebx,1
	mov ecx,decimal
	mov edx,decimal_size
	int 80h
	popa

	mov eax,edx
	mov ebx,10
	mul ebx
	mov ebx,[n]
	div ebx
	mov [num],eax
	call print_number

	mov eax,edx
	mov ebx,10
	mul ebx
	mov ebx, [n]
	div ebx
	mov [num],eax
	call print_number
	
	mov eax,edx
	mov ebx,10
	mul ebx
	mov ebx, [n]
	div ebx
	mov [num],eax
	call print_number

	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,newline_size
	int 80h

	pusha
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,size4
	int 80h
	popa
	
	mov eax,[sum]
	mov [num],eax
	call print_number

	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,newline_size
	int 80h

	mov eax,1
	mov ebx,0
	int 80h

	;funcs
	input:
	pusha
	mov dword[num],0

	digit_loop:
	mov eax,3
	mov ebx,0
	mov ecx,digit
	mov edx,1
	int 80h

	cmp byte[digit],10
	je end_input

	sub byte[digit],30h
	mov eax,[num]
	mov ebx,10
	mul ebx
	add eax,dword[digit]
	mov [num],eax

	jmp digit_loop
	end_input:
	popa
	ret

	print_number:
	pusha
	mov dword[length],0
	cmp dword[num],0
	je printzero

	get_number:
	mov edx,0
	mov eax, [num]
	mov ebx,10
	div ebx
	mov [num],eax
	push edx
	inc dword[length]
	cmp dword[num],0
	ja get_number

	print_digit:
	pop edx
	mov [digit],dl

	add byte[digit],30h
	mov eax,4
	mov ebx,1
	mov ecx,digit
	mov edx,1
	int 80h

	dec dword[length]
	cmp dword[length],0
	ja print_digit

	jmp end_print

	printzero:
	mov byte[length],1
	mov edx, [num]
	push edx
	jmp print_digit
	
		
	end_print:
	popa
	ret
	
	
