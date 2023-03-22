.thumb

.global FindTextIdForAi
.type FindTextIdForAi, %function

@given unit, return text id


		FindTextIdForAi:
		mov		r2, #0xFF
		lsl		r2, #8
		mov		r3, #0xFF
		add		r2, r3 @0xFFFF
		add		r0, #0x42
		ldrb	r1, [r0,#2] @secondary ai
		ldrb	r0, [r0] @primary ai
		lsl		r0, #8
		add		r0, r1
		ldr		r3, =AiOneTwoTextIdList
		
		LoopThroughList:
		ldrh	r1, [r3]
		cmp		r1, r0
		beq		TextIdFound
		
			cmp		r1, r2 @if end of list reached, display "Other"
			beq		TextIdFound
		
				add		r3, #4
				b		LoopThroughList
		
		TextIdFound:
		ldrh	r0, [r3,#2]
		bx		r14

		.align
		.ltorg

