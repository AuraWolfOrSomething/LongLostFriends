.thumb

.include "../MumcuDefs.s"

.global CannotIfCarryingUnit
.type CannotIfCarryingUnit, %function


		CannotIfCarryingUnit:
		ldr		r0, [r0,#0x0C]
		mov		r1, #0x10
		tst		r0, r1
		beq		CanUse
		
			mov		r0, #0
			b		End
			
		CanUse:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

