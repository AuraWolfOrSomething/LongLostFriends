.thumb

.include "../PlanDefs.s"

.global FutureNoTurnEvents
.type FutureNoTurnEvents, %function


		FutureNoTurnEvents:
		push	{r14}
		ldr		r0, =FutureNoMoreTurnEventsEvent
		mov		r1, #1
		ldr		r2, =CallMapEventEngine
		mov		lr, r2
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

