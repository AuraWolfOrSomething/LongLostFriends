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
		
			@Look for debuff halving
			mov		r0, r4
			ldr		r1, =AreDebuffsHalved
			mov		lr, r1
			.short	0xF800
			
			@2 weapon ranks with halving; 3 otherwise
			mov		r1, #2 @debuff amount
			lsr		r1, r0
			add		r1, #1
			neg		r0, r1
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

