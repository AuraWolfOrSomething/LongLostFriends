.thumb

.global CountActiveEffects
.type CountActiveEffects, %function


		CountActiveEffects:
		push	{r4-r6,r14}
		mov		r4, r0 @unit
		mov		r5, #0 @number of effects
		ldr		r6, =IsEffectActiveList
		
		LoopThroughList:
		ldr		r1, [r6]
		cmp		r1, #0
		beq		End
		
			mov		r0, r4
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			beq		NextEntry
			
				add		r5, r0
			
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

