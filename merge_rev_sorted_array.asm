section .data
	msg1: db "Enter Number of Array1: "
	size1: equ $-msg1
	msg2: db "Enter the Elements of Array: "
	size2: equ $-msg2
	msg3: db "Elements after sorting: "
	size3: equ $-msg3
	msg4: db " "
	size4: equ $-msg4
	msg5: db 0Ah
	size5: equ $-msg5
	msg6: db "Enter Number of Array2: "
	size6: equ $-msg6

section .bss
	n: resw 1
	n2: resw 1
	n3: resw 1
	temp1: resb 1
	array: resw 100
	count: resw 1
	count1: resw 1
	count2: resw 1
	temp2: resw 1
	temp3: resw 1
	nod:resb 1

section .text
	global _start:
	_start:
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size1
		int 80h

		mov word[n],0
		mov word[n2],0
		mov word[n3],0

		read_n:
		mov eax,3
		mov ebx,0
		mov ecx,temp1
		mov edx,1
		int 80h

		cmp byte[temp1],10
		je arr_2

		mov ax,word[n]
		mov bx,10
		mul bx
		movzx bx,byte[temp1]
		sub bx,30h
		add ax,bx
		mov word[n],ax
		jmp read_n
		
		arr_2:
		mov eax,4
		mov ebx,1
		mov ecx,msg6
		mov edx,size6
		int 80h
		read_n2:
		mov eax,3
		mov ebx,0
		mov ecx,temp1
		mov edx,1
		int 80h

		cmp byte[temp1],10
		je add_size

		mov ax,word[n3]
		mov bx,10
		mul bx
		movzx bx,byte[temp1]
		sub bx,30h
		add ax,bx
		mov word[n3],ax
		jmp read_n2
		
		add_size:
		mov ax,word[n3]
		add word[n],ax
		
		read_array_elem:

		mov ebx,array
		read_array:
		push ebx
		mov word[n2],0
		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,size2
		int 80h

		read_ele:
		mov eax,3
		mov ebx,0
		mov ecx,temp1
		mov edx,1
		int 80h

		cmp byte[temp1],10
		je read_continue

		mov ax,word[n2]
		mov bx,10
		mul bx
		movzx bx,byte[temp1]
		sub bx,30h
		add ax,bx
		mov word[n2],ax
		jmp read_ele

		read_continue:
		pop ebx
		mov cx,word[n2]
		mov word[ebx],cx
		add bx,16
		add word[count],1
		mov cx,word[count]
		cmp cx,word[n]
		je bubble_sort

		jmp read_array

		bubble_sort:
		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,size3
		int 80h
		mov word[count1],0
		mov word[count2],0
		mov ebx,array
		mov edx,array
		mov ax,word[n]
		push ax
		for1:
		pop ax
		cmp word[count1],ax
		je print_array
		push ax
		mov edx,ebx
		mov cx,word[count1]
		mov word[count2],cx
		for2:
		pop ax
		cmp word[count2],ax
		je after_for2
		push ax
		mov ax,word[ebx]
		mov cx,word[edx]
		cmp ax,cx
		jl no_swap
			swap:
			   mov word[ebx],cx
			   mov word[edx],ax
		no_swap:
		inc word[count2]
		add edx,16
		jmp for2
		after_for2:
		push ax
		inc word[count1]
		add ebx,16
		jmp for1

		print_array:
		mov word[count1],0
		mov ebx,array

		printloop:
		mov ax,word[n]
		cmp ax,word[count1]
		je exit
		mov cx,word[ebx]
		mov word[count],cx

		mov byte[nod],0

		number_extract:
		cmp word[count],0
		je print_no
		inc byte[nod]
		mov dx,0
		mov ax,word[count]
		mov bx,10
		div bx
		push dx
		mov word[count],ax
		jmp number_extract

		print_no:
		cmp byte[nod],0
		je after_print_no
		dec byte[nod]
		pop dx
		mov word[temp1],dx
		add word[temp1],30h

		mov eax,4
		mov ebx,1
		mov ecx,temp1
		mov edx,1
		int 80h
		jmp print_no

		after_print_no:

		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,size4
		int 80h

		inc word[count1]
		mov eax,16
		mul word[count1]
		mov ebx,array
		add ebx,eax
		jmp printloop

		exit:
		mov eax,4
		mov ebx,1
		mov ecx,msg5
		mov edx,size5
		int 80h

		mov eax,1
		mov ebx,0
		int 80h

