.thumb

.global SteadyAim
.type SteadyAim, %function


		SteadyAim:
		push	{r4,r14}
		mov		r4, r0
		
		@Check for skill
		ldr		r1, =SteadyAimLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r1, #0x60
			ldrh	r0, [r4,r1]
			add		r0, #15 @bonus to hit
			strh	r0, [r4,r1]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

