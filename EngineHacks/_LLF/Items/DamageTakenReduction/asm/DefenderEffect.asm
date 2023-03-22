.thumb

.equ gActiveBattleUnit, 0x0203A4EC

.global DefenderEffect
.type DefenderEffect, %function


		DefenderEffect:
		mov		r1, #0x4A
		ldrb	r1, [r0,r1]
		ldr		r2, =DefenderLink
		ldrb	r2, [r2]
		cmp		r1, r2
		bne		End
		
			@Check if unit is the attacker
			ldr		r1, =gActiveBattleUnit
			cmp		r0, r1
			bne		End
		
				@-6 damage taken
				mov		r1, #0x5C
				ldrb	r2, [r0,r1]
				add		r2, #6
				strb	r2, [r0,r1]
		
		End:
		bx		r14
		
		.align
		.ltorg

