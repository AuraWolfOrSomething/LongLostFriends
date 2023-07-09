.thumb

.include "../WardenDefs.s"

.global WardenCondition
.type WardenCondition, %function


		WardenCondition:
		push	{r14}
		mov		r2, r1
		ldr		r1, =WardenStaffRangeSetup
		ldr		r3, =IsGeneratedTargetListEmpty
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

