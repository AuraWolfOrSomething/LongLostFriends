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
					mov		r0, r5
					ldr		r1, =GetDebuffs
					mov		lr, r1
					.short	0xF800
					ldrb	r1, [r0]
					mov		r2, r1
					mov		r3, #0x0F
					and		r2, r3
					ldr		r3, =RustbowDebuffDurationOnHitLink
					ldrb	r3, [r3]
					add		r2, r3
					cmp		r2, #0x0F
					ble		StoreNewDebuffAmount
					
						mov		r2, #0x0F
					
					StoreNewDebuffAmount:
					lsl		r1, #28
					lsr		r1, #28
					add		r1, r2
					strb	r1, [r0]
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

