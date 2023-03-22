.thumb

.global HitFormulaParameters
.type HitFormulaParameters, %function

		
		HitFormulaParameters:
		push	{r14}
		
		ldr		r2, =HitFormula
		mov		lr, r2
	
		@Get unit's Skl
		mov		r2, #0x15
		ldsb	r2, [r0,r2]
		
		@Get unit's Lck
		mov		r3, #0x19
		ldsb	r3, [r0,r3]
		
		.short	0xF800
		
		pop		{r0}
		bx		r0

