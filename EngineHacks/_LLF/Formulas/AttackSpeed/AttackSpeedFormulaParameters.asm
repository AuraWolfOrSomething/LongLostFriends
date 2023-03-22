.thumb

.global AttackSpeedFormulaParameters
.type AttackSpeedFormulaParameters, %function

		
		AttackSpeedFormulaParameters:
		push	{r14}
		
		ldr		r2, =AttackSpeedFormula
		mov		lr, r2
		
		@Get unit's Spd
		mov		r1, #0x16
		ldsb	r1, [r0,r1]
		
		@Get unit's Con
		mov		r2, #0x1A
		ldsb	r2, [r0,r2]
	
		@Get unit's Skl
		mov		r3, #0x15
		ldsb	r3, [r0,r3]
		
		.short	0xF800

		pop		{r0}
		bx		r0

