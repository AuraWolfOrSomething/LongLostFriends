.thumb

.equ origin, 0x2C450
.include "../ExperienceDefs.s"

.global ExperienceForDefeat
.type ExperienceForDefeat, %function


		ExperienceForDefeat:
		push	{r4-r7,r14}
		mov		r7, r0
		mov		r5, r1
		mov		r0, #0x13
		ldsb	r0, [r5,r0]
		cmp		r0, #0x00
		beq		EnemyDefeated
		
			mov		r0, #0x00
			b		End
		
		EnemyDefeated:
		@0802C462
		
		@Enemy unit
		mov		r0, r5
		@mov		r1, #10
		@mov		r1, #3
		bl		ClassPowerDefeatExp
		
		@Player unit
		mov		r6, r0
		mov		r0, r7
		@mov		r1, #10
		@mov		r1, #0
		@mov		r1, #3
		bl		ClassPowerDefeatExp
		sub		r6, r6, r0
		neg		r1, r6
		add		r6, #20
		cmp		r1, #1 @if unit classPower*lv > enemy classPower*lv by at least 1 (most classes have classPower 3), decrease exp by difference
		blt		CheckIfExtraDefeatExp
		
			sub		r6, r1
		
		CheckIfExtraDefeatExp:
		mov		r0, r7
		mov		r1, r5
		bl		PromotedBossEntombedCheck
		add		r6, r0
		@if defeat exp would be negative, set to 0 instead
		cmp		r6, #0
		bge		PassDefeatExp
		
			mov		r6, #0
		
		PassDefeatExp:
		mov		r0, r6
		
		End:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align

