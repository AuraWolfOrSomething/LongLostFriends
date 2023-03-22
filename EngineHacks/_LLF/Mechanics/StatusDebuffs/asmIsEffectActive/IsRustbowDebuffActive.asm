.thumb

.global IsRustbowDebuffActive
.type IsRustbowDebuffActive, %function


		IsRustbowDebuffActive:
		push	{r14}
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r0, [r0]
		mov		r1, #0x0F
		and		r0, r1
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

