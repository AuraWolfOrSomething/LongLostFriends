.thumb

.include "../MumcuDefs.s"

.global CannotIfInsideBallista
.type CannotIfInsideBallista, %function


		CannotIfInsideBallista:
		ldr		r0, [r0,#0x0C]
		mov		r1, #0x81
		lsl		r1, #4
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

