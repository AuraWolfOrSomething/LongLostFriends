.thumb

.equ gGameState, 0x0202BCB0

.global BargainSkillDiscount
.type BargainSkillDiscount, %function


		BargainSkillDiscount:
		push	{r4,r14}
		mov		r4, r0
		mov		r0, r1
		ldr		r1, =BargainLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@If during prep screen, don't give discount
			ldr		r1, =gGameState
			ldrb	r3, [r1,#4]
			mov		r1, #0x10
			and		r1, r3
			cmp		r1, #0
			bne		End
			
				add		r4, #25
		
		End:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

