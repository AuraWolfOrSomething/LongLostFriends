.thumb

.global ReturnEscortTier
.type ReturnEscortTier, %function

@return 2 if Escort+
@returns 1 if Escort
@returns 0 if neither


		ReturnEscortTier:
		push	{r4-r5,r14}
		mov		r4, r0
		
		@Check Escort first
		ldr		r1, =EscortLink
		ldrb	r1, [r1]
		ldr		r5, =SkillTester
		mov		lr, r5
		.short	0xF800
		cmp		r0, #1
		beq		End
		
		mov		r0, r4
		ldr		r1, =EscortPlusLink
		ldrb	r1, [r1]
		mov		lr, r5
		.short	0xF800
		cmp		r0, #0
		beq		End
		
		mov		r0, #2
		
		End:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

