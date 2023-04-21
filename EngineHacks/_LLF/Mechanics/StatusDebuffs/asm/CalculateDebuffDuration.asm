.thumb

.global CalculateDebuffDuration
.type CalculateDebuffDuration, %function


		CalculateDebuffDuration:
		push	{r14}
		ldr		r1, =prGotoResGetter
		mov		lr, r1
		.short	0xF800
		
		@Debuff duration = 5 - targetRes/5
		mov		r1, #5
		swi		#6 @divide res by 5
		mov		r1, #5
		sub		r0, r1, r0
		
		@Do not return negative value
		cmp		r0, #0
		bge		End
		
			mov		r0, #0
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

