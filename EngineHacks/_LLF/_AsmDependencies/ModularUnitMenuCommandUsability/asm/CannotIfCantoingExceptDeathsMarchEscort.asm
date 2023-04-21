.thumb

.global CannotIfCantoingExceptDeathsMarchEscort
.type CannotIfCantoingExceptDeathsMarchEscort, %function


		CannotIfCantoingExceptDeathsMarchEscort:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, [r0,#0x0C]
		mov		r2, #0x40
		tst		r1, r2
		beq		CanUse
		
			ldr		r3, =ReturnEscortTier
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			bne		CanUse
			
				mov		r0, r4
				ldr		r1, =DeathsMarchIdLink
				ldrb	r1, [r1]
				ldr		r3, =SkillTester
				mov		lr, r3
				.short	0xF800
				b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

