.globl main
.data  
    
   concat_str:   .space 256       # A 256 bytes buffer 
   buf1:   .space 256
   buf2:   .space 256
   print1:  .asciiz "Enter the string : "
   print2: .asciiz "The largest words are : "
   print3: .asciiz "\nThe smallest words are : "
   space: .asciiz " "
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

   la $s2, buf1 
   addi $t2,$zero,0     # max
   addi $t5,,$zero,0    # current length

   count_max:
   lb $t0, 0($s2)
   addi $t3,$zero,32              # check space
   beq $t3,$t0,reset
   addi $t3,$zero,10             # check space
   beq $t3,$t0,reset2
   addi $t5,$t5,1
   addi $s2, $s2, 1               # increment to next position  
   j count_max

reset:
    slt $t4,$t5,$t2
    beqz $t4,res_1
    move $t5,$zero
    addi $s2, $s2, 1               # increment to next position  
    j count_max
res_1:
    move $t2,$t5
    move $t5,$zero
    addi $s2, $s2, 1               # increment to next position  
    j count_max
reset2:
    slt $t4,$t5,$t2
    beqz $t4,res_2
    j print
res_2:
    move $t2,$t5
    move $t5,$zero
    j print
    

   print:
   # li $v0, 1
   # move $a0, $t2
   # syscall
   la $s2, buf1 
   addi $t5,$zero,0     # curr
   li $v0, 4
   la $a0, print2
   syscall
   # lb $a0,1($s2)
   # li $v0,11
   # syscall
   addi $t5,$t5,0
   print_max:
   lb $t0, 0($s2)
   addi $t3,$zero,32              # check space
   beq $t3,$t0,check_max
   addi $t3,$zero,10             # check space
   beq $t3,$t0,check_max2
   addi $t5,$t5,1
   addi $s2, $s2, 1               # increment to next position  
   j print_max

   check_max:
   # li $v0,1
   # move $a0,$t5
   # syscall
   beq $t5,$t2,print_word
   addi $s2,$s2,1
   addi $t5,$zero,0
   j print_max

   print_word:
   sub $s2,$s2,$t2
   # sub $s2,$s2,1
   loop_:
   lb $a0,0($s2)
   li $v0,11
   syscall

   add $s2,$s2,1
   addi $t5,$t5,-1
   bnez $t5,loop_
   addi $s2,$s2,1
   li $v0, 4
   la $a0, space
   syscall
   j print_max

   check_max2:
   # li $v0,1
   # move $a0,$t5
   # syscall
   beq $t5,$t2,print_word2
   addi $s2,$s2,1
   addi $t5,$zero,0
   j small

   print_word2:
   sub $s2,$s2,$t2
   # sub $s2,$s2,1
   loop_2:
   lb $a0,0($s2)
   li $v0,11
   syscall
   add $s2,$s2,1
   addi $t5,$t5,-1
   bnez $t5,loop_2
 
   j small
   small:

   la $s2, buf1 
   addi $t2,$zero,100     # min
   addi $t5,,$zero,0    # current length

   count_min:
   lb $t0, 0($s2)
   addi $t3,$zero,32              # check space
   beq $t3,$t0,reset_min
   addi $t3,$zero,10             # check space
   beq $t3,$t0,reset_min_2
   addi $t5,$t5,1
   addi $s2, $s2, 1               # increment to next position  
   j count_min

reset_min:
    slt $t4,$t2,$t5
    beqz $t4,res_1_
    move $t5,$zero
    addi $s2, $s2, 1               # increment to next position  
    j count_min
res_1_:
    move $t2,$t5
    move $t5,$zero
    addi $s2, $s2, 1               # increment to next position  
    j count_min
reset_min_2:
    slt $t4,$t2,$t5
    beqz $t4,res_2_
    j print_word_min
res_2_:
    move $t2,$t5
    move $t5,$zero
    j print_word_min
   temp: 
   li $v0, 1
   move $a0, $t2
   syscall
   
   print_word_min:
   # li $v0, 1
   # move $a0, $t2
   # syscall
   la $s2, buf1 
   addi $t5,$t5,0     # curr
   li $v0, 4
   la $a0, print3
   syscall
   # lb $a0,1($s2)
   # li $v0,11
   # syscall
   
   print_min:
   lb $t0, 0($s2)
   addi $t3,$zero,32              # check space
   beq $t3,$t0,check_min
   addi $t3,$zero,10             # check space
   beq $t3,$t0,check_min2
   addi $t5,$t5,1
   addi $s2, $s2, 1               # increment to next position  
   j print_min

   check_min:
   # li $v0,1
   # move $a0,$t5
   # syscall
   beq $t5,$t2,print_word_2
   addi $s2,$s2,1
   addi $t5,$zero,0
   j print_min

   print_word_2:
   sub $s2,$s2,$t2
   # sub $s2,$s2,1
   loop_2_:
   lb $a0,0($s2)
   li $v0,11
   syscall

   add $s2,$s2,1
   addi $t5,$t5,-1
   bnez $t5,loop_2_
   addi $s2,$s2,1
   li $v0, 4
   la $a0, space
   syscall
   j print_min

   check_min2:
   # li $v0,1
   # move $a0,$t5
   # syscall
   beq $t5,$t2,print_word_2_
   addi $s2,$s2,1
   addi $t5,$zero,0
   j end

   print_word_2_:
   sub $s2,$s2,$t2
   # sub $s2,$s2,1
   loop_2_1:
   lb $a0,0($s2)
   li $v0,11
   syscall
   add $s2,$s2,1
   addi $t5,$t5,-1
   bnez $t5,loop_2_1
   j end

end:
   li $v0,10        # exit
   syscall