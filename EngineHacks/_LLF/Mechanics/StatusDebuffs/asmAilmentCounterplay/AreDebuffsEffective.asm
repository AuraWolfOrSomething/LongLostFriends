@Return 0 if at least one factor is preventing the unit from being affected by a debuff
@Return 1 if nothing is preventing that 

.thumb

.equ origin, 0
.include "../StatusDebuffsDefs.s"

.global AreDebuffsEffective
.type AreDebuffsEffective, %function


		AreDebuffsEffective:
		push	{r4-r6,r14}
		mov		r4, r0 @unit
		ldr		r5, =DebuffExceptionList
		mov		r6, #1 @see the top of this file
		
		LoopThroughList:
		ldr		r0, [r5]
		cmp		r0, #0
		beq		End
		
			mov		lr, r0
			mov		r0, r4
			.short	0xF800
			cmp		r0, #0
			bne		PreventionDetected
			
				add		r5, #4
				b		LoopThroughList
				
		PreventionDetected:
		mov		r6, #0
		
		End:
		mov		r0, r6
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

