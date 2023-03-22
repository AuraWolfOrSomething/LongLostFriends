.thumb

.global CheckIfThisUnitUsingFortune
.type CheckIfThisUnitUsingFortune, %function


		CheckIfThisUnitUsingFortune:
		mov		r2, #0
		add		r0, #0x48
		ldrb	r0, [r0]
		ldr		r1, =FortuneLink
		ldrb	r1, [r1]
		cmp		r0, r1
		bne		ReturnResult
		
			mov		r2, #1
		
		ReturnResult:
		mov		r0, r2
		bx		r14

