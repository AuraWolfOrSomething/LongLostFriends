.thumb

.include "../GuardianDefs.s"

.global TryAddUnitToGuardianTargetList
.type TryAddUnitToGuardianTargetList, %function


		TryAddUnitToGuardianTargetList:
		push	{r4,r14}
		mov		r4, r0
		ldr		r0, =gUnitSubject
		ldr		r0, [r0]
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
			bne		UnitNotAdded
			
				@Check if unit already has Def/Res buff
				mov		r0, r4
				ldr		r1, =IsGuardianDamageActive
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				bne		UnitNotAdded
				
					@Add unit to target list
					mov		r0, #0x10
					ldsb	r0, [r4,r0]
					mov		r1, #0x11
					ldsb	r1, [r4,r1]
					mov		r2, #0x0B
					ldsb	r2, [r4,r2]
					mov		r3, #0
					ldr		r4, =AddTarget
					mov		lr, r4
					.short	0xF800
					mov		r0, #1
					b		End
		
		UnitNotAdded:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

