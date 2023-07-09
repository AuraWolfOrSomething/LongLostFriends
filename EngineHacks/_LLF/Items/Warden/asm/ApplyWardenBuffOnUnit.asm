.thumb

.include "../WardenDefs.s"

.global ApplyWardenBuffOnUnit
.type ApplyWardenBuffOnUnit, %function


		ApplyWardenBuffOnUnit:
		push	{r4,r14}
		mov		r4, r0
		
		@Check if unit is allied with staff user
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
			bne		End
			
				@Check if unit has Absorb debuff
				mov		r0, r4
				ldr		r1, =IsAbsorbDebuffActive
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				bne		End
			
					@Get unit debuff entry
					mov		r0, r4
					ldr		r1, =GetDebuffs
					mov		lr, r1
					.short	0xF800

					@Apply blocking buff
					ldrb	r1, [r0,#4]
					mov		r2, #0x0F
					and		r1, r2
					add		r1, #0x30 @3 turns
					strb	r1, [r0,#4]
				
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

