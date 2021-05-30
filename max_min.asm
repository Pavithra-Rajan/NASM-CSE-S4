section .bss
	digit0: resb 1
	digit1: resb 1
	array: resb 50 ;Array to store 50 elements of 1 byte each.
	element: resb 1
	num: resb 1
	pos: resb 1
	temp: resb 1
	ele: resb 1
	minimum: resb 1
	maximum: resb 1

section .data
	msg1: db "Enter the number of elements : "
	size1: equ $-msg1
	msg2: db "Enter a number:"
	size2: equ $-msg2
	msg3: db "Maximum : "
	size3: equ $-msg3
	msg4: db "Minimum : "
	size4: equ $-msg4
	newline: db " ",10
	nl: equ $-newline
	

section .text
	global _start
	_start:
		mov al,10
		mov byte[num],al
		
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
			jne reading

			;Comparing loop variable
			;Loop using branch statements


		
		
		mov byte[minimum], 0 
		mov byte[maximum], 0 
		searching:
			push ebx
			mov cl,byte[ebx]
			cmp byte[minimum], cl
			jg min
			min:
				mov byte[minimum], cl
				
			cmp byte[maximum], cl	
			jl max
			max:
				mov byte[maximum], cl
			
			loop1: 
				pop ebx
				dec byte[num]
				add ebx,1
				cmp byte[num], 0
				jg searching

		mov eax, 4
		mov ebx, 1
		mov ecx, msg3
		mov edx, size3
		int 80h
		
		max_print:
			
			movzx ax, byte[maximum]
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
		mov eax, 4
		mov ebx, 1
		mov ecx, newline
		mov edx, nl
		int 80h
		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg4
		mov edx, size4
		int 80h
		
		min_print:
			
			movzx ax, byte[minimum]
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
		mov eax, 4
		mov ebx, 1
		mov ecx, newline
		mov edx, nl
		int 80h
			
		
		exit:
			mov eax, 1
			mov ebx, 0
			int 80h
		
		


