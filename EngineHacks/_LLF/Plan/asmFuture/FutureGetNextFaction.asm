.thumb

.include "../PlanDefs.s"

.global FutureGetNextFaction
.type FutureGetNextFaction, %function


		FutureGetNextFaction:
		push	{r4,r14}
		mov		r4, r0
		add		r4, #0x29 @phase to search for
		
		@Get the next phase to search for
		ldrb	r0, [r4]
		ldr		r1, =GetNextFactionPhase
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		bne		NotPlayerPhase
		
			ldr		r3, =gChapterData
			ldrh	r1, [r3,#0x10]
			ldr		r2, =TurnLimit
			cmp		r1, r2
			bhi		StoreSearchedFaction
			
				add		r1, #1
				strh	r1, [r3,#0x10]
				b		StoreSearchedFaction
		
		NotPlayerPhase:
		ldrb	r0, [r0]
		
		StoreSearchedFaction:
		strb	r0, [r4]
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

