.thumb

.global CannotIfCantoing
.type CannotIfCantoing, %function


		CannotIfCantoing:
		ldr		r1, [r0,#0x0C]
		mov		r2, #0x40
		tst		r1, r2
		beq		CanUse
		
			mov		r0, #0
			b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

