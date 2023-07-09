.thumb

.global RustbowProc
.type RustbowProc, %function

.equ gBattleStats, 0x0203A4D4


		RustbowProc:
		push	{r4-r5,r14}
		mov		r4, r0 @unit doing damage
		mov		r5, r1 @unit taking damage
		
		@skip all of this unless a battle is actually happening
		ldr		r0, =gBattleStats
		ldrh	r1, [r0]
		mov		r0, #2
		tst		r0, r1
		bne		End
		
			@if attacking unit missed, don't need to check
			ldr		r0, [r2]
			lsl		r0, #0xD
			lsr		r0, #0xD
			mov		r1, #2
			tst		r0, r1
			bne		End
			
				@check if attacking unit is using a Rustbow
				mov		r0, #0x4A
				ldrb	r0, [r4,r0]
				ldr		r1, =RustbowIDLink
				ldrb	r1, [r1]
				cmp		r0, r1
				bne		End
					
					@apply debuff on unit taking damage during the actual battle
					ldr		r0, =AddDebuffOrRemoveProtection
					mov		lr, r0
					mov		r0, r5
					mov		r1, #0 @where debuff is in unit debuff entry
					mov		r2, #0x0F @how much of the byte is for this debuff
					ldr		r3, =RustbowDebuffDurationOnHitLink
					ldrb	r3, [r3]
					.short	0xF800
					
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

