.thumb

.global MakeTargetListForInept
.type MakeTargetListForInept, %function


		MakeTargetListForInept:
		push	{r14}
		mov		r2, r1
		ldr		r1, =IneptStaffRangeSetup
		mov		lr, r1
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

