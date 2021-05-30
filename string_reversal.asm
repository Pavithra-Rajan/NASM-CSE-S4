section .bss
	temp: resb 1
	temp2: resb 1


	str: resw 300
	str2: resw 300
	noc: resb 1
	l: resb 1
	r:resb 1

section .data
	msg1:db 'Enter the string :'
	msg1_len:equ $-msg1
	msg2:db 'Reversed string: '
	msg2_len:equ $-msg2
	

section .text
	global _start:
	_start:
	mov ecx,msg1
	mov edx,msg1_len
	call print_text
	
	call input_string
	mov eax,0
	mov al,byte[noc]
	mov byte[temp],al
	mov esi,str
	mov edi,str2
	
	cld
	mov ecx,msg2
	mov edx,msg2_len
	call print_text
	
	copy:
	lodsb
	stosb
	dec byte[temp]
	cmp byte[temp],0
	jne copy

	dec esi
	mov edi,str2

	mov al,byte[noc]
	mov byte[temp],al

	std
	special_checker:
	lodsb
	cmp al,49
	jl next
	cmp al,57
	jg check_alpha
	
	return:
	mov bl,[edi]
	cmp bl,49   ;ascii for 1
	jl next2
	cmp bl,57  ;ascii 9
	jg check_alpha_2

	store:

	stosb

	add edi,2
	next:
	dec byte[temp]
	cmp byte[temp],0
	jne special_checker


	push esi
	mov esi,str2
	call out_str
	pop esi

	mov eax,1
	mov ebx,0
	int 80h

	check_alpha:
	cmp al,65  ;A
	jl next
	cmp al,90  ;Z
	jg not_upper
	jmp return

	not_upper:
	cmp al,97
	jl next
	cmp al,122
	jg next
	jmp return

	check_alpha_2:
	cmp bl,65
	jl next2
	cmp bl,90
	jg not_upper2
	jmp store

	not_upper2:
	cmp bl,97
	jl next2
	cmp bl,122
	jg next2
	jmp store

	next2:
	inc edi
	jmp return

	;funcs

	input_string:
	pusha
	mov byte[noc],0
	mov edi,str
	cld

	letter_loop:
	mov eax,3
	mov ebx,0
	mov ecx,l
	mov edx,1
	int 80h

	cmp byte[l],10
	je end_input

	mov al,byte[l]
	stosb
	inc byte[noc]

	jmp letter_loop
	end_input:

	mov al,0
	stosb
	popa
	ret

	; output str in esi
	out_str:
	pusha
	cld

	inner_out_str:
	lodsb
	mov [l],al

	cmp byte[l],0
	je end_inner_out_str

	mov eax,4
	mov ebx,1
	mov ecx,l
	mov edx,1
	int 80h

	jmp inner_out_str

	end_inner_out_str:

	popa
	ret

	
	print_text:
	pusha
	mov eax,4
	mov ebx,1
	int 80h
	popa
	ret
