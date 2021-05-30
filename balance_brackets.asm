section .data
	msg1: db 'Enter the string : '
	l1: equ $-msg1
	
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
	temp_char: resb 1
	brac: resb 1

	temp: resw 1
	num: resw 1
	dig: resw 1
	nod: resw 1
	count: resw 1
	
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

	
	mov cx,0
	mov word[count],cx
	mov bl,')'
	mov byte[brac],bl

	cld
	mov esi,string
	

	find_word:

		lodsb
		 
		mov byte[temp_char],al
		cmp al,'('
		je counter
                
		cmp al,')'
		je decre
 		
 		pusha
		mov eax,4
		mov ebx,1
		mov ecx,temp_char
		mov edx,1
		int 80h  
		popa             
		
		update:
		cmp al,0
		je end
	jmp find_word
	counter:
		inc word[count]
		pusha
		mov eax,4
		mov ebx,1
		mov ecx,temp_char
		mov edx,1
		int 80h  
		popa
		jmp update
	decre:
	       mov cx,word[count]
	       cmp cx,0
	       je update
	       pusha
		mov eax,4
		mov ebx,1
		mov ecx,temp_char
		mov edx,1
		int 80h  
		popa
	       dec word[count]
	       jmp update
	       
	
	end:
	
		loop:
		mov cx,word[count]
	        cmp cx,0
	        jne print_bracket
	        
		
		exit:
		call print_endline
		mov eax,1
		mov ebx,0
		int 80h


	print_bracket:
		pusha
		mov eax,4
		mov ebx,1
		mov ecx,brac
		mov edx,1
		int 80h
		popa
		dec word[count]
		jmp loop
		
		





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


