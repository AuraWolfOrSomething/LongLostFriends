.thumb

.global TargetCheckCannotIfRescuedUnit
.type TargetCheckCannotIfRescuedUnit, %function


		TargetCheckCannotIfRescuedUnit:
		mov		r0, #0
		ldr		r1, [r1,#0x0C]
		mov		r2, #0x20
		tst		r1, r2
		bne		End
		
			mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

