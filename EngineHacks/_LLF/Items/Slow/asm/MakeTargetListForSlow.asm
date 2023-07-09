.thumb

.global MakeTargetListForSlow
.type MakeTargetListForSlow, %function


		MakeTargetListForSlow:
		push	{r14}
		mov		r2, r1
		ldr		r1, =SlowStaffRangeSetup
		mov		lr, r1
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

