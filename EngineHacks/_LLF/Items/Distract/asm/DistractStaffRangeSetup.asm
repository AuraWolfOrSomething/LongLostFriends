.thumb

.include "../DistractDefs.s"

.global DistractStaffRangeSetup
.type DistractStaffRangeSetup, %function


		DistractStaffRangeSetup:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =TryAddUnitToDistractTargetList
		ldr		r3, =Item_TURange
		mov		lr, r3
		.short	0xF800
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

