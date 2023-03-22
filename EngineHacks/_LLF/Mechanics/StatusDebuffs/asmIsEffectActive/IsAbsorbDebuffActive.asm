.thumb

.global IsAbsorbDebuffActive
.type IsAbsorbDebuffActive, %function


		IsAbsorbDebuffActive:
		push	{r14}
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r0, [r0,#3]
		mov		r1, #1
		and		r0, r1
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

