.thumb

.include "../LullDefs.s"

.global TryAddUnitToLullTargetList
.type TryAddUnitToLullTargetList, %function


		TryAddUnitToLullTargetList:
		push	{r4,r14}
		mov		r4, r0
		
		@Check if unit is being rescued
		ldr		r0, [r4,#0x0C]
		mov		r1, #0x20
		tst		r0, r1
		bne		UnitNotAdded
			
			@At least one of the two must be true for unit to be a valid target:
			
			@Unit is not at max hp
			ldrb	r0, [r4,#0x12]
			ldrb	r1, [r4,#0x13]
			cmp		r0, r1
			bne		AddToTargetList
				
			@Unit does not already have Lull debuff
			mov		r0, r4
			ldr		r1, =IsLullDebuffActive
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			bne		UnitNotAdded
				
		AddToTargetList:
		mov		r0, #0x10
		ldsb	r0, [r4,r0]
		mov		r1, #0x11
		ldsb	r1, [r4,r1]
		mov		r2, #0x0B
		ldsb	r2, [r4,r2]
		mov		r3, #0
		ldr		r4, =AddTarget
		mov		lr, r4
		.short	0xF800
		mov		r0, #1
		b		End
		
		UnitNotAdded:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

