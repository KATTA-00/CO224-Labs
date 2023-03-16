@ ARM Assembly - exercise 5
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]
	
	@ Write YOUR CODE HERE
	
	@ j=0;
	@ for (i=0;i<10;i++)
	@ 		j+=i;	
	
	@ Put final j to r5

	@ ---------------------

	@ initailize r5
	mov r5, #0

	@ start r0 from 0
	mov r0, #0
	@ loop label
	loop:
		@ compare r0 and 10
		cmp r0, #10
		@ if r0 >= 10, break the loop
		bge exit

		@ j+=i;	
		add r5, r5, r0
		@ increment r0
		add r0, r0, #1
		b loop

	@ exit label
	exit:
	
	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 45 if correct)\n"

