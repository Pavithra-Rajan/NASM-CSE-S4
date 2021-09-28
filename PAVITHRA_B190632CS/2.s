.globl main
.data
    			
    print:  .asciiz "Enter the number : "
    print_n_prime: .asciiz "Not Twin Prime\n"		
    print_prime: .asciiz "Twin prime\n"					
	.text
main:
    li $v0, 4
    la $a0, print
    syscall

    li $v0, 5
    syscall
    move $t5,$v0
    move $a0,$v0       
	jal	is_prime				

	add	$a3, $zero, $v0		

    # second num
    li $v0, 4
    la $a0, print
    syscall

    li $v0, 5
    syscall

    slt $s1,$t5,$v0
    beqz $s1,sub_2

    sub $t3,$v0,$t5
    addi $t4,$zero,2
    beq $t4,$t3,check_2nd
    j print_not_prime
sub_2:
    sub $t3,$t5,$v0
    addi $t4,$zero,2
    beq $t4,$t3,check_2nd
    j print_not_prime
check_2nd:

    move $a0,$v0       # lw	$a0, num
	jal	is_prime
    add	$a1, $zero, $v0
    and $a1,$a3,$a1
    beqz $a1,print_not_prime
	li $v0, 4
    la $a0, print_prime
    syscall
    li	$v0, 10				# exit 
    syscall	

print_not_prime:
    li $v0, 4
    la $a0, print_n_prime
    syscall
    li	$v0, 10				# exit
    syscall	


# $a0	The number to check 
# $v0	1 if  prime, else 0 
is_prime:
	addi	$t0, $zero, 2

    bne $a0,1,is_prime_test		
    add	$v0, $zero, $zero
    jr $ra		
	
is_prime_test:
	slt	$t1, $t0, $a0				
	bne	$t1, $zero, prime_check_loop		
	addi	$v0, $zero, 1				
	jr	$ra						# return 1

prime_check_loop:						
	div	$a0, $t0					
	mfhi	$t3						# t3 = (number % factor)
	slti	$t4, $t3, 1				
	beq	$t4, $zero, prime_check_loop_continue	# if (t4 == 0)
	add	$v0, $zero, $zero				# its not a prime
	jr	$ra							# return 0

prime_check_loop_continue:		
	addi $t0, $t0, 1				# factor++
	j	is_prime_test				# continue the loop