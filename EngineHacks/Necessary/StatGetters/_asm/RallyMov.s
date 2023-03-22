.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddRallyMov:
push {r4-r6, lr}
mov r4, r0 @stat
mov r5, r1 @unit
ldr r6, EALiterals
ldrb r1, [r5 ,#0xB]     @Deployment number
lsl r1, r1, #0x3    @*8
add r6, r1          @r0 = *debuff data

@Rally Bonus
@LO byte of the 3rd byte
ldrb r1, [r6, #0x5]
@mov r0, #0x40
mov r0, #0x01 @since other rallies are commented, this is considered the first rally (so check if first bit is set instead of 7th bit)
and r0, r1
cmp r0, #0x0
beq noMovRally
add r4, #0x2 @+2 move
noMovRally:

End:
mov r0, r4
mov r1, r5
pop {r4-r6,pc}
.ltorg
.align

EALiterals:
@POIN DebuffTable
