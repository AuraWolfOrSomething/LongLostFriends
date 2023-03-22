.thumb

.include "../HeavyHoveringBootsDefs.s"

.global HeavyHoveringBootsCheck
.type HeavyHoveringBootsCheck, %function


		HeavyHoveringBootsCheck:
		push	{r14}
		ldr		r1, =HeavyHoveringBootsIDLink
		ldrb	r1, [r1]
		ldr		r3, =UnitHasItem
		mov		lr, r3
		.short	0xF800
		
		cmp		r0, #0
		beq		End
		
			mov		r0, #3
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

