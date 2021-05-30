section .bss
	digit0: resb 1
	digit1: resb 1
	array: resb 50 ;Array to store 50 elements of 1 byte each.
	element: resb 1
	num: resb 1
	pos: resb 1
	temp: resb 1
	ele: resb 1

section .data
	msg1: db "Enter the number of elements : "
	size1: equ $-msg1
	msg2: db "Enter a number:"
	size2: equ $-msg2
	msg3: db "Enter the number to be searched : "
	size3: equ $-msg3
	msg_found: db "Element found at position : "
	size_found: equ $-msg_found
	msg_not: db "Element not found"
	size_not: equ $-msg_not

section .text
	global _start
	_start:
	;Printing the message to enter the number
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, size1
	int 80h
	;Reading the number
	mov eax, 3
	mov ebx, 0
	mov ecx, digit1
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, digit0
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h

	sub byte[digit1], 30h
	sub byte[digit0], 30h
	mov al, byte[digit1]
	mov dl, 10
	mul dl
	mov byte[num], al
	mov al, byte[digit0]
	add byte[num], al
	mov al, byte[num]

	mov byte[temp], al
	mov ebx, array
	reading:
	push ebx ;Preserving The value of ebx in stack
	;Printing the message to enter each element
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, size2
	int 80h
	;Reading the number
	mov eax, 3
	mov ebx, 0
	mov ecx, digit1
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, digit0
	mov edx, 2
	int 80h
	sub byte[digit1], 30h
	sub byte[digit0], 30h
	mov al, byte[digit1]
	mov dl, 10
	mul dl
	add al, byte[digit0]
	;al now contains the number

	pop ebx
	mov byte[ebx], al
	add ebx, 1

	dec byte[temp]
	cmp byte[temp], 0
	jg reading

	;Comparing loop variable
	;Loop using branch statements


	;Reading the number to be searched :.....
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, size3
	int 80h

	;Reading the number
	mov eax, 3
	mov ebx, 0
	mov ecx, digit1
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, digit0
	mov edx, 2
	int 80h
	sub byte[digit1], 30h
	sub byte[digit0], 30h
	mov al, byte[digit1]
	mov dl, 10
	mul dl
	add al, byte[digit0]
	mov byte[ele], al

	movzx ecx, byte[num]
	mov ebx, array
	mov byte[pos], 1

	searching:
	push ecx
	mov al , byte[ebx]
	cmp al, byte[ele]
	je found
	add ebx, 1
	pop ecx
	add byte[pos], 1
	loop searching

	mov eax, 4
	mov ebx, 1
	mov ecx, msg_not
	mov edx, size_not
	int 80h
	exit:
	mov eax, 1
	mov ebx, 0
	int 80h

	found:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg_found
	mov edx, size_found
	int 80h
	movzx ax, byte[pos]
	mov bl, 10
	div bl
	mov byte[digit1], al
	mov byte[digit0], ah
	add byte[digit0], 30h
	add byte[digit1], 30h
	mov eax, 4
	mov ebx, 1
	mov ecx, digit1
	mov edx, 1
	int 80h
	mov eax, 4
	mov ebx, 1
	mov ecx, digit0
	mov edx, 1
	int 80h
	jmp exit


