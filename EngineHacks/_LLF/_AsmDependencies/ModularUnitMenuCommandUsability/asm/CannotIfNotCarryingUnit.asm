.thumb

.include "../MumcuDefs.s"

.global CannotIfNotCarryingUnit
.type CannotIfNotCarryingUnit, %function


		CannotIfNotCarryingUnit:
		ldr		r0, [r0,#0x0C]
		mov		r1, #0x10
		and		r0, r1
		cmp		r0, #0
		beq		End
		
			mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

