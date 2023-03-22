.thumb

.global RescueCommandBerserkCheck
.type RescueCommandBerserkCheck, %function


		RescueCommandBerserkCheck:
		push	{r4,r14}
		mov		r4, #1
		mov		r0, r1
		ldr		r1, =IsBerserkStatusActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r4, #0
		
		End:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

