.thumb

.include "../AiDefinitions.s"

.global AiCh3Spectate
.type AiCh3Spectate, %function


		AiCh3Spectate:
		push	{r14}
		ldr		r0, =gActiveUnitId
		ldrb	r0, [r0]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		
		@Units that aren't Ch 3 guards can always attack player units
		ldr		r0, [r0]
		ldrb	r0, [r0,#4]
		ldr		r1, =Ch3GuardIdLinkAi
		ldrb	r1, [r1]
		cmp		r0, r1
		bne		ValidTarget
		
			@If active unit is a guard, only attack if player units have already attacked a guard
			ldr		r0, =Ch3GuardAggressionIdLinkAi
			ldrh	r0, [r0]
			ldr		r1, =CheckEventId
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			bne		ValidTarget
			
				mov		r0, #0
				b		End
		
		ValidTarget:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

