.text 
.align 2 
.globl main 


main: # this program prints out the largest two of three numbers input 
	li $s1, 1 # i
	li $t8, 2
	li $t2, 1
	li $v0, 4 
	la $a0, prompt1 
	syscall 

	li $v0, 5 # read keyboard into $v0 (number x is number to test) 
	syscall 
	move $t0,$v0 # operation code

	beq $t0, 7, exit

	li $v0, 4 
	la $a0, prompt2 
	syscall 

	li $v0, 5 # read keyboard into $v0 (number x is number to test) 
	syscall 
	move $t3,$v0 # a
	move $s3, $t3
	li $v0, 4 
	la $a0, prompt3 
	syscall 

	li $v0, 5 # read keyboard into $v0 (number x is number to test) 
	syscall 
	move $t4,$v0 # b

	li $v0, 4 
	la $a0, prompt4 
	syscall 

	li $v0, 5 # read keyboard into $v0 (number x is number to test) 
	syscall 
	move $t5,$v0 # n

	beq $t0, 1, add_f
	beq $t0, 2, sub_f
	beq $t0, 3, mul_f
	beq $t0, 4, exp_f
	beq $t0, 5, inv_f
	beq $t0, 6, dislog_f
	beq $t0, 7, exit_f


add_f:
	add $t1, $t3, $t4
	div $t1, $t5
	mfhi $t2 # add modulo

	li $v0, 4 # print answer 
	la $a0, ans 
	syscall 

	li $v0, 1 # print integer function call 1 
	move $a0, $t2 # integer to print 
	syscall 

	li $v0, 4 # print answer 
	la $a0, endl 
	syscall 


	j main

sub_f:
	sub $t1, $t3, $t4
	div $t1, $t5
	mfhi $t2 # add modulo

	li $v0, 4 # print answer 
	la $a0, ans 
	syscall 

	li $v0, 1 # print integer function call 1 
	move $a0, $t2 # integer to print 
	syscall 

	li $v0, 4 # print answer 
	la $a0, endl 
	syscall 


	j main

mul_f:
	mul $t1, $t3, $t4
	div $t1, $t5
	mfhi $t2 # add modulo

	li $v0, 4 # print answer 
	la $a0, ans 
	syscall 

	li $v0, 1 # print integer function call 1 
	move $a0, $t2 # integer to print 
	syscall 

	li $v0, 4 # print answer 
	la $a0, endl 
	syscall 


	j main

exp_f:
	move $t6, $t4 # i


	li $t2, 1     # res
	div $t3, $t5
	mfhi $t3
	j loop

loop:
	ble $t6, 0, exit_loop
	div $t6, $t8
	mfhi $t7
	beq $t7, 1, odd_loop
	beq $t7, 0, even_loop

odd_loop:
	div $t3, $t5
	mfhi $t9
	mul $t2, $t2, $t9
	div $t2, $t5
	mfhi $t2
	addi $t6, $t6, -1
	j loop

even_loop:
	mul $t3, $t3, $t3
	div $t3, $t5
	mfhi $t3
	div $t6, $t8
	mflo $t6 
	j loop 

exit_loop:
	li $v0, 4 # print answer 
	la $a0, ans 
	syscall 

	li $v0, 1 # print integer function call 1 
	move $a0, $t2 # integer to print 
	syscall 

	li $v0, 4 # print answer 
	la $a0, endl 
	syscall 

	j main	

inv_f:
	# addi $s5, $t5, -1
	beq $s1, $t5, no_soln
	mul $s6, $t3, $s1
	div $s6, $t5
	mfhi $s7
	beq $s7, 1, ans_return
	addi $s1, $s1, 1
	j inv_f
ans_return:
	li $v0, 4 # print answer 
	la $a0, ans 
	syscall 

	li $v0, 1 # print integer function call 1 
	move $a0, $s1 # integer to print 
	syscall 

	li $v0, 4 # print answer 
	la $a0, endl 
	syscall 

	j main

dislog_f:
	move $t6, $s1 
	li $t2, 1    # res
	div $t3, $t5
	mfhi $t3
	j loop2

loop2:
	ble $t6, 0, exit_loop2
	div $t6, $t8
	mfhi $t7
	beq $t7, 1, odd_loop2
	beq $t7, 0, even_loop2

odd_loop2:
	div $t3, $t5
	mfhi $t9
	mul $t2, $t2, $t9
	div $t2, $t5
	mfhi $t2
	addi $t6, $t6, -1
	j loop2

even_loop2:
	mul $t3, $t3, $t3
	div $t3, $t5
	mfhi $t3
	div $t6, $t8
	mflo $t6 
	j loop2 

exit_loop2:
	div $t4, $t5
	mfhi $s0

	div $s3, $t5
	mfhi $s2
# 	bne $s1, 1, check_no_soln 
# 	j exit_loop2_part2

# exit_loop2_part2:
	bne $t2, $s0, reiter_f

	li $v0, 4 # print answer 
	la $a0, ans 
	syscall 

	li $v0, 1 # print integer function call 1 
	move $a0, $s1 # integer to print 
	syscall 

	li $v0, 4 # print answer 
	la $a0, endl 
	syscall 

	j main	

# check_no_soln:
# 	beq $t2, $s2, no_soln

# 	li $v0, 4 # print answer 
# 	la $a0, check 
# 	syscall

# 	j exit_loop2_part2

reiter_f:
	addi $s1, $s1, 1

	beq $s1, $t5, no_soln 
	j dislog_f

no_soln:
	li $v0, 4 # print answer 
	la $a0, no_solution 
	syscall 

	li $v0, 4 # print answer 
	la $a0, endl 
	syscall 

	j main	


exit:
	li $v0, 10
	syscall

.data 

prompt1: .asciiz "Enter operation code (1-add, 2-subtract, 3-multiply, 4-exponentiation,
5-inversion, 6-logarithm, 7-exit): " 
prompt2: .asciiz "Enter a: "
prompt3: .asciiz "Enter b: "
prompt4: .asciiz "Enter n: "
ans: .asciiz "Result = "
endl: .asciiz"\n"
no_solution: .asciiz "Result = No Solution"
check: .asciiz "Not equal--\n"