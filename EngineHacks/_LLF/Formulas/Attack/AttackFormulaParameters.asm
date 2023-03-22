.thumb

.global AttackFormulaParameters
.type AttackFormulaParameters, %function

		
		AttackFormulaParameters:
		push	{r14}
		
		ldr		r2, =AttackFormula
		mov		lr, r2
	
		@Get unit's Pow
		mov		r2, #0x14
		ldsb	r2, [r0,r2]
		
		.short	0xF800
		
		pop		{r0}
		bx		r0

