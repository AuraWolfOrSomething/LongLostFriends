@Originally at 188A8
.thumb
@This should do what the code in place did

.global ProcessDebuffs
.type ProcessDebuffs, %function

ProcessDebuffs:
push	{r4,r14}
@cmp     r0,#0x0
@beq     noBarrier
@lsr     r1,r2,#0x4
@sub     r1,#0x1
@lsl     r0,r1,#0x4
@noBarrier:
@mov     r1,#0xF
@and     r1,r2
@cmp r1, #0x0
@beq noTorch
@sub r1, #0x1
@mov r2, #0x1
@mov r8, r2
@noTorch: 
@orr r0, r1
@mov r3, r4
@add     r3,#0x31
@strb r0, [r3]

@Now the debuffs
@mov r0,r4
@ldr r3, GetUnitDebuffs
@bl BXR3
ldr r1, =GetDebuffs
mov lr,r1
.short 0xF800

mov r3,r0
ldr r2, [r3]
mov r0, #0x0
@push {r4}
@mov r4, #0x0    @r4 = acc

@Do not remove Absorb debuff
ldrb r4, [r3,#3]    @r4 = acc
lsl r4, #24

processDebuffLoop:
mov r1, #0xF    @One debuff nibble
lsl r1, r0
and r1, r2
cmp r1, #0x0
beq noDebuff
lsr r1, r0
sub r1, #0x1    @decrement if there
lsl r1, r0
orr r4, r1
noDebuff: 
add r0, #0x4    @next nibble
cmp r0, #0x0C @anything in the third byte is automatically cleared (debuffs with a one turn duration)
ble processDebuffLoop
str r4, [r3]    @Store processed debuffs/no rallies

@Now the buffs
ldrh r2, [r3,#4]
mov r0, #0
mov r4, #0

processBuffLoop:
mov r1, #0xF    @One buff nibble
lsl r1, r0
and r1, r2
cmp r1, #0x0
beq noBuff
lsr r1, r0
sub r1, #0x1    @decrement if there
lsl r1, r0
orr r4, r1
noBuff: 
add r0, #4    @next nibble
cmp r0, #4 @anything in the second byte is automatically cleared (buffs with a one turn duration)
ble processBuffLoop
strh r4, [r3,#4]

pop {r4}
@ldr r3, ReturnLocation

pop {r0}
bx r0

@BXR3:
@bx r3

.align
.ltorg

@ReturnLocation:
    @.long 0x80188E1
@GetUnitDebuffs:
    @Handled by installer
