.thumb

.include "../LastLegsDefs.s"

.global CheckIfUnitCanSelectAttack
.type CheckIfUnitCanSelectAttack, %function


		CheckIfUnitCanSelectAttack:
		push	{r4-r6,r14}
		ldr		r4, =gActiveUnit
		ldr		r5, [r4]
		ldr		r0, [r5,#0x0C]
		mov		r1, #0x40
		tst		r0, r1
		bne		CannotSelect
		
			mov		r1, #0x80
			lsl		r1, #4
			tst		r0, r1
			bne		CannotSelect
		
				@Check if unit has Last Legs; if so, check if full movement was used
				mov		r0, r5
				ldr		r1, =LastLegsLink
				ldrb	r1, [r1]
				ldr		r3, =SkillTester
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				beq		ContinueCheck
		
					mov		r0, r5
					ldr		r3, =prGotoMovGetter
					mov		lr, r3
					.short	0xF800
		
					@If unit couldn't even move, then continue check
					cmp		r0, #0
					beq		ContinueCheck
		
						ldr 	r1, =gActionData
						ldrb 	r1, [r1,#0x10]	@squares moved this turn
						cmp		r0, r1
						beq		CannotSelect
		
		ContinueCheck:
		mov		r6, #0
		
		LoopThroughItems:
		ldr		r0, [r4]
		lsl		r1, r6, #1
		add		r0, r1
		ldrh	r5, [r0,#0x1E]
		cmp		r5, #0
		beq		CannotSelect
		
			mov		r0, r5
			ldr		r3, =GetItemAttributes
			mov		lr, r3
			.short	0xF800
			mov		r1, #1
			tst		r1, r0
			beq		NextItem
			
				ldr		r0, [r4]
				mov		r1, r5
				ldr		r3, =CanUnitUseWeapon
				mov		lr, r3
				.short	0xF800
				lsl		r0, #0x18
				cmp		r0, #0
				beq		NextItem
				
					ldr		r0, [r4]
					mov		r1, r5
					ldr		r3, =MakeTargetListForWeapon
					mov		lr, r3
					.short	0xF800
					ldr		r3, =GetTargetListSize
					mov		lr, r3
					.short	0xF800
					cmp		r0, #0
					bne		CanSelect
			
						NextItem:
						add		r6, #1
						cmp		r6, #4
						ble		LoopThroughItems
		
		CannotSelect:
		mov		r0, #3
		b		End		
		
		CanSelect:
		mov		r0, #1
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

