.thumb

.global CannotIfPhantom
.type CannotIfPhantom, %function


		CannotIfPhantom:
		ldr		r0, [r0,#4]
		ldrb	r0, [r0,#4]
		cmp		r0, #0x51
		bne		CanUse
		
			mov		r0, #0
			b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

