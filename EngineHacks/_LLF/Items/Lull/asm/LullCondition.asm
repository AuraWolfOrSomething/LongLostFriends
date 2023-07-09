.thumb

.include "../LullDefs.s"

.global LullCondition
.type LullCondition, %function


		LullCondition:
		push	{r14}
		mov		r2, r1
		ldr		r1, =LullStaffRangeSetup
		ldr		r3, =IsGeneratedTargetListEmpty
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

