.thumb

.global IsDeadPlayerUnitPhantom
.type IsDeadPlayerUnitPhantom, %function


		IsDeadPlayerUnitPhantom:
		mov		r1, #0
		ldr		r0, [r0,#4]
		ldrb	r0, [r0,#4]
		cmp		r0, #0x51
		bne		End
		
			@Do not store if phantom
			mov		r1, #1
		
		End:
		mov		r0, r1
		bx		r14
		
		.align
		.ltorg

