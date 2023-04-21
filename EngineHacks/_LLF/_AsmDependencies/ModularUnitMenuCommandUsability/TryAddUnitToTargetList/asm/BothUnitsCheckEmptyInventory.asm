.thumb

.global BothUnitsCheckEmptyInventory
.type BothUnitsCheckEmptyInventory, %function


		BothUnitsCheckEmptyInventory:
		ldrh	r0, [r0,#0x1E]
		cmp		r0, #0
		bne		CanUse
		
			ldrh	r0, [r1,#0x1E]
			cmp		r0, #0
			beq		End
		
		CanUse:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

