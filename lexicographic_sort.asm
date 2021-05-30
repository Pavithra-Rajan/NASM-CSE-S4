section .data
	msg1 : db "Enter number of words in string: "
	l1: equ $-msg1
	msg2: db "Enter the words - "
	l2: equ $-msg2
	msg3: db "Lexicographically sorted words- "
	l3: equ $-msg3
	space: db " "
	space_len: equ $-space
	newline : db "",0Ah
	newline_len: equ $-newline


section .bss
    digit : resw 1
    string1     : resw 1
    char_in_word     : resw 1
    count2   : resw 1
    string2 : resw 1
    smallest : resw 1
    count1 : resw 1
    pos    : resw 1
    num   : resw 1
    count : resw 1
    words_count     : resw 1
    arr   : resw 300
    str_array  : resw 100
    copy_small : resw 1

section .text
	global _start:
	_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h
	call readno
	mov ax,word[num]
	mov word[words_count],ax

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h
	call newline_print

	call read_n_strings

	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,l3
	int 80h

	call newline_print


	lexi_sort:
	       mov word[count],0
	       move_array_words: 
		   movzx edx,word[count]
		   mov ax,word[str_array+edx*2]
		   mov word[smallest],ax
		   mov ax,word[count]
		   mov word[pos],0
		   cmp word[words_count],ax
		            je endsort
		   mov ax,word[count]
		   mov word[count1],ax
		   
		   shift_word:
		       mov ax,word[count1]
		       cmp word[words_count],ax
		            je end_shifting
		       movzx edx,word[count1]
		       mov ax,word[str_array+edx*2]
		       mov word[string2],ax
		       call compare
		       inc word[count1]
		       jmp shift_word
		       
		   end_shifting:
		       movzx edx,word[count]
		       mov ax,word[str_array+edx*2]
		       mov bx,word[smallest]
		       mov word[str_array+edx*2],bx
		       movzx edx,word[pos]
		       mov word[str_array+edx*2],ax
		       inc word[count]
		       call printstring
		       call newline_print
		       jmp move_array_words
		       
		endsort:
		    call exit
 
    
compare:
    pusha
    mov ax,word[string2]
    mov word[string1],ax
    mov ax,word[smallest]
    mov word[copy_small],ax
    loopch1:
        movzx edx,word[string1]
        mov ax,word[arr+edx*2]
        mov word[char_in_word],ax
        movzx edx,word[copy_small]
        mov ax,word[arr+edx*2]
        cmp word[char_in_word],10
               je update_small
        cmp ax,10
               je end_compare
        cmp word[char_in_word],ax
               ja end_compare
        cmp word[char_in_word],ax
               jb update_small
        inc word[string1]
        inc word[copy_small]    
        jmp loopch1
   
        
   update_small:
      mov ax,word[string2]
      mov word[smallest],ax
      mov ax,word[count1]
      mov word[pos],ax
      
   end_compare:
         popa
         ret
  
printstring:
    pusha
    mov ax,word[smallest]
    mov word[count2],ax
    loop_word:
       movzx edx,word[count2]
       mov ax,word[arr+edx*2]
       cmp ax,10
              je end_print_string
       mov word[num],ax
       mov eax,4
       mov ebx,1
       mov ecx,num
       mov edx,1
       int 80h 
       inc word[count2]
       jmp loop_word
       
   end_print_string:
       popa
       ret

read_n_strings:
    pusha
    mov word[count1],0 
    mov word[count],0
    loop_read_n_str:
         mov ax,word[count1]
         cmp ax,word[words_count]
                je endreadn
         mov ax,word[count]
         movzx edx,word[count1]
         mov word[str_array+edx*2],ax
         call readstring
         inc word[count1]
         jmp loop_read_n_str
    endreadn:
         popa
         ret    
readstring:
    pusha
    loop_read:
       call readch
       mov ax,word[num]
       movzx edx,word[count]
       mov word[arr+edx*2],ax
       inc word[count]
       cmp word[num],10
              je endreadstring
       jmp loop_read
    endreadstring:
       popa
       ret
printno:
     pusha
     mov ax,23
     push ax
     mov ax,word[num]
     getdigit:
        mov dx,0 
        mov bx,10 
        div bx 
        push dx
        cmp ax,0
          jne getdigit
     printdigit:
          pop dx
          cmp dx,23
          je return1
          add dx,30h
          mov word[digit],dx
          mov eax,4
          mov ebx,1
          mov ecx,digit
          mov edx,1
          int 80h
          jmp printdigit
     return1:
          popa
          ret
readno:
     pusha
     mov word[num],0
     mov bx,10
     getd1:
       mov eax,3
       mov ebx,0
       mov ecx,digit
       mov edx,1
       int 80h
       cmp word[digit],10
           je return 
       sub word[digit],30h
       mov ax,word[num]
       mov bx,10
       mul bx
       add ax,word[digit]
       mov word[num],ax
       jmp getd1
    return:
      popa     
      ret

readch:
    pusha
    mov word[num],0
    readdigit:
      mov eax,3
      mov ebx,0
      mov ecx,digit
      mov edx,1
      int 80h
      mov ax,word[digit]
      mov word[num],ax
    endread:
       popa
       ret
newline_print:
    pusha
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,newline_len
    int 80h
    popa
    ret
exit: 


   mov eax,1
   mov ebx,0
   int 80h
