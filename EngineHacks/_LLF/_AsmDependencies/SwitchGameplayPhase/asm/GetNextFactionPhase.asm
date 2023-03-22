.thumb

.equ origin, 0
.include "../SwitchGameplayPhaseDefs.s"

.global GetNextFactionPhase
.type GetNextFactionPhase, %function


		GetNextFactionPhase:
		ldr		r2, =PhaseOrder
		
		FindFollowingPhase:
		ldrb	r1, [r2]
		add		r2, #8
		cmp		r1, r0
		beq		CheckIfNewTurn
		
			cmp		r1, #0xFF
			bne		FindFollowingPhase
		
				b		SignalTurnAdvance
		
		@In vanilla, new turn when phase change is NPC -> Player
		CheckIfNewTurn:
		mov		r0, r2
		ldrb	r1, [r0]
		cmp		r1, #0xFF
		bne		End
		
			SignalTurnAdvance:
			mov		r0, #0
			
		End:
		bx		r14
		
		.align
		.ltorg

