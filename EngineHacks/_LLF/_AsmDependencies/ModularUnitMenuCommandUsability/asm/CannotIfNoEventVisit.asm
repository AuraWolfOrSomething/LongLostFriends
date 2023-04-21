.thumb

.include "../MumcuDefs.s"

.global CannotIfNoEventVisit
.type CannotIfNoEventVisit, %function


		CannotIfNoEventVisit:
		push	{r14}
		ldrb	r1, [r0,#0x11]
		ldrb	r0, [r0,#0x10]
		ldr		r2, =GetLocationEventCommandAt
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0x10
		beq		CanUse
		
			mov		r0, #0
			b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

