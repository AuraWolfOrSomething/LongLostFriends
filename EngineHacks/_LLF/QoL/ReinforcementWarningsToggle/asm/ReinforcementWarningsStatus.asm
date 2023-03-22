.thumb

.include "../ReinforcementWarningsToggleDefs.s"

.global ReinforcementWarningsStatus
.type ReinforcementWarningsStatus, %function


		ReinforcementWarningsStatus:
		push	{r14}
		ldr		r0, =ReinforcementWarningsToggleEventIDLink
		ldrh	r0, [r0]
		ldr		r1, =CheckEventID
		mov		lr, r1
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

