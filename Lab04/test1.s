
    .text

    .global main

main:
    @ allocate the stack
    sub sp, sp, #208
    str lr, [sp, #200]

    ldr r0, =formatD
    add r1, sp, #204
    bl scanf

    @ ldr r0, =formatD
    @ ldr r1, [sp, #204]
    @ bl printf

    ldr r0, =formatC
    add r1, sp, #204
    bl scanf


    ldr r0, =formatsIn
    mov r1, sp
    bl scanf

    ldr r0, =formatsOut
    mov r1, sp
    bl printf


    @ stack handling (pop lr from the stack) and return
    mov r0, #0
    ldr lr, [sp, #200]
    add sp, sp, #208
    mov pc, lr


@ myScan: 
@     sub sp, sp, #4
@     str lr, [sp, #0]

@     mov r12, r0

@     scanLoop:
@         ldr r0, =formatChar
@         mov r2, r12
@         bl scanf

@         ldrb r3, [r12, #0]
        
@         ldr r0, =formatChar
@         mov r1, r3
@         bl printf

@         cmp r3, #0
@         beq exitScan

@         add r12, r12, #1
@         b scanLoop

@     exitScan:

@     ldr lr, [sp, #0]
@     add sp, sp, #4
@     mov pc, lr


    .data
formatD: .asciz "%d"
formatC: .asciz "%c"
formatsOut: .asciz "%s\n"
formats: .asciz "%c"
formatsIn: .asciz "%[^\n]%*c"


