.thumb

.include "../HeavyHoveringBootsDefs.s"

.global CannotRetrieveHhbWhileRescuing
.type CannotRetrieveHhbWhileRescuing, %function


		CannotRetrieveHhbWhileRescuing:
		
		@finish what vanilla was doing to get item short
		ldrh	r0, [r0]
		lsl		r0, #2
		ldr		r3, =gPrepScreenItemList
		add		r0, r3
		ldrh	r0, [r0,#2]
		
		@if unit isn't rescuing anyone, can always get items
		ldrb	r2, [r2,#0x1B]
		cmp		r2, #0
		beq		CanStore
		
			@if item isn't hhb, they can get it
			lsl		r2, r0, #24
			lsr		r2, #24
			ldr		r3, =HeavyHoveringBootsIDLink
			ldrb	r3, [r3]
			cmp		r2, r3
			bne		CanStore
			
				mov		r0, #0
				b		End
		
		CanStore:
		strh	r0, [r1]
		
		End:
		bx		r14
		
		.align
		.ltorg

