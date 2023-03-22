.thumb

.global NullifyAvoidIfSleeping
.type NullifyAvoidIfSleeping, %function


		NullifyAvoidIfSleeping:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =IsSleepStatusActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End

			mov		r0, #0x62
			mov		r1, #0x00
			strh	r1, [r4,r0]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

