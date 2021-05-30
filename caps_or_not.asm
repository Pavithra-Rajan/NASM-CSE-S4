section .data
msg : db 'Enter an alphabet :'
l : equ $-msg
ans1 : db 'CAPS LOCK IS ON',10
l1 : equ $-ans1
ans2 :db 'caps lock is off',10
l2 : equ $-ans2
ans3 : db 'Error',10
l3 equ $-ans3
section .bss
d1 : resb 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, l
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h
	
	
	mov al, byte[d1]
	cmp al,'A'
	setnc bl
	cmp al, 'Z'+1
	setc bh
	and bl, bh

	cmp bl, 1
	je if


	else:
		mov al, byte[d1]
		cmp al, 'a'
		setnc bl
		cmp al, 'z'+1
		setc bh
		and bl, bh
		cmp bl, 1
		je ending

		else1:
			mov eax, 4
			mov ebx, 1
			mov ecx, ans3
			mov edx, l3
			int 80h

			mov eax, 1
			mov ebx, 0
			int 80h

	if:
		mov eax, 4
		mov ebx, 1
		mov ecx, ans1
		mov edx, l1
		int 80h

		mov eax, 1
		mov ebx, 0
		int 80h

	ending:
		mov eax, 4
		mov ebx, 1
		mov ecx, ans2
		mov edx, l2
		int 80h

		mov eax, 1
		mov ebx, 0
		int 80h


