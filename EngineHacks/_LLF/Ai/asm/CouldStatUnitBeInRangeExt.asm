.thumb

.global CouldStatUnitBeInRangeExt
.type CouldStatUnitBeInRangeExt, %function


		CouldStatUnitBeInRangeExt:
		push	{r4,r14}
		mov		r4, #0
		
		@if target isn't in range, don't need to check for exceptions
		cmp		r2, r1
		bgt		End
		
			ldr		r1, =CouldStatUnitBeInRangeExt
			ldr		r2, =AiTargetExceptionCheck
			mov		lr, r2
			.short	0xF800
			mov		r4, r0
		
		End:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

