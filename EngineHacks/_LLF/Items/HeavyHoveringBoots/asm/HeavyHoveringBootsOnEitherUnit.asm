.thumb

.include "../HeavyHoveringBootsDefs.s"

.global HeavyHoveringBootsOnEitherUnit
.type HeavyHoveringBootsOnEitherUnit, %function



		HeavyHoveringBootsOnEitherUnit:
		push	{r4-r5,r14}
		mov		r4, #0
		mov		r5, r1 @target
		
		@If active unit has item, cannot rescue
		ldr		r1, =HeavyHoveringBootsIDLink
		ldrb	r1, [r1]
		ldr		r3, =UnitHasItem
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		bne		End
		
			@If target has item, cannot be rescued
			mov		r0, r5
			ldr		r1, =HeavyHoveringBootsIDLink
			ldrb	r1, [r1]
			ldr		r3, =UnitHasItem
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			bne		End
			
				mov		r4, #1
		
		End:
		mov		r0, r4
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

