.thumb

.global CriticalHitFormulaParameters
.type CriticalHitFormulaParameters, %function

		
		CriticalHitFormulaParameters:
		push	{r14}
		
		ldr		r2, =CriticalHitFormula
		mov		lr, r2
		
		@Get unit's Skl
		mov		r1, #0x15
		ldsb	r1, [r0,r1]
		
		.short	0xF800
		
		pop		{r0}
		bx		r0

