.thumb

.global RestoreClearDebuffs
.type RestoreClearDebuffs, %function


		RestoreClearDebuffs:
		push	{r4-r5,r14}
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		
		mov		r4, #0xFF
		ldr		r5, =UnitDebuffEntryList
		
		LoopThroughList:
		ldrb	r1, [r5]
		cmp		r1, #0xFF
		beq		End
		
			ldrb	r2, [r5,#1]
			eor		r2, r4
			ldrb	r3, [r0,r1]
			and		r3, r2
			strb	r3, [r0,r1]
			add		r5, #2
			b		LoopThroughList
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

