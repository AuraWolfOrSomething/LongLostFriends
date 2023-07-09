.thumb

.global MakeTargetListForShift
.type MakeTargetListForShift, %function


		MakeTargetListForShift:
		push	{r14}
		mov		r2, r1
		ldr		r1, =ShiftStaffRangeSetup
		mov		lr, r1
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

