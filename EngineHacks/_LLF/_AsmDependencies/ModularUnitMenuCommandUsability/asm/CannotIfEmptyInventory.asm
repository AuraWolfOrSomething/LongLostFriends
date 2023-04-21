.thumb

.include "../MumcuDefs.s"

.global CannotIfEmptyInventory
.type CannotIfEmptyInventory, %function


		CannotIfEmptyInventory:
		ldrh	r0, [r0,#0x1E]
		cmp		r0, #0
		beq		End
		
			mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

