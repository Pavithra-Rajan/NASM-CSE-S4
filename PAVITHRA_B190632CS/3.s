.globl main
.data  
    
   concat_str:   .space 256       # A 256 bytes buffer 
   buf1:   .space 256
   buf2:   .space 256
   print1:  .asciiz "Enter the first string : "
   print2: .asciiz "Enter the second string : "
   print3: .asciiz "The concatenated string : "
.text  
 main:  
   li $v0, 4
   la $a0, print1
   syscall

   li $v0,8
   la $a0,buf1
   li $a1,256
   move $t4,$a0
   syscall

   li $v0, 4
   la $a0, print2
   syscall

   li $v0,8
   la $a0,buf2
   li $a1,256
   move $t5,$a0
   syscall

   la $s1, concat_str  
   la $s2, buf1 
   la $s3, buf2

   copy_str1:  
   lb $t0, ($s2)                  # character at that address loaded 
   addi $t3,$zero,10              # check endline
   beq $t3,$t0,copy_str2
   sb $t0, ($s1)                  # else store current char  
   addi $s2, $s2, 1               # increment to next position  
   addi $s1, $s1, 1               # increment the position in new str 
   j copy_str1              

   copy_str2:
   lb $t0, ($s3)                  # character at that address loaded   
   beqz $t0, print
   sb $t0, ($s1)                  # else store current char   
   addi $s3, $s3, 1               # increment to next position    
   addi $s1, $s1, 1               # increment the position in new str  
   j copy_str2

   print:
   li $v0, 4
   la $a0, print3
   syscall

   li $v0,4
   la $a0,concat_str
   syscall

   li $v0,10        # exit
   syscall