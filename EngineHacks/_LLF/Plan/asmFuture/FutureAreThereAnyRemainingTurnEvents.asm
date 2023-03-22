.thumb

.include "../PlanDefs.s"

.global FutureAreThereAnyRemainingTurnEvents
.type FutureAreThereAnyRemainingTurnEvents, %function


		FutureAreThereAnyRemainingTurnEvents:
		push	{r4,r14}
		mov		r4, r0
		
		ldr		r0, =FutureCheckForRemainingTurnEvents
		mov		lr, r0
		.short	0xF800
		cmp		r0, #0
		bne		End
		
			mov		r0, r4
			mov		r1, #2
			ldr		r2, =ProcGoto
			mov		lr, r2
			.short	0xF800
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

