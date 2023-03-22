.thumb

.include "../PlanDefs.s"

.global MM_PlanUsability
.type MM_PlanUsability, %function


		MM_PlanUsability:
		push	{r14}
		ldr		r0, =PlanEventIDLink
		ldrh	r0, [r0]
		ldr		r1, =CheckEventID
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		bne		PlanUnusable
		
			mov		r0, #1
			b		End
		
		PlanUnusable:
		mov		r0, #3
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


