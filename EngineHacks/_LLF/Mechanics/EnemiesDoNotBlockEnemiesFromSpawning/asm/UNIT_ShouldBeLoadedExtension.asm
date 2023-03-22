.thumb

.equ gMapUnit, 0x0202E4D8

.global UNIT_ShouldBeLoadedExtension
.type UNIT_ShouldBeLoadedExtension, %function


		UNIT_ShouldBeLoadedExtension:
		push	{r4,r14}
		mov		r4, r0
		
		@Game has already confirmed this unit doesn't have a REDA
		@Check if another unit is at their spawn point
		ldrh	r0, [r4,#4]
		lsl		r0, #0x14
		lsr		r0, #0x1A
		ldr		r1, =gMapUnit
		ldr		r1, [r1]
		lsl		r0, #2
		add		r0, r1
		ldrb	r1, [r4,#4]
		lsl		r1, #0x1A
		lsr		r1, #0x1A
		ldr		r0, [r0]
		add		r0, r1
		ldrb	r0, [r0]
		cmp		r0, #0
		beq		End @nobody already there = unit can spawn
		
			@Check if the unit there is an enemy unit
			mov		r1, #0x80
			tst		r0, r1
			bne		SpawnUnit
			
				mov		r0, #1
				b		End
		
		SpawnUnit:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

