
.thumb

.include "../CommonDefinitions.inc"
.include "../Internal/Definitions.s"

MMBDrawLevelNumber:

	.global	MMBDrawLevelNumber
	.type	MMBDrawLevelNumber, %function

	.set MMBLevelX,	EALiterals + 0
	.set MMBLevelY,	EALiterals + 4
	.set MMBHeight,				EALiterals + 8

	@ Inputs:
	@ r0: pointer to proc state
	@ r1: pointer to unit

	push	{r4-r7, lr}

	mov		r4, r0
	mov		r5, r1

	@ Check if we're on a unit to avoid
	@ bad number drawing

	mov		r0, r4
	add		r0, #UnitFlag

	ldrb	r0, [r0]
	cmp		r0, #0x00
	bne		End

	mov		r0, r5
	cmp		r0, #0x00
	beq		End
	
	@Check if negative status is effective
		@if not, skip status and debuff checks
	mov		r0, r5
	ldr		r1, =AreNegativeStatusesEffective
	mov		lr, r1
	bllr
	cmp		r0, #0
	beq		GetNumberPositions
	  
		@Check if status is already being drawn
			@if so, skip this
		mov		r0, #0x30
		ldrb	r0, [r5,r0]
		cmp		r0, #0
		bne		End
		
		@Check if debuff is already being drawn
			@if so, skip this
		mov		r0, r5
		ldr		r1, =GetDebuffs
		mov		lr, r1
		bllr
		ldr		r0, [r0]
		ldr		r1, =AnyDebuffsBitfieldLink
		ldr		r1, [r1]
		tst		r0, r1
		bne		End

	@ Get positions for numbers
	GetNumberPositions:
	ldr		r6, MMBLevelX
	ldr		r7, MMBLevelY

	@ check for lower window

	mov		r0, r4
	add		r0, #WindowPosType
	ldrb	r0, [r0]
	lsl		r0, r0, #0x03
	ldr		r1, =WindowSideTable
	add		r0, r1, r0
	mov		r1, #0x03
	ldsb	r0, [r0, r1] @ -1 top 1 bottom
	cmp		r0, #0x00
	blt		SkipBottom

	ldr		r0, MMBHeight
	mov		r1, #20
	sub		r1, r1, r0

	lsl		r1, r1, #0x03
	add		r7, r7, r1

SkipBottom:

	mov		r0, r5
	ldrb	r2, [r0, #0x08]

	mov		r0, r6
	mov		r1, r7

	ldr		r3, =MMBDrawUnsignedNumber
	mov		lr, r3

	bllr

End:

	pop		{r4-r7}
	pop		{r0}
	bx		r0

.ltorg

EALiterals:
	@ MMBLevelX
	@ MMBLevelY
	@ MMBHeight
