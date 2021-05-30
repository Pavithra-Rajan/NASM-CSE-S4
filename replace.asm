section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	
	msg2: db 'Enter word to replace : '
	l2: equ $-msg2
	
	msg3: db 'Enter word to be replaced with : '
	l3: equ $-msg3
	
	
	newline: db 0Ah
        newline_len: equ $-newline

	space: db ' '
        space_len: equ $-space


section .bss
	string: resb 100
	str_len: resw 1
	char: resb 1
	word1: resb 50
	word2: resb 50
	tempword: resb 50
	string2: resb 100

	temp: resw 1
	num: resw 1
	dig: resw 1
	nod: resw 1
	
section .data
	global _start:
	_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

        mov edi,string
	call read_string


	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h

        mov edi,word1
	call read_string

	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,l3
	int 80h

        mov edi,word2
	call read_string

	cld
	mov esi,string
	mov edi,tempword

	find_word:

		lodsb
		stosb  

		cmp al,0
		je compare

		cmp al,32
		je compare                 
		
		update:
		cmp al,0
		je end
	jmp find_word
	
	end:
	
		exit:
		call print_endline
		mov eax,1
		mov ebx,0
		int 80h


	compare:
	mov byte[edi],0
	pusha

		mov esi,word1
		mov ebx,tempword	
		compareloop:
			lodsb


			cmp al,0
			je print_word2
			cmp al,32
			je print_word2
			cmp al,byte[ebx]
			jne print_tempword
			add ebx,1
		jmp compareloop

	print_word2:

		mov cl,' '
		cmp byte[ebx],cl
		je label
		cmp byte[ebx],0
		jne print_tempword
		label:  
		mov esi,word2
		call print_string
		call print_space

	popa
	mov edi,tempword
	jmp update


	print_tempword:
	mov esi,tempword
	call print_string

	popa
	mov edi,tempword
	jmp update





;;; all functions;;;
read_string:
pusha
	read_string_loop:

	mov eax,3
	mov ebx,0
	mov ecx,char
	mov edx,1
	int 80h

        cmp byte[char],10
        je end_read

        inc word[str_len]
        mov al,byte[char]
	stosb
	jmp read_string_loop

end_read:
mov byte[edi],0
popa
ret	     


print_string:
pusha
	printloop:
	
	lodsb
        mov byte[char],al

        cmp al,0
        je end_print

	mov eax,4
	mov ebx,1
	mov ecx,char
	mov edx,1
	int 80h
	jmp printloop

end_print:

popa
ret


print_space:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,space
	mov edx,space_len
	int 80h
popa 
ret

print_endline:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,newline_len
	int 80h
popa 
ret





read_num:

pusha
mov word[num],0
loop2:

	mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
	int 80h
     
        cmp word[dig],10  ;10 ASCII for new line
	je end_loop
        cmp word[dig],32
        je end_loop
	sub word[dig],30h
        mov dx,0
	mov ax,word[num]
        mov bx,10
        mul bx
        add ax,word[dig]
        mov word[num],ax
        jmp loop2

end_loop: 
popa
ret







print_num:
pusha
cmp word[num],0
je printzero
loop3:
	cmp word[num], 0
	je print_no
	inc word[nod]
	mov dx,0
	mov ax, word[num]
	mov bx, 10
	div bx
	push dx
	mov word[num], ax
	jmp loop3

	print_no:
	cmp word[nod], 0
	je endprint
	dec word[nod]
	pop dx
	mov word[dig], dx
	add word[dig], 30h
mov eax,4
mov ebx,1
mov ecx,dig
mov edx,1
int 80h
jmp print_no
endprint:
popa
ret

        

printzero:
add word[num],30h
mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h
jmp end_print	


print_char:
pusha
	mov eax,4
	mov ebx,1
	mov ecx,char
	mov edx,1
	int 80h
popa
ret


