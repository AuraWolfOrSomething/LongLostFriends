.thumb

.include "../AiDefinitions.s"

.global NewAiUnitAtPosDifFac
.type NewAiUnitAtPosDifFac, %function


		NewAiUnitAtPosDifFac:
		push	{r4,r14}
		mov		r4, r3
		ldr		r2, =gMapUnit
		ldr		r2, [r2]
		
		@Check if there's a unit at position
		  @If not, skip
		lsl		r1, #2
		add		r1, r2
		ldr		r1, [r1]
		add		r1, r0
		ldrb	r0, [r1]
		cmp		r0, #0
		beq		End
		
		@Check if units are of a different allegiance
		  @If not, skip
		ldr		r2, =gActiveUnitId
		ldrb	r2, [r2]
		eor		r2, r0
		mov		r1, #0x80
		tst		r2, r1
		beq		NotValidTarget

		@Get unit ID
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		mov		r1, r4
		ldr		r3, =AiTargetExceptionCheck
		mov		lr, r3
		.short	0xF800
		b		End

		NotValidTarget:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1

