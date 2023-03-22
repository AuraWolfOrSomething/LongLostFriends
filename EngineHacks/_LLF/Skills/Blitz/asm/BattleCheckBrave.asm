.thumb

.include "../BlitzDefs.s"

.global BattleCheckBrave
.type BattleCheckBrave, %function


		BattleCheckBrave:
		push	{r14}
		
		@check if unit is attacker
		  @if not, can't have brave effect from weapon
		ldr		r1, =gActiveBattleUnit
		cmp		r0, r1
		bne		BlitzCheck
		
			@check for brave bit on weapon
			ldr		r2, [r0,#0x4C]
			mov		r1, #0x20
			tst		r2, r1
			bne		HasBraveEffect
		
				BlitzCheck:
				ldr		r1, =BlitzLink
				ldrb	r1, [r1]
				ldr		r3, =SkillTester
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				bne		HasBraveEffect
				
					mov		r0, #0
					b		End
		
		HasBraveEffect:
		ldr		r0, =gpCurrentRound
		ldr		r3, [r0]
		ldr		r2, [r3]
		lsl		r1, r2, #0x0D
		lsr		r1, #0x0D
		mov		r0, #0x10
		orr		r1, r0
		ldr		r0, =Word1
		and		r0, r2
		orr		r0, r1
		str		r0, [r3]
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

