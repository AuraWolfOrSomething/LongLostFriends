.thumb

.global MakeTargetListForAbsorb
.type MakeTargetListForAbsorb, %function


		MakeTargetListForAbsorb:
		push	{r14}
		mov		r2, r1
		ldr		r1, =AbsorbStaffRangeSetup
		mov		lr, r1
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

