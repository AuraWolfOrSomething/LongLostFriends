.thumb

.global AiIgnoreIfOutOfRange
.type AiIgnoreIfOutOfRange, %function

@units with an exception won't be chased by enemies, but they can be attacked/targeted if in range


		AiIgnoreIfOutOfRange:
		ldr		r1, =CouldStatUnitBeInRangeExt
		cmp		r0, r1
		beq		ValidTarget
		
			mov		r0, #0
			b		End
		
		ValidTarget:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

