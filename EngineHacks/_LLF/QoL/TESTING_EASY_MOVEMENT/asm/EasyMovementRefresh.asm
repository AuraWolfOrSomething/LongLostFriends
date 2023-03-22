.thumb

.global EasyMovementRefresh
.type EasyMovementRefresh, %function


		EasyMovementRefresh:
		@check if dead
		ldrb	r0, [r4,#0x13]
		cmp		r0, #0
		beq		End
		
		@check if same character
		ldrb	r0, [r6,#0x0C]
		ldrb	r1, [r4,#0x0B]
		cmp		r0, r1
		bne		End
		
		@check if player unit
		lsr		r0, #6
		cmp		r0, #0
		bne		End
		
		ldr		r0, [r4,#0x0C]
		mov		r1, #0x42
		mvn		r1, r1
		and		r0, r1
		str		r0, [r4,#0x0C]
		
		End:
		bx		r14

