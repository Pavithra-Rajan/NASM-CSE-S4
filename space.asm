section .data
	
	string_len: db 0
	msg1: db "Enter a string : "
	size1: equ $-msg1
	msg_space: db"No: of spaces : "
	msg_size: equ $-msg_space
	
	new_line: db ' ',10
	size_len: equ $-new_line
section .bss
	string: resb 50
	char: resb 1
	space_count: resb 1
	
section .text
	global _start:
	_start:
	
		mov al, 0
		mov [space_count],al
		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg1
		mov edx, size1
		int 80h
		mov ebx, string
		reading:
		push ebx
		mov eax, 3
		mov ebx, 0
		mov ecx, char
		mov edx, 1
		int 80h
		pop ebx
		cmp byte[char], 10
		je end_reading
		
		inc byte[string_len]
		mov al,byte[char]
		mov byte[ebx], al
		inc ebx
		jmp reading
		
		end_reading:
		mov byte[ebx], 0
		mov ebx, string
		
		counting:
		mov al, byte[ebx]
		cmp al, 0
		je end_counting
		cmp al, ' '
		je inc_a
		
		
		next:
		inc ebx
		jmp counting
		
		end_counting:
		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg_space
		mov edx, msg_size
		int 80h
		
		add byte[space_count], 30h
		mov eax, 4
		mov ebx, 1
		mov ecx, space_count
		mov edx, 1
		int 80h
	
		
		mov eax, 4
		mov ebx, 1
		mov ecx, new_line
		mov edx, size_len
		int 80h
		
		exit:
		mov eax, 1
		mov ebx, 0
		int 80h
		inc_a:
		inc byte[space_count]
		jmp next
		
		
		jmp next
	
