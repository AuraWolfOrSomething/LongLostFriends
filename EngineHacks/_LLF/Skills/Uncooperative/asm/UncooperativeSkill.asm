.thumb

.global UncooperativeSkill
.type UncooperativeSkill, %function


		UncooperativeSkill:
		push	{r4,r14}
		mov		r4, #1
		mov		r0, r1
		ldr		r1, =UncooperativeSkillLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r4, #0
		
		End:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

