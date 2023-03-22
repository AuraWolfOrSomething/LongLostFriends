.thumb

.equ origin, 0
.include "../SwitchGameplayPhaseDefs.s"

.global GetPreviousFactionPhase
.type GetPreviousFactionPhase, %function


		GetPreviousFactionPhase:
		ldr		r2, =PhaseOrder
		cmp		r0, #0
		bne		FindPreviousPhase
		
			mov		r0, #0xFF
		
		FindPreviousPhase:
		ldrb	r1, [r2,#8]
		cmp		r1, r0
		beq		End
		
			cmp		r1, #0xFF @if end of the list is reached, simply use the last phase as the result
			beq		End
			
				add		r2, #8
				b		FindPreviousPhase
			
		End:
		mov		r0, r2
		bx		r14
		
		.align
		.ltorg

