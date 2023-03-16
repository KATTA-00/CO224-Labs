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

	@ initailize r0 ad 0
	mov r5, #0

	@ r0 -> i and initialize it 0
	mov r0, #0
	outerLoop:
		@ compare r0 and 10
		cmp r0, #10
		@ if r0 >= 10, exit the outer loop
		bge exitOuter

		@ r1 -> j and initialize it 5
		mov r1, #5
		innerLoop:
			@ compare r1 and 15
			cmp r1, #15
			@ if r1 >= 15, exit the inner loop
			bge exitInner

			@ get i + j and store in r2
			add r2, r0, r1
			@ compare r2 and 10
			cmp r2, #10
			@ if i + j >= 10, go to else label
			bge else

			@ if i + j < 10
			add r5, r5, r0, lsl #1
			b exit

			else:
				@ sum+=i*2
				and r2, r0, r1
				add r5, r5, r2

			exit:

			@ increment j by 1
			add r1, r1, #1
			b innerLoop

		exitInner:

		@ increment i by 1
		add r0, r0, #1
		b outerLoop

	exitOuter:	
	
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

