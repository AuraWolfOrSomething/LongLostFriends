.thumb

.global CountAllBuffsActive
.type CountAllBuffsActive, %function


		CountAllBuffsActive:
		push	{r4-r6,r14}
		mov		r4, r0 @unit
		mov		r5, #0 @number of buffs
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldr		r0, [r0,#4]
		ldr		r1, =AnyBuffsBitfieldLink
		ldr		r1, [r1]
		tst		r0, r1
		beq		End
		
			ldr		r6, =BuffCheckingList
			
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

