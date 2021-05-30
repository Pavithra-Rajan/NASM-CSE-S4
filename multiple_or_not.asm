section .data
msg1:db 'YES it is a multiple',10
s1:equ $-msg1
msg2:db 'No it is not a multiple',10
s2:equ $-msg2
msg3 : db 'Enter first number : '
l3 : equ $-msg3
msg4 : db 'Enter second number : '
l4 : equ $-msg4

section .bss
a:resb 10
b:resb 10
junk:resb 1

section .text
	global _start:
	_start:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l3
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,a
	mov edx,1
	int 80h
	sub byte[a],30h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, l4
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,b
	mov edx,1
	int 80h
	sub byte[b],30h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h

	mov ax,[a]
	div byte[b]

	cmp ah,0
	jz if

	else:
		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,s2
		int 80h

	jmp exit

	if:

		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,s1
		int 80h

exit:

	mov eax,1
	mov ebx,0
	int 80h
