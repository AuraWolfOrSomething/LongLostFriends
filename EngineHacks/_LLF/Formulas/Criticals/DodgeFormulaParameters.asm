.thumb

.global DodgeFormulaParameters
.type DodgeFormulaParameters, %function

		
		DodgeFormulaParameters:
		push	{r14}
		
		ldr		r2, =DodgeFormula
		mov		lr, r2
		
		@Get unit's Lck
		mov		r1, #0x19
		ldsb	r1, [r0,r1]
		
		.short	0xF800
		
		pop		{r0}
		bx		r0

