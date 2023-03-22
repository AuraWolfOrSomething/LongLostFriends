.thumb

.global SklBonusToWeaponRank
.type SklBonusToWeaponRank, %function


		SklBonusToWeaponRank:
		push	{r4-r7,r14}
		mov		r4, #0 @effect on weapon rank
		ldrb	r5, [r0,#0x15] @skl stat
		
		@If unit's unmodified skl is at least 20, skip checking skl modifiers
		cmp		r5, #20
		bge		LowerWeaponRankRequirement

			mov		r6, r0 @unit
			ldr		r7, =SklBonusToWeaponRankSklModifierList
			
			LoopThroughList:
			ldr		r2, [r7]
			cmp		r2, #0
			beq		CheckSklStatAgain
			
				mov		r0, r5
				mov		r1, r6
				mov		lr, r2
				.short	0xF800
				mov		r5, r0
				add		r7, #4
				b		LoopThroughList
			
		CheckSklStatAgain:
		cmp		r5, #20
		blt		End
		
			LowerWeaponRankRequirement:
			mov		r4, #1
		
		End:
		mov		r0, r4
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

