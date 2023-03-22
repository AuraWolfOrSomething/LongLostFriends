.thumb

.global prSkillAdvance
.type prSkillAdvance, %function


		prSkillAdvance:
		push	{r4-r5,r14}
		mov		r4, r0 @stat
		mov		r5, r1 @unit
		
		@check for skill
		mov		r0, r1
		ldr		r1, =AdvanceSkillLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@check if already used Advance to go again
			ldr		r0, [r5,#0x0C]	@status bitfield
			mov		r1, #0x04
			lsl		r1, #0x08
			tst		r0, r1
			bne		AlreadyUsedAdvance
			
				add		r4, #1
				b		End
			
		AlreadyUsedAdvance:
		sub		r4, #1
		
		End:
		mov		r0, r4
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

