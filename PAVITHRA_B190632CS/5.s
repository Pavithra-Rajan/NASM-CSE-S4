.globl main
.data
    print1:    .asciiz "Enter the sentence: "            
    print2:    .asciiz "Enter the word you want to search: "   
    print3:    .asciiz "Enter the word you want to replace with: " 
    print4:    .asciiz "The word is not present.\n"
    print5:    .asciiz "The sentence was: "
    print6:    .asciiz "\nThe modified sentence is: "
    buf1:      .space 256                     # sentence
    str_copy:  .space 256                     # copy_sear of the sentence
    input:     .space 25                      # word to search
    copy_sear: .space 25                      # copy_sear word to search
    replace:   .space 25                      
    next_line: .asciiz "\n"

.text
main:


    li $v0,4    
    la $a0,print1
    syscall

    la $a0,buf1
    li $a1,256          # allocate 256 empty space
    li $v0,8
    syscall

    la $s5,str_copy     # load the the base address of the str_copy

    li $v0,4
    la $a0,print2       # word to search for
    syscall

    la $a0,input
    li $a2,25          # create 25 empty spaces
    li $v0,8
    syscall
    move $s2,$a0               

    li $v0,4
    la $a0,print3      # word to replace
    syscall

    la $a0,replace
    li $a2,25
    li $v0,8
    syscall
    move $s4,$a0               

    li $t5,10               
    la $s0,copy_sear             
    la $s1,buf1             
    li $t4,1                # to count letters in word to search
    li $t7,0                # for multiple occurences



# letters in word to search
    lb $t6,0($s2)               
    count_search:
        beq $t6,10,count_rep
        addi $s2,$s2,1
        lb $t6,0($s2)
        addi $t4,$t4,1
    j count_search



# length of replace word
    count_rep :
        la $s4,replace
        li $t1,1
        lb $t3,0($s4)               
            loop1:
                beq $t3,10,reset
                addi $s4,$s4,1
                lb $t3,0($s4)
                addi $t1,$t1,1
            j loop1 
  
    reset:
    li $t6,1                # length of extracted word
    la $s2,input            
    lb $t0,0($s1)          

    j word_ext


    store_rep:             
        la $s4,replace
        li $t0,1
    loop_store:
        beq $t0,$t1,restore_2
            lb $t2,0($s4)
            sb $t2,0($s5)
            addi $t0,$t0,1
            addi $s4,$s4,1
            addi $s5,$s5,1
    j loop_store
    j restore_2


    orig_word:
        li $t0,1
        la $s0,copy_sear
    loop_old:
        beq $t0,$t6,restore_2
            lb $t2,0($s0)
            sb $t2,0($s5)
            addi $t0,$t0,1
            addi $s0,$s0,1
            addi $s5,$s5,1
        j loop_old
     
    restore_2:

        la $s4,replace
        lb $t0,0($s1)
        beq $t0,10,final_print
        la $s0,copy_sear
        li $t6,1
        addi $s1,$s1,1
        lb $t0,0($s1)
        sb $t8,0($s5)
        addi $s5,$s5,1


# word_ext each word from the sentence and store in copy_sear
    word_ext:
        lb $t8,0($s1)
        beq $t0,32,checker
        beq $t0,10,checker
       
        sb $t0,0($s0)
        addi $t6,$t6,1
        addi $s0,$s0,1
        addi $s1,$s1,1
        lb $t0,0($s1)
    j word_ext



# Compare the extracted word and the word to be searched
    checker:
        sb $t5,0($s0)
        la $s2,input
        la $s0,copy_sear
        lb $t2,0($s2)
        lb $t3,0($s0)
        bne $t6,$t4,orig_word
        li $s7,0
    check:
        bne $t2,$t3,check_case
        loop_back:
        addi $s7,$s7,1
        beq $s7,$t4,occur
        addi $s2,$s2,1
        addi $s0,$s0,1
        lb $t2,0($s2)
        lb $t3,0($s0)

    j check


# check with toggle case
    check_case:
        addi $t3,$t3,32
        addi $t0,$t3,-64
        beq $t2,$t3,loop_back
        beq $t2,$t0,loop_back
        j orig_word


# count the occurences    
    occur:

    addi $t7,$t7,1
    j store_rep    

    final_print:

    beq $t7,0,not_present_print
        
        li $v0,4
        la $a0,next_line
        syscall

        li $v0,4
        la $a0,print5
        syscall

        li $v0,4
        la $a0,buf1
        syscall

        li $v0,4
        la $a0,print6
        syscall

        li $v0,4
        la $a0,str_copy
        syscall

        j end

    not_present_print:
        li $v0,4
        la $a0,print4
        syscall
        li $v0,4
        la $a0,print5
        syscall
        li $v0,4
        la $a0,buf1
        syscall
        j end

    # exit
        end:
        li $v0,10
        syscall