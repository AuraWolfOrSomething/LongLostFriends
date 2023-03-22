.thumb

.global CheckIfBalancedStudyIsActive
.type CheckIfBalancedStudyIsActive, %function


		CheckIfBalancedStudyIsActive:
		push	{r4-r5,r14}
		mov		r4, r0
		mov		r5, #0
		
		@Check for skill
		ldr		r1, =BalancedStudyLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xf800
		cmp		r0, #0
		beq		End
		
			@Get WEXP difference
			mov		r3, r4
			add		r3, #0x28
			ldrb	r0, [r3] @sword wexp
			ldrb	r1, [r3,#5] @anima wexp
			sub		r2, r0, r1
			cmp		r2, #0
			bge		CheckIfIncrease
			
				sub		r2, r1, r0
			
			CheckIfIncrease:
			cmp		r2, #5 @if difference is greater than 5, skill not active
			bgt		End
			
				mov		r5, #1
			
		End:
		mov		r0, r5
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

