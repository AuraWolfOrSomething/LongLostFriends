.thumb

.global TargetCheckSupplyBit
.type TargetCheckSupplyBit, %function


		TargetCheckSupplyBit:
		ldr		r0, [r1]
		ldr		r0, [r0,#0x28]
		ldr		r1, [r1,#4]
		ldr		r1, [r1,#0x28]
		orr		r0, r1
		mov		r1, #0x80
		lsl		r1, #2
		tst		r0, r1
		bne		CannotUse
		
			mov		r0, #1
			b		End
		
		CannotUse:
		mov		r0, #0
		
		End:
		bx		r14
		
		.align
		.ltorg

