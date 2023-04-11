

.text

.global main

main:
    @ allocate the stack
    sub sp, sp, #208
    str lr, [sp, #204]


    @ print enter num
    ldr r0, =formatGetNumMsg
    bl printf

    @ get the num
    ldr r0, =formatGetNum
    add r1, sp, #200
    bl scanf
    ldr r4, [sp, #200]

    @ compaer with 0
    cmp r4, #0
    beq exit
    blt invalid

    @ counter
    mov r5, #0

    loop: 
        cmp r5, r4
        bge exit


        @ print get string
        ldr r0, =formatGetString
        mov r1, r5
        bl printf

        @ scan the string
        ldr r0, =formats
        mov r1, sp
        bl scanf

        @ print the string for output
        ldr r0, =formatOutput
        mov r1, r5
        bl printf

        @ print the reverse string
        mov r0, sp
        bl printReverse

        add r5, r5, #1
        b loop

    b exit

    @ print enter num
    ldr r0, =format
    bl printf

    @ invalid input
    invalid:
        ldr r0, =formatInvalid
        bl printf

    exit:

    @ stack handling (pop lr from the stack) and return
    mov r0, #0
    ldr lr, [sp, #204]
    add sp, sp, #208
    mov pc, lr


 @ function to get the reverse
printReverse:
    sub sp, sp, #12
    str lr, [sp, #0]
    str r4, [sp, #4]
    str r5, [sp, #8]

    mov r4, #0
    mov r5, r0

    loop2:
        ldrb r12, [r5, r4]
        cmp r12, #0
        beq myPrint

        add r4, r4, #1
        b loop2

    myPrint:
        sub r4, r4, #1
        loop3:
            cmp r4, #0
            blt exitFn

            ldr r0, =formatChar
            ldrb r1, [r5, r4]
            bl printf

            sub r4, r4, #1
            b loop3

    
    exitFn:
        ldr r0, =formatEndln
        bl printf

    
    ldr lr, [sp, #0]
    ldr r4, [sp, #4]
    ldr r5, [sp, #8]
    add sp, sp, #12
    mov pc, lr



.data
formatGetNumMsg: .asciz "Enter the number of strings :\n"
formatGetNum: .asciz "%d"
formatInvalid: .asciz "Invalid number\n"
formatGetString: .asciz "Enter the input string %d :\n"
formats: .asciz "%s"
formatp: .asciz "%c\n"
formatOutput: .asciz "Output string %d is :\n"
formatChar: .asciz "%c"
formatEndln: .asciz "\n"

format:.asciz "%d\n"

