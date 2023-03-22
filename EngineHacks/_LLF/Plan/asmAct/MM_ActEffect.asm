.thumb

.global MM_ActEffect
.type MM_ActEffect, %function


		MM_ActEffect:
		push	{r14}
		ldr		r0, =ActResetUnitPositions
		mov		lr, r0
		.short	0xF800
		mov		r0, #0x1B
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


