.thumb

.global CannotIfCantoingExceptEscortPlus
.type CannotIfCantoingExceptEscortPlus, %function


		CannotIfCantoingExceptEscortPlus:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, [r0,#0x0C]
		mov		r2, #0x40
		tst		r1, r2
		beq		CanUse
		
			ldr		r3, =ReturnEscortTier
			mov		lr, r3
			.short	0xF800
			cmp		r0, #2
			beq		CanUse
			
				mov		r0, #0
				b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

