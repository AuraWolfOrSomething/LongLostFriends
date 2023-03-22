@Return 1 if at least one factor is halving debuff effectiveness 
@Return 0 if nothing is

.thumb

.equ origin, 0
.include "../StatusDebuffsDefs.s"

.global AreDebuffsHalved
.type AreDebuffsHalved, %function


		AreDebuffsHalved:
		push	{r4-r6,r14}
		mov		r4, r0 @unit
		ldr		r5, =DebuffHalvingList
		mov		r6, #0 @see the top of this file
		
		LoopThroughList:
		ldr		r0, [r5]
		cmp		r0, #0
		beq		End
		
			mov		lr, r0
			mov		r0, r4
			.short	0xF800
			cmp		r0, #0
			bne		ReturnTrue
			
				add		r5, #4
				b		LoopThroughList
				
		ReturnTrue:
		mov		r6, #1
		
		End:
		mov		r0, r6
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

