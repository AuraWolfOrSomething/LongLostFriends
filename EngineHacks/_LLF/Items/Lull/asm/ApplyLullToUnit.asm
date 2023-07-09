.thumb

.include "../LullDefs.s"

.global ApplyLullToUnit
.type ApplyLullToUnit, %function


		ApplyLullToUnit:
		push	{r4-r5,r14}
		mov		r4, r0
		
		@Check if unit is allied with staff user
		ldr		r5, =gUnitSubject
		ldr		r0, [r5]
		ldrb	r0, [r0,#0x0B]
		mov		r1, #0x0B
		ldsb	r1, [r4,r1]
		ldr		r2, =AreAllegiancesAllied
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@Check if unit is being rescued
			ldr		r0, [r4,#0x0C]
			mov		r1, #0x20
			tst		r0, r1
			bne		End
				
				@Heal unit
				ldr		r0, [r5] @staff user
				ldr		r1, =LullAoeEntry
				ldrb	r1, [r1] @item id
				mov		r2, r4
				ldr		r3, =GetStaffHealAmount
				mov		lr, r3
				.short	0xF800
				ldrb	r1, [r4,#0x13]
				add		r0, r1
				ldrb	r1, [r4,#0x12]
				cmp		r0, r1
				ble		StoreNewHP @don't let current hp be greater than max
				
					mov		r0, r1
				
				StoreNewHP:
				strb	r0, [r4,#0x13]
				
				@Debuff
				mov		r0, r4
				ldr		r1, =CalculateDebuffDuration
				mov		lr, r1
				.short	0xF800
				mov		r3, r0 @amount of turns Lull will last on this unit
					
				ldr		r0, =AddDebuffOrRemoveProtection
				mov		lr, r0
				mov		r0, r4 @unit
				mov		r1, #1 @where debuff is in unit debuff entry
				mov		r2, #0x0F @how much of the byte is for this debuff
				.short	0xF800
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

