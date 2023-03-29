@ ARM Assembly - lab 3.2 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	

gcd:
    sub sp, sp, #4
    str lr, [sp, #0]
    
    cmp r1, #0
    beq else

    mov r12, r0

    loop:
        cmp r12, #0
        blt exit

        sub r12, r12, r1
        b loop

    exit:
        add r12, r12, r1

    mov r0, r1
    mov r1, r12

    bl gcd

    ldr lr, [sp, #0]
    add sp, sp, #4
    mov pc, lr

    else:
        ldr lr, [sp, #0]
        add sp, sp, #4
        mov pc, lr


my_print:

    sub sp, sp, #20
    str r0, [sp, #0]
    str r1, [sp, #4]
    str r2, [sp, #8]
    str lr, [sp, #12]
    str r12, [sp, #16]
    
    mov r12, r1

	mov r1, r0
	mov r2, r12
    ldr r0, =my_format
	bl printf

    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    ldr r2, [sp, #8]
    ldr lr, [sp, #12]
    ldr r12, [sp, #16]

    add sp, sp, #20
    mov pc, lr
	

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a
	mov r5, #24 	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "gcd(%d,%d) = %d\n"
my_format: .asciz "%d %d\n"


