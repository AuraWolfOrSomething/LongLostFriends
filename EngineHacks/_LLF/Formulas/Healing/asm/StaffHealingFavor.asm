.thumb

.global StaffHealingFavor
.type StaffHealingFavor, %function

		StaffHealingFavor:
		push	{r4-r5,r14}
		mov		r4, r1 @target
		mov		r5, #0 @healing added by this formula
		
		@Get user luck
		ldr		r1, =prGotoLckGetter
		mov		lr, r1
		.short	0xF800
		add		r5, r0
		
		@Get target luck
		mov		r0, r4
		ldr		r1, =prGotoLckGetter
		mov		lr, r1
		.short	0xF800
		
		@Add the two together and return the sum
		add		r0, r5
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

