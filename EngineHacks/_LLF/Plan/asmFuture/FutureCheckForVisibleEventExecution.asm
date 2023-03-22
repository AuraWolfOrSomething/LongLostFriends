.thumb

.include "../PlanDefs.s"

.global FutureCheckForVisibleEventExecution
.type FutureCheckForVisibleEventExecution, %function


		FutureCheckForVisibleEventExecution:
		push	{r14}
		
		@If player phase check hasn't happened yet, stay in the loop
		mov		r1, #0x29
		ldrb	r1, [r0,r1]
		cmp		r1, #0
		bne		End
		
			@If at least one visible event hasn't been displayed, stay in the loop
			mov		r1, #0x2A
			ldrb	r1, [r0,r1]
			cmp		r1, #0
			beq		End
			
				mov		r1, #1
				ldr		r2, =ProcGoto
				mov		lr, r2
				.short	0xF800
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

