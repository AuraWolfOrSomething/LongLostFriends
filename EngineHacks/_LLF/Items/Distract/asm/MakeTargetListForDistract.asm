.thumb

.include "../DistractDefs.s"

.global MakeTargetListForDistract
.type MakeTargetListForDistract, %function


		MakeTargetListForDistract:
		push	{r14}
		mov		r2, r1
		ldr		r1, =DistractStaffRangeSetup
		mov		lr, r1
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

