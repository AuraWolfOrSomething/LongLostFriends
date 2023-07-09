.thumb

.include "../ShiftDefs.s"

.global ShiftUsability
.type ShiftUsability, %function


		ShiftUsability:
		push	{r14}
		mov		r2, r1
		ldr		r1, =ShiftStaffRangeSetup
		ldr		r3, =IsGeneratedTargetListEmpty
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

