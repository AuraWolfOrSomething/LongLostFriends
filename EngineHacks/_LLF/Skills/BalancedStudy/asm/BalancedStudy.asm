.thumb

.global BalancedStudy
.type BalancedStudy, %function


		BalancedStudy:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =CheckIfBalancedStudyIsActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
			
			mov		r1, #0x5A @damage dealt
			ldrh	r0, [r4,r1]
			add		r0, #5
			strh	r0, [r4,r1]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

