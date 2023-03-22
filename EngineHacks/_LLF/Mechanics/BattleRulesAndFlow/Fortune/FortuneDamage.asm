.thumb

.global FortuneDamage
.type FortuneDamage, %function


		FortuneDamage:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, r1
		
		@Load Lck
		mov		r6, #0x19
		ldsb	r6, [r4,r6]
		
		ldr		r3, =CheckIfThisUnitUsingFortune
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		CheckOtherCombatant
		
			@If this unit has Fortune, use their Lck instead of Pow for damage
			ldr		r3, =AttackFormula
			mov		lr, r3
			mov		r0, r4
			mov		r1, r5
			mov		r2, r6
			.short	0xF800
		
		CheckOtherCombatant:
		mov		r0, r5
		ldr		r3, =CheckIfThisUnitUsingFortune
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@If other unit has Fortune, use this unit's Lck instead of Def/Res for damage reduction
			ldr		r3, =DefensiveStatFormula
			mov		lr, r3
			mov		r0, r4
			mov		r1, r5
			mov		r2, r6
			mov		r3, r6
			.short	0xF800
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0

