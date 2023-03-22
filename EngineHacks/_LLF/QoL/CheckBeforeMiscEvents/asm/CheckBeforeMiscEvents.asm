.thumb

.include "../CheckBeforeMiscEventsDefs.s"

.global CheckBeforeMiscEvents
.type CheckBeforeMiscEvents, %function


		CheckBeforeMiscEvents:
		push	{r4,r14}
		ldr		r4, =CheckBeforeMiscEventsList
		
		LoopThroughList:
		ldr		r0, [r4]
		cmp		r0, #0
		beq		End
		
			mov		lr, r0
			.short	0xF800
			add		r4, #4
			b		LoopThroughList
		
		End:
		ldr		r0, =MaybeRunPostActionEvents
		mov		lr, r0
		.short	0xF800
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

