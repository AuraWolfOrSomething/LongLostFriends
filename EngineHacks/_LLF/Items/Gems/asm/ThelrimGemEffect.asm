.thumb

.include "../GemDefs.s"

.global ThelrimGemEffect
.type ThelrimGemEffect, %function

@r4 = unit we're checking
@r5 = unit's opponent (if any)

		ThelrimGemEffect:
		push	{r4-r6,r14}
		
		@check if attacker or defender
		  @if attacker, skip for now
		  @if defender, do this for both units
		
		ldr		r2, =gTargetBattleUnit
		cmp		r0, r2
		bne		End
		
		mov		r4, r0
		mov		r5, r1
		mov		r6, #0 @loop counter
		
		CheckForThelrimGem:
		ldr		r1, =ThelrimGemLink
		ldrb	r1, [r1]
		ldr		r3, =CheckIfGemIsActive
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		CheckOtherUnit
		
			@Add 4 to defensive stat
			mov		r1, r4
			add		r1, #0x5C
			ldrb	r0, [r1]
			add		r0, #4
		
			@If the final damage taken would less than 6, set to 6
			mov		r2, r5
			add		r2, #0x5A
			ldrb	r2, [r2] @other unit's damage dealt
			sub		r3, r2, r0 @damage dealt - damage taken
			mov		r2, #6 @the set minimal damage taken when gem is active
			cmp		r3, r2
			bge		StoreNewDamageTaken
		
				sub		r2, r3
				sub		r0, r2
		
			StoreNewDamageTaken:
			strb	r0, [r1]
		
				@Do this twice (first for defender, then attacker)
				CheckOtherUnit:
				add		r6, #1
				cmp		r6, #2
				bge		End
		
					ldr		r4, =gActiveBattleUnit
					ldr		r5, =gTargetBattleUnit
					mov		r0, r4
					b		CheckForThelrimGem
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0

