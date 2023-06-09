
.thumb

.include "../CommonDefinitions.inc"
.include "../Internal/Definitions.s"

MMBDrawAI:

	.global	MMBDrawAI
	.type	MMBDrawAI, %function

	.set MMBTextWidth,			EALiterals +  0
	.set MMBTextColor,			EALiterals +  4
	.set MMBNameXCoordinate,	EALiterals +  8
	.set MMBNameYCoordinate,	EALiterals + 12
	.set AiToggleEventIDLink,	EALiterals + 16
	.set CheckEventID,			EALiterals + 20
	.set FindTextIdForAi,		EALiterals + 24
	
	push	{r4-r7,r14}
	
	add		r0, #NameTextStructStart
	mov		r4, r0
	mov		r5, r1
	
	@If player unit, don't draw AI
	ldrb	r0, [r5,#0x0B]
	lsr		r0, #6
	cmp		r0, #0
	beq		End
	
	@Check if displaying AI is set
	ldr		r0, AiToggleEventIDLink
	ldrb	r0, [r0]
	ldr		r1, CheckEventID
	mov		lr, r1
	bllr
	cmp		r0, #0
	beq		End
	
	mov		r0, r5
	ldr		r1, FindTextIdForAi
	mov		lr, r1
	.short	0xF800
	
	@Write text
	ldr		r1, =TextBufferWriter
	mov		r14, r1
	bllr

	@ save resulting width for later

	mov		r6, r0
	mov		r1, r0

	ldr		r0, MMBTextWidth @ multiplied by 8 in EA
	ldr		r2, =GetStringTextCenteredPos
	mov		r14, r2
	bllr

	@ save resulting padding distance

	mov		r7, r0

	@ clear an area in VRAM for text

	mov		r0, r4
	ldr		r1, =TextClear
	mov		r14, r1
	bllr

	@ we write the text info to the proc state

	mov		r0, r4
	mov		r1, r7
	ldr		r2, MMBTextColor

	ldr		r3, =TextSetParameters
	mov		r14, r3
	bllr

	@ Write name

	mov		r0, r4
	mov		r1, r6

	ldr		r2, =TextAppendString
	mov		r14, r2
	bllr

	@ write tilemap

	ldr		r1, =WindowBuffer
	ldr		r2, MMBNameXCoordinate
	ldr		r3, MMBNameYCoordinate
	lsl		r3, r3, #0x06
	lsl		r2, r2, #0x01
	add		r2, r2, r3
	add		r1, r1, r2
	mov		r0, r4
	ldr		r2, =TextDraw
	mov		r14, r2
	bllr
	
	End:
	pop		{r4-r7}
	pop		{r0}
	bx		r0

.ltorg

EALiterals:

