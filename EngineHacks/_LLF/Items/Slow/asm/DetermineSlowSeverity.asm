.thumb

.global DetermineSlowSeverity
.type DetermineSlowSeverity, %function


		DetermineSlowSeverity:
		push	{r4-r5,r14}
		mov		r4, r0 @unit
		ldr		r1, =prGotoResGetter
		mov		lr, r1
		.short	0xF800
		
		mov		r1, #5
		swi		#6 @divide res by 5
		mov		r1, #5
		sub		r5, r1, r0 @Debuff to mov = 5 - targetRes/5
		
		mov		r0, r4
		ldr		r1, =IsDebuffHalfActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		CheckIfNegative
		
			@round up
			add		r5, #1
			lsr		r5, #1
		
		CheckIfNegative:
		cmp		r5, #0
		bge		End
		
			mov		r5, #0
		
		End:
		mov		r0, r5
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

