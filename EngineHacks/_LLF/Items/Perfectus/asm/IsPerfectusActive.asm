.thumb

.global IsPerfectusActive
.type IsPerfectusActive, %function


		IsPerfectusActive:
		push	{r14}
		ldr		r1, =PerfectusIDLink
		ldrb	r1, [r1]
		mov		r2, #1 @exclude any Perfectus with zero durability
		ldr		r3, =FindItemInUnitInventory
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


