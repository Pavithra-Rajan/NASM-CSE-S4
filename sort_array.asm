section .data
msg1: db "Enter Number of Array: "
len1: equ $-msg1
msg2: db "Enter the Elements of Array: "
len2: equ $-msg2
msg3: db "Elements after sorting: "
len3: equ $-msg3
msg4: db " "
len4: equ $-msg4
msg5: db 0Ah
len5: equ $-msg5

section .bss
n: resw 1
n2: resw 1
temp1: resb 1
ar: resw 100
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
mov edx,len1
int 80h

mov word[n],0
mov word[n2],0

read_n:
mov eax,3
mov ebx,0
mov ecx,temp1
mov edx,1
int 80h

cmp byte[temp1],10
je print_msg2

mov ax,word[n]
mov bx,10
mul bx
movzx bx,byte[temp1]
sub bx,30h
add ax,bx
mov word[n],ax
jmp read_n

print_msg2:

mov ebx,ar
read_array:
push ebx
mov word[n2],0
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

read_ele:
mov eax,3
mov ebx,0
mov ecx,temp1
mov edx,1
int 80h

cmp byte[temp1],10
je continue_read_arr

mov ax,word[n2]
mov bx,10
mul bx
movzx bx,byte[temp1]
sub bx,30h
add ax,bx
mov word[n2],ax
jmp read_ele

continue_read_arr:
pop ebx
mov cx,word[n2]
mov word[ebx],cx
add bx,16
add word[count],1
mov cx,word[count]
cmp cx,word[n]
je sort

jmp read_array

sort:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
mov word[count1],0
mov word[count2],0
mov ebx,ar
mov edx,ar
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
mov ebx,ar

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
mov edx,len4
int 80h

inc word[count1]
mov eax,16
mul word[count1]
mov ebx,ar
add ebx,eax
jmp printloop

exit:
mov eax,4
mov ebx,1
mov ecx,msg5
mov edx,len5
int 80h

mov eax,1
mov ebx,0
int 80h

