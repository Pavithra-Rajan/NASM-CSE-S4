section .data
msg1:db 'YES it is a prime number',10
s1:equ $-msg1
msg2:db 'No it is not a prime number',10
s2:equ $-msg2
msg3 : db 'Enter the number : '
l3 : equ $-msg3

section .bss
a:resb 10
b:resb 10
junk:resb 1
i: resd 1
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

	mov eax,1
	mov dword[i],eax
	
for:
	mov eax,dword[i]
	

	mov ax,[a]
	div dword[i]

	cmp ah,0
	jz if

	else:
		inc dword[i]
		jmp for
	jmp exit

	if:

		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,s2
		int 80h

exit:

	mov eax,1
	mov ebx,0
	int 80h
