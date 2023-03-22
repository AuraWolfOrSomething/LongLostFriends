.thumb

.global CheckIfReceivingSupportBonuses
.type CheckIfReceivingSupportBonuses, %function


		CheckIfReceivingSupportBonuses:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, r1
		
		@Check if support partner is active support
		  @If not, no bonuses
		ldr		r1, [r1]
		ldrb	r1, [r1,#4]
		ldr		r3, =IsSupportActive
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r0, r4
			mov		r1, r5
			ldr		r3, =GetDistance
			mov		lr, r3
			.short	0xF800
			mov		r6, r0
			
			mov		r0, r4
			ldr		r3, =CalculateSupportBonusRange
			mov		lr, r3
			.short	0xF800
		
			cmp		r0, r6
			blt		NotInRange

				mov		r0, #1
				b		End
		
		NotInRange:
		mov		r0, #0
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

