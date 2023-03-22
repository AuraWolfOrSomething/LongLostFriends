.thumb

.global FarWard
.type FarWard, %function

.equ gTargetBattleUnit, 0x0203A56C
.equ gBattleStats, 0x0203A4D4
.equ gActiveBattleUnit, 0x0203A4EC


		FarWard:
		push	{r4-r6,r14}
		
		@check if attacker or defender
		  @if attacker, skip for now
		  @if defender, do this for both units
		
		ldr		r2, =gTargetBattleUnit
		cmp		r0, r2
		bne		End
		
			@Check if distance between units is at least 3
			  @if so, nullify hit on other unit
			  @if not, can skip checking for both units
			  
			ldr		r2, =gBattleStats
			ldrb	r2, [r2,#2]
			cmp		r2, #3
			blt		End
			
				mov		r4, r0
				mov		r5, r1
				mov		r6, #0 @loop counter
				
				CheckForFarWard:
				ldr		r1, =FarWardLink
				ldrb	r1, [r1]
				ldr		r3, =SkillTester
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				beq		CheckOtherUnit
				
					mov		r0, #0
					
					@Attack
					mov		r1, #0x5A
					strh	r0, [r5,r1]
					
					@Hit
					mov		r1, #0x60
					strh	r0, [r5,r1]
					
					@Crit
					mov		r1, #0x66
					strh	r0, [r5,r1]
				
					CheckOtherUnit:
					add		r6, #1
					cmp		r6, #2
					bge		End
					
						ldr		r4, =gActiveBattleUnit
						ldr		r5, =gTargetBattleUnit
						mov		r0, r4
						b		CheckForFarWard
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

