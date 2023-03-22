.thumb

.include "../HeroicsDefs.s"

.global AfterActionRescue
.type AfterActionRescue, %function


		AfterActionRescue:
		push	{r14}
		
		@Check if rescued unit was recaptured
		mov		r0, r4
		ldr		r3, =IsRecapturePossible
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		HeroicsCheck
		
			@If so, set hp to 0
			mov		r0, #0
			strb	r0, [r4,#0x13]
		
		@Check if rescuing unit has Heroics
		HeroicsCheck:
		mov		r0, r5
		ldr		r1, =HeroicsLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@If so, let unit do another action (but if player presses "b", it ends the unit's turn/activates Canto)
			@(code to make this work is from ContemporaryTalkSupport)
			ldr		r4, =gActionData
			mov		r2, #0x17
			@mov		r2, #0x0B
			strb	r2, [r4,#0x11]
			ldr		r4, [r6,#4]
			sub		r4, #0x30
			str		r4, [r6,#4]
			mov		r0, #0
		
		End:
		@we return to point where the previous routine was called (rather than the end of the previous routine), so we need to do some extra pops
		ldr		r4, =gGameState
		add		r4, #0x3D
		ldrb	r3, [r4]
		@mov	r6, #0x80
		mov		r6, #0x10
		orr		r6, r3
		strb	r6, [r4]
		
		pop		{r1}
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

