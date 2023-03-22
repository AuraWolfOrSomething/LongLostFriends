.thumb

.include "../AdvanceDefs.s"

.global AdvanceSkillUsability
.type AdvanceSkillUsability, %function

@In order for Advance to appear, these all need to be true:
	@Unit has Advance
	@Unit hasn't already used Advance
	@Unit hasn't used more than 2 mov

		AdvanceSkillUsability:
		push	{r4,r14}
		ldr		r4, =gActiveUnit
		ldr		r4, [r4]
		
		@check if unit has Advance skill
		mov		r0, r4
		ldr		r1, =AdvanceSkillLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		NotUsable
		
			@check if already used Advance this turn
			ldr		r0, [r4,#0x0C]	@status bitfield
			mov		r1, #0x04
			lsl		r1, #0x08
			tst		r0, r1
			bne		NotUsable
		
				@check if moved more than 2 squares
				ldr		r3, =gActionData
				ldrb	r0, [r3,#0x10]
				mov		r1, #2
				cmp		r0, r1
				bgt		NotUsable
		
					@Advance will appear instead, so don't make Wait usable
					mov		r0, #1
					b		End
		
		NotUsable:
		mov		r0, #3
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

