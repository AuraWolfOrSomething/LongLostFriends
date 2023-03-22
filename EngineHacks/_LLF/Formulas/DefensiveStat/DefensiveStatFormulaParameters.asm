.thumb

.global DefensiveStatFormulaParameters
.type DefensiveStatFormulaParameters, %function

		
		DefensiveStatFormulaParameters:
		push	{r14}
		
		ldr		r2, =DefensiveStatFormula
		mov		lr, r2
	
		@Get unit's Def
		mov		r2, #0x17
		ldsb	r2, [r0,r2]
		
		@Get unit's Res
		mov		r3, #0x18
		ldsb	r3, [r0,r3]
		
		.short	0xF800

		pop		{r0}
		bx		r0

