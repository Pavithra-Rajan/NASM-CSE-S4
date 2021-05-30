section .data
	string_len1: db 0
	string_len2: db 0
	string_len3: db 0
	original_pos:db 0
	space:db 32
	msg1: db "Enter a string : "
	size1: equ $-msg1
	msg2: db "Enter a substring to remove : "
	size2: equ $-msg2


	newline: db 0Ah
	le11:equ $-newline



section .bss
	string1: resb 100
	string2: resb 100
	string3: resb 100
	temp: resb 10
	i:resb 10
	num:resb 10
	digit:resb 10

section .data
global _start
_start:



	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, size1
	int 80h
	mov ebx, string1
	
	string_read:
	push ebx
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	pop ebx
	cmp byte[temp], 10
	je end_string_read
	
	inc byte[string_len1]
	mov al,byte[temp]
	mov byte[ebx], al
	inc ebx
	jmp string_read
	
	end_string_read:
	mov byte[ebx], 10


	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, size2
	int 80h

	mov ebx, string2
	reading2:
	push ebx
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	pop ebx
	cmp byte[temp], 10
	je end_reading2
	inc byte[string_len2]
	mov al,byte[temp]
	mov byte[ebx], al
	inc ebx
	jmp reading2
	end_reading2:
	mov byte[ebx], 10


	mov ebx,string1
	mov ecx,string2

	mov esi,0

	search:

	mov al ,byte[ebx+esi]
	cmp al,byte[ecx]
	je loop
	
	reassign:						;reassign
	mov al ,byte[ebx+esi]
	cmp al,10
	je exit

	mov byte[temp],al				; print char 
	push ebx
	push ecx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h
	
	pop ecx
	pop ebx

	inc esi

	printed:
	mov ecx,string2
	jmp search


	initial:
	mov dl,byte[original_pos]
	movzx esi,dl
	jmp reassign 


	loop:

	mov dword[original_pos],esi
	loop1:
	inc ecx
	inc esi
	mov dl,byte[ecx]
	cmp dl,10
	je reassign
	mov al,byte[ebx+esi]
	cmp al,byte[ecx]
	jne initial
	jmp loop1



exit:
mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx,le11
	int 80h

mov eax, 1
mov ebx, 0
int 80h
