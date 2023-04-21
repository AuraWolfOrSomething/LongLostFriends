.thumb

.global GetUnitHighestWexp
.type GetUnitHighestWexp, %function

		
		GetUnitHighestWexp:
		add		r0, #0x28
		mov		r1, #0 @loop counter
		mov		r3, #0 @current highest
		
		LoopThroughUnitRanks:
		ldrb	r2, [r0,r1]
		cmp		r2, r3
		ble		NextRank
		
			mov		r3, r2
			
			NextRank:
			add		r1, #1
			cmp		r1, #8
			blt		LoopThroughUnitRanks
			
		
		mov		r0, r3
		bx		r14
		
		.align
		.ltorg

