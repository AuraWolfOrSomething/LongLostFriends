.thumb

.global UnitPrepExtraSupportAffinityDraw
.type UnitPrepExtraSupportAffinityDraw, %function


		UnitPrepExtraSupportAffinityDraw:
		ldr		r2, =CharacterTable
		add		r0, r2
		ldrb	r0, [r0,#9]
		sub		r0, #1
		mov		r1, #2
		lsl		r1, #8
		orr		r1, r0
		mov		r2, #0xE0
		lsl		r2, #8
		bx		r14
		
		.align
		.ltorg

