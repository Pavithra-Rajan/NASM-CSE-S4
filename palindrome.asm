section .bss
	str:resb 300
	str_len:resb 1
	ele:resb 1
	noc:resd 1
	nod:resd 1
	dig:resd 1
	num:resd 1


section .data
	msg1:db 'Enter string :'
	msg1_len:equ $-msg1
	pal_msg:db 'It is a palindrome',10
	pal_len:equ $-pal_msg
	not_pal:db 'It is NOT a palindrome',10
	not_len:equ $-not_pal
	
section .text
	global _start:
	_start:

			mov ecx,msg1
			mov edx,msg1_len
			call print_text

			call input_string

			mov esi,str
			mov edi,str
			add edi,[noc]
			dec edi
			cld 

			palindrome_checker:

			cmpsb
			jne not_palindrome_print

			sub edi,2
			dec dword[noc]
			cmp dword[noc],0
			jne palindrome_checker

			mov ecx,pal_msg
			mov edx,pal_len
			call print_text

			jmp exit

			not_palindrome_print:
			mov ecx,not_pal
			mov edx,not_len
			call print_text

			exit:

			mov eax,1
			mov ebx,0
			int 80h

			

	;print
			print_text:
			pusha
			mov eax,4
			mov ebx,1
			int 80h
			popa
			ret

			

	;Input string
			input_string:
			pusha
			mov edi,str
			mov dword[noc],0
			cld

			continue_input:

			mov eax,3
			mov ebx,0
			mov ecx,ele
			mov edx,1
			int 80h

			cmp byte[ele],10
			je end_input

			mov al,[ele]
			stosb
			inc dword[noc]
			jmp continue_input

			end_input:

			mov al,0
			stosb

			popa
			ret
