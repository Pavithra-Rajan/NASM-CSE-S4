.globl main
.text

main :
    li $t1, 0 
    li $t2, 1
    li $s1, 0

    li $v0, 4
    la $a0, print
    syscall

   
    li $v0, 5
    syscall

    move $s3, $v0   # stores maximum limit
  
fib :
    
    slt $s2,$s1,$s3
    beqz $s2,end

    li $v0, 1
    move $a0, $t1
    syscall
    jal comma_print

    move $t5,$t2            # temp=t2
    add $t2,$t1,$t2         # t2=t1+t2
    move $t1, $t5           # t1=temp
    
    addi $s1,1
    j fib

comma_print :
    li $v0, 4
    la $a0, com 
    syscall
    jr $ra 

end_line : 
    li $v0, 4 
    la $a0, endline 
    syscall
    jr $ra

end : 
    jal end_line
    li $v0, 10
    syscall
.data
    print:  .asciiz "Enter the number : "
    com: .asciiz " , "
    endline: .asciiz "\n"
