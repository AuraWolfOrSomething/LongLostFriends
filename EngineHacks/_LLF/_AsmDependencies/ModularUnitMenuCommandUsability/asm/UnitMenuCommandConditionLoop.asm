.thumb

.include "../MumcuDefs.s"

.global UnitMenuCommandConditionLoop
.type UnitMenuCommandConditionLoop, %function


		UnitMenuCommandConditionLoop:
		push	{r4-r5,r14}
		mov		r4, r0
		ldr		r5, =gActiveUnit
		
		TheLoop:
		ldr		r1, [r4]
		cmp		r1, #0
		beq		CanUse
		
			ldr		r0, [r5]
			mov		lr, r1
			.short	0xF800
			add		r4, #4
			cmp		r0, #1
			beq		TheLoop
			
				@For other results (e.g. 2 for grayed out)
				cmp		r0, #0
				bne		End
				
					mov		r0, #3
					b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

