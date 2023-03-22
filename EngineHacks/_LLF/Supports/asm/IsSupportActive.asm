.thumb

.global IsSupportActive
.type IsSupportActive, %function

@r0 = unit
@r1 = partner's character id

@check if unit has partner as active support

		IsSupportActive:
		add		r0, #0x38
		ldrb	r0, [r0]
		cmp		r0, r1
		bne		NotActive
		
			mov		r0, #1
			b		End
		
		NotActive:
		mov		r0, #0
		
		End:
		bx		r14
		
		.align
		.ltorg

