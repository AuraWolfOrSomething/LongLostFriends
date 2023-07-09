.thumb

.include "../AbsorbDefs.s"

.global TryAddUnitToAbsorbTargetList
.type TryAddUnitToAbsorbTargetList, %function


		TryAddUnitToAbsorbTargetList:
		push	{r4,r14}
		mov		r4, r0 @potential target
		
		@Check if allies
		ldr		r0, =gUnitSubject
		ldr		r0, [r0] @staff user
		ldrb	r0, [r0,#0x0B]
		ldrb	r1, [r4,#0x0B]
		ldr		r2, =AreAllegiancesAllied
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@Check if unit is being rescued
			ldr		r1, [r4,#0x0C]
			mov		r2, #0x20
			tst		r1, r2
			bne		End
			
				@Check if unit has Absorb debuff
				mov		r0, r4
				ldr		r1, =IsAbsorbDebuffActive
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				bne		End
				
					@Check if they have at least one debuff
					mov		r0, r4
					ldr		r1, =CountAllDebuffsActive
					mov		lr, r1
					.short	0xF800
					cmp		r0, #0
					beq		End
					
						@Add unit to target list
						ldr		r0, =AddTarget
						mov		lr, r0
						mov		r0, r4
						mov		r1, #0x11
						ldsb	r1, [r0,r1]
						mov		r2, #0x0B
						ldsb	r2, [r0,r2]
						mov		r3, #0x10
						ldsb	r0, [r0,r3]
						mov		r3, #0
						.short	0xF800
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

