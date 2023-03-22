.thumb

.include "../DistractDefs.s"

.global TryAddUnitToDistractTargetList
.type TryAddUnitToDistractTargetList, %function


		TryAddUnitToDistractTargetList:
		push	{r14}
		
		@Check if unit is being rescued
		ldr		r1, [r0,#0x0C]
		mov		r2, #0x20
		tst		r1, r2
		bne		End
		
			@Add unit to target list
			ldr		r3, =AddTarget
			mov		lr, r3
			mov		r1, #0x11
			ldsb	r1, [r0,r1]
			mov		r2, #0x0B
			ldsb	r2, [r0,r2]
			mov		r3, #0x10
			ldsb	r0, [r0,r3]
			mov		r3, #0
			.short	0xF800
			mov		r0, #1
			b		End
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

