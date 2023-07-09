.thumb

.include "../DistractDefs.s"

.global DistractDebuff
.type DistractDebuff, %function


		DistractDebuff:
		push	{r4-r5,r14}
		mov		r4, r0
		
		@If something that prevents debuffs is active, skip
		ldr		r1, =AreDebuffsEffective
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@Check if unit has debuff
			mov		r0, r4
			ldr		r1, =IsDistractDebuffActive
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			beq		End
			
				@Look for debuff halving
				mov		r0, r4
				ldr		r1, =AreDebuffsHalved
				mov		lr, r1
				.short	0xF800
				mov		r5, r0
				
				@-10 with halving, -20 otherwise
				mov		r2, #20
				lsr		r2, r5
			
				@Penalty to hit, but don't lower it past 0
				mov		r1, #0x60
				ldrsh	r0, [r4,r1]
				sub		r0, r2
				cmp		r0, #0
				bge		StoreHit
				
					mov		r0, #0
				
				StoreHit:
				strh	r0, [r4,r1]
				
				@Penalty to avoid, but don't lower it past 0
				@mov		r1, #0x62
				@ldrsh	r0, [r4,r1]
				@sub		r0, r2
				@cmp		r0, #0
				@bge		StoreAvoid
				
					@mov		r0, #0
				
				@StoreAvoid:
				@strh	r0, [r4,r1]
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

