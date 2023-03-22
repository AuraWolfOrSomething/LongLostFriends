.thumb

.global AvoidFormulaParameters
.type AvoidFormulaParameters, %function

		
		AvoidFormulaParameters:
		push	{r14}
		
		ldr		r2, =AvoidFormula
		mov		lr, r2
	
		@Get unit's AS
		mov		r1, r0
		add		r1, #0x5E
		mov		r2, #0
		ldsh	r1, [r1,r2]
		
		@Get unit's Lck
		mov		r2, #0x19
		ldsb	r2, [r0,r2]
		
		.short	0xF800
		
		pop		{r0}
		bx		r0

