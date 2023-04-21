.thumb

.global IneptDebuff
.type IneptDebuff, %function


		IneptDebuff:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =IsIneptDebuffActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r0, r4
			ldr		r1, =DetermineIneptSeverity
			mov		lr, r1
			.short	0xF800
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

