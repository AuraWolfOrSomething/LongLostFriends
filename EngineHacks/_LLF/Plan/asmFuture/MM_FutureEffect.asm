.thumb

.include "../PlanDefs.s"

.global MM_FutureEffect
.type MM_FutureEffect, %function


		MM_FutureEffect:
		push	{r14}
		
		@Block standard gameplay from happening until this is complete
		ldr		r0, =gProc_PlayerPhase
		ldr		r1, =ProcFind
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		ldr		r0, =ProcFutureCommand
		ldr		r2, =ProcStartBlocking
		mov		lr, r2
		.short	0xF800
		
		mov		r0, #0x1B
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


