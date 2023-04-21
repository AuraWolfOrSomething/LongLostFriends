.thumb

.global TargetCheckAlreadyTraveling
.type TargetCheckAlreadyTraveling, %function


		TargetCheckAlreadyTraveling:
		mov		r0, #0
		ldr		r1, [r1,#0x0C]
		mov		r2, #0x30
		tst		r1, r2
		bne		End
		
			mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

