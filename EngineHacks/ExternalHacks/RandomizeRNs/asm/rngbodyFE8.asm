.thumb

.global RNGBodyFE8
.type RNGBodyFE8, %function

.equ AttackerData, 0x0203A4EC
.equ gChapterData, 0x0202BCF0
.equ gMovementFillConfig, 0x03004E60
.equ gpMainCallback, 0x02024CB8

.equ NextRN_100, 0x08000C64|1
.equ RandomizerReturnTo, 0x08001342|1


RNGBodyFE8:
pop {r3}

ldr r0, =AttackerData
ldr r0, [r0]
cmp r0, #0x00000000
beq or1

and1:
ldr r0, =gChapterData
ldrb r0, [r0, #0x0F]
ldr r1, =AfterPlaythroughStatsRAMPointer
ldr r1, [r1]

cmp r0, #0x00
@bne ReturnSequence
beq GoToNextRN_100

ldrb r2, [r1,#7]
cmp r2, #0
bne ReturnSequence

	@If 0, this is the "initial run"; burn up to x rns 
	ldrb	r2, [r1]
	mov		r0, #50 @arbitary value (I went with enemy unit cap)
	sub		r0, r2
	cmp		r0, #0
	ble		ReturnSequence

GoToNextRN_100:
@keep track of how many times rns are randomized
ldrb r0, [r1]
cmp r0, #0xFF
bge RandomNumberNoCounterIncrement

add r0, #1
strb r0, [r1]

RandomNumberNoCounterIncrement:
ldr r0, =NextRN_100
bl bxr0

b ReturnSequence

or1:
ldr r0, =gMovementFillConfig
ldrb r0, [r0,#0x0A]
cmp r0, #0x00
bne and1

ReturnSequence:
@overwritten code
ldr r0, =gpMainCallback
ldr r0, [r0]
cmp r0, #0x0
beq Return
bl bxr0

Return:
ldr r0, =RandomizerReturnTo
bx r0

bxr0:
bx r0

.align 4
.ltorg

