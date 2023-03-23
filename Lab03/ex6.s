@ ARM Assembly - exercise 6 
@ Group Number :

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	

fact:
	sub sp, sp, #4
	str r4, [sp, #0]

	mov r4, r0
	mov r0, #1

	loop :
		cmp r4, #1
		blt exit

		mul r0, r4, r0
		sub r4, r4, #1
		b loop

	exit:
		ldr r4, [sp, #0]
		add sp, sp, #4

		mov pc, lr


@ ---------------------	

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "Factorial of %d is %d\n"

