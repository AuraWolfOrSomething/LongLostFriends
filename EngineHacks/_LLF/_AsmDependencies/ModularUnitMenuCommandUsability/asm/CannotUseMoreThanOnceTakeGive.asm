.thumb

.include "../MumcuDefs.s"

.global CannotUseMoreThanOnceTakeGive
.type CannotUseMoreThanOnceTakeGive, %function


		CannotUseMoreThanOnceTakeGive:
		ldr		r0, =gGameState
		add		r0, #0x3D
		ldrb	r1, [r0]
		mov		r0, #1
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

