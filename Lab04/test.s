
	.text	@ instruction memory
	
	.global main
main:

	sub	sp, sp, #8
	str	lr, [sp, #4]


    ldr r0, =formats
    mov r1, sp
    bl scanf

    ldrb r0, [sp, #0]

    ldr r0, =formats
    mov r1, r0
    bl printf

	
	ldr	lr, [sp, #4]
	add	sp, sp, #8
	mov	pc, lr		
	
	
	.data	@ data memory
formats: .asciz "%c"
