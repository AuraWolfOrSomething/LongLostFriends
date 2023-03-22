.thumb

.global MM_PlanEffect
.type MM_PlanEffect, %function


		MM_PlanEffect:
		push	{r14}
		ldr		r0, =PlanSaveUnitPositions
		mov		lr, r0
		.short	0xF800
		mov		r0, #0x1B
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


