.thumb

.global PrimeFive
.type PrimeFive, %function


		PrimeFive:
		push	{r4-r6,lr}
		mov		r4, r0
		mov		r5, r1
		
		ldr		r3, =CheckIfPrimeFiveIsActive
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@Load Lck
			mov		r6, #0x19
			ldsb	r6, [r4,r6]
			
			@Load battle stat formulas, but use Lck instead of other stats
			ldr		r3, =DefensiveStatFormula
			mov		lr, r3
			mov		r0, r4
			mov		r1, r5
			mov		r2, r6
			mov		r3, r6
			.short	0xF800
			
			ldr		r3, =AttackFormula
			mov		lr, r3
			mov		r0, r4
			mov		r1, r5
			mov		r2, r6
			.short	0xF800
			
			ldr		r3, =AttackSpeedFormula 
			mov		lr, r3
			mov		r0, r4
			mov		r1, r6
			mov		r2, r6
			mov		r3, r6
			.short	0xF800
			
			ldr		r3, =HitFormula 
			mov		lr, r3
			mov		r0, r4
			mov		r1, r5
			mov		r2, r6
			mov		r3, r6
			.short	0xF800
			
			ldr		r3, =AvoidFormula 
			mov		lr, r3
			mov		r0, r4
			mov		r1, r6
			mov		r2, r6
			.short	0xF800
			
			ldr		r3, =CriticalHitFormula 
			mov		lr, r3
			mov		r0, r4
			mov		r1, r6
			.short	0xF800
			
			@Don't need to rerun DodgeFormula
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

