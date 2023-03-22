.thumb

.global IsIneptDebuffActive
.type IsIneptDebuffActive, %function


		IsIneptDebuffActive:
		push	{r14}
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r0, [r0]
		lsr		r0, #4
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

