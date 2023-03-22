.thumb

.global RustbowDamage
.type RustbowDamage, %function


		RustbowDamage:
		push	{r14}
		
		@Check if unit is wielding Rustbow
		mov		r2, #0x48
		ldrb	r2, [r0,r2]
		ldr		r3, =RustbowIDLink
		ldrb	r3, [r3]
		cmp		r2, r3
		bne		End
		
			@Re-run AttackFormula with Pow of 0
			mov		r2, #0
			ldr		r3, =AttackFormula
			mov		lr, r3
			.short	0xF800
		
		End:
		pop		{r0}
		bx		r0
		
		
		.align
		.ltorg

