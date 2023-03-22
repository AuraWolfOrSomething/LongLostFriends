.thumb

.global ExperienceForSurvival
.type ExperienceForSurvival, %function


		ExperienceForSurvival:
		push	{r4,r14}
		mov		r4, r0 @player unit
		mov		r0, #1
		
		@Load class id of player unit
		ldr		r2, [r4,#4]
		ldrb	r2, [r2,#4]
		ldr		r3, =SurvivalBonusExpClassList
		
		@Check if class id is on list
		LoopThroughList:
		ldrb	r1, [r3]
		cmp		r1, #0
		beq		ReturnEXP
		
			add		r3, #1
			cmp		r1, r2
			bne		LoopThroughList
		
		@Set base exp
		mov		r0, #20
		
		ReturnEXP:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

