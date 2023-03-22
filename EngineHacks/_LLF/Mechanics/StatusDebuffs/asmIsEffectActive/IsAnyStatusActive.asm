.thumb

.global IsAnyStatusActive
.type IsAnyStatusActive, %function


		IsAnyStatusActive:
		mov		r1, #0x30
		ldrb	r0, [r0,r1]
		cmp		r0, #0
		beq		End
		
			mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

