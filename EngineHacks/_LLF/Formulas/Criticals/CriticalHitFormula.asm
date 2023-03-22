.thumb

@r0 = User
@r1 = Skl

.include "../BattleStatFormulaDefs.s"

.global CriticalHitFormula
.type CriticalHitFormula, %function


		CriticalHitFormula:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, #0
		mov		r6, r1 @Skl
		
		@Weapon Crit
		mov		r0, r4
		add		r0, #0x48
		ldrh	r0, [r0]
		ldr		r3, =GetItemCrit
		mov		lr, r3
		.short	0xF800
		add		r5, r0
		
		@If weapon crit is non-zero, skip lsr instruction
		cmp		r0, #0
		bne		AddSklModifier
		
			lsr		r6, #1 @Skl/2
		
		AddSklModifier:
		add		r5, r6
		
		@Store
		mov		r0, r4
		add		r0, #0x66
		strh	r5, [r0]
		
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

