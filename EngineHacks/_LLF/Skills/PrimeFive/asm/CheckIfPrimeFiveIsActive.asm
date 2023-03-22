@returns 1 if active, or 0 if not active
@used for PreBattleLoop and MMB

.thumb

.global CheckIfPrimeFiveIsActive
.type CheckIfPrimeFiveIsActive, %function

.equ gChapterData, 0x0202BCF0


		CheckIfPrimeFiveIsActive:
		push	{r4-r5,r14}
		mov		r4, r0
		mov		r5, #0
		
		@Check if Unit has Prime Five
		ldr		r1, =PrimeFiveLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xf800
		cmp		r0, #0
		beq		End
		
			@Check if Lv 5
			ldrb	r0, [r4,#8]
			cmp		r0, #5
			beq		PrimeFiveActive
		
				@If not Lv 5, check if Turn 5
				ldr		r1, =gChapterData
				ldrh	r1, [r1,#0x10]
				cmp		r1, #5
				bne		End
		
		PrimeFiveActive:
		mov		r5, #1
		
		End:
		mov		r0, r5
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

