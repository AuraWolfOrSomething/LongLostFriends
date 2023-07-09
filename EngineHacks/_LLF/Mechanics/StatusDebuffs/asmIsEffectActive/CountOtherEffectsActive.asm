.thumb

.global CountOtherEffectsActive
.type CountOtherEffectsActive, %function


		CountOtherEffectsActive:
		push	{r4-r6,r14}
		mov		r4, r0 @unit
		mov		r5, #0 @number of other effects
		ldr		r6, =OtherEffectCheckingList
			
		LoopThroughList:
		ldr		r1, [r6]
		cmp		r1, #0
		beq		End
		
			mov		r0, r4
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			beq		NextEntry
			
				add		r5, #1
			
				NextEntry:
				add		r6, #4
				b		LoopThroughList
		
		End:
		mov		r0, r5
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

