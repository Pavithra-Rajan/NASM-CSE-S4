section .bss
	array: resd 50
	n: resd 1
	temp: resd 1
	temp2: resd 1
	count: resd 1
	max_count: resd 1
	max: resd 1
	ele: resd 1
	min_count: resd 1
	min: resd 1

	num: resd 1
	digit: resb 1
	length: resd 1
	a: resd 1
	b: resd 1

section .data
	space: db " "
	lspace: equ $-space
	msg1: db "Enter the number of elements : "
	size1: equ $-msg1
	msg3: db "Enter the element : "
	size3: equ $-msg3
	msg2: db "Maximum : "
	size2: equ $-msg1
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
		
		call input_number
		mov eax,[num]
		mov [n],eax
		
		mov [temp],eax
		mov ebx,array

		;reading array
		read:
			pusha
			mov eax, 4
			mov ebx, 1
			mov ecx, msg3
			mov edx, size3
			int 80h
			popa
			
			push ebx
			call input_number
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
		mov [temp2],eax
		mov dword[count],0
		mov dword[max_count],0
		mov dword[min_count],999999
		mov eax,dword[ebx]
		mov [max],eax
		mov [min],eax

		sel_ele:
		mov eax,dword[ebx]
		mov [ele],eax 	;ele=arr[i]
		mov edx,array	;edx=arr[0]
		mov dword[count],0
		mov ecx,[n]
		mov [temp],ecx

		count_occur:
		mov ecx,dword[edx]
		cmp dword[ele],ecx	;arr[i]==arr[j]
		jne next_count

		inc dword[count]	; count++

		next_count:
		add edx,4
		dec byte[temp]
		cmp byte[temp],0
		jnz count_occur

		mov ecx,dword[max_count]
		cmp dword[count],ecx
		jle test_min

		mov eax,[count]
		mov [max_count],eax
		mov eax,[ele]
		mov [max],eax

		test_min:
		mov ecx,dword[min_count]
		cmp dword[count],ecx
		jge next_ele

		mov eax,[count]
		mov [min_count],eax
		mov eax,[ele]
		mov [min],eax

		next_ele:
		add ebx,4
		dec byte[temp2]
		cmp byte[temp2],0
		jnz sel_ele

		mov eax, [max]
		mov [num], eax
		
		call print_number

		mov eax,4
		mov ebx,1
		mov ecx,space
		mov edx,lspace
		int 80h

		mov eax, [min]
		mov [num], eax
		call print_number

		mov eax,1
		mov ebx,0
		int 80h

		;funcs
		input_number:
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
