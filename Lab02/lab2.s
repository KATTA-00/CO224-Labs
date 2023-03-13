@ ARM Assembly - lab 2
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------

	mov r5, #0
	mov r0, #0

	loop1:
		cmp r0, #10
		bge exit

		mov r1, #5

		loop2:
			cmp r1, #15
			bge next

			
			add r2, r0, r1
			cmp r2, #10
			bge else

			add r5, r5, r0, lsl #1
			b exitIf

			else:
				and r3, r0, r1
				add r5, r5, r3


			exitIf:

			add r1, r1, #1
			b loop2


		next:

		add r0, r0, #1
		b loop1


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
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

