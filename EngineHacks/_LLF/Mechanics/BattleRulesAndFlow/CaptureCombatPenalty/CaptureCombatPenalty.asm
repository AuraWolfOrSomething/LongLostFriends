.thumb

.equ gTargetBattleUnit, 0x0203A56C

.global CaptureCombatPenalty
.type CaptureCombatPenalty, %function


		CaptureCombatPenalty:
		push	{r4,r14}
		
		@If Defender, skip
		ldr		r1, =gTargetBattleUnit
		cmp		r0, r1
		beq		End
		
			@If Capture isn't set, skip
			mov		r4, r0
			ldr		r1, =Is_Capture_Set
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			beq		End
			
				@-3 damage dealt
				mov		r1, #0x5A
				ldrh	r0, [r4,r1]
				sub		r0, #3
				cmp		r0, #0
				bge		StoreDamageDealt
				
					mov		r0, #0
				
				StoreDamageDealt:
				strh	r0, [r4,r1]
				
				@-15 Hit
				mov		r1, #0x60
				ldrh	r0, [r4,r1]
				sub		r0, #15
				cmp		r0, #0
				bge		StoreHit
				
					mov		r0, #0
				
				StoreHit:
				strh	r0, [r4,r1]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

