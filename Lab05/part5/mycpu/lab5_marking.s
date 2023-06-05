loadi 0 0x20   // r4 = 5
loadi 1 0x01   // r1 = 9
sll 2 1 0x05
srl 3 0 0x02
bne 0x01 1 0
loadi 2 0x01   // r1 = 9
beq 0x08 1 2
j 0x03
beq 0x02 1 2
mult 2 1 0
mov 2 1        // r2 = r1
add 3 2 0      // r3 = r2 + r0
sub 4 3 1      // r4 = r3 + r1
loadi 0 0x75   // r0 = 0x75
loadi 1 0x92   // r1 = 0x92
and 5 1 0      // r5 = r1 & r0
or 6 5 2       // r6 = r5 | r2
and 5 1 2      // r5 = r1 & r0
