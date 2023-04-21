.thumb

.equ gActiveBattleUnit, 0x0203A4EC
.equ gTargetBattleUnit, 0x0203A56C

.global AgileEdgePreventCounterattack
.type AgileEdgePreventCounterattack, %function


		AgileEdgePreventCounterattack:
		push	{r4,r14}
		ldr		r4, =gTargetBattleUnit
		cmp		r0, r4
		bne		End
		
			mov		r0, #0x4A
			ldrb	r0, [r1,r0]
			ldr		r2, =AgileEdgeIdLink
			ldrb	r2, [r2]
			cmp		r0, r2
			bne		End
			
				@If attacker wielding agile edge won't double, defender can still counterattack
				mov		r0, r1
				mov		r1, r4
				ldr		r2, =WillUnitDouble
				mov		lr, r2
				.short	0xF800
				cmp		r0, #0
				beq		End
				
					mov		r0, #0
					mov		r1, #0x48
					strh	r0, [r4,r1]
					mov		r1, #0x52
					strb	r0, [r4,r1]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

