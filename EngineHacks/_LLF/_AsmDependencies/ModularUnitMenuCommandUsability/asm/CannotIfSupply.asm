.thumb

.include "../MumcuDefs.s"

.global CannotIfSupply
.type CannotIfSupply, %function


		CannotIfSupply:
		ldr		r1, [r0]
		ldr		r1, [r1,#0x28]
		ldr		r2, [r0,#4]
		ldr		r2, [r2,#0x28]
		orr		r1, r2
		mov		r2, #0x80
		lsl		r2, #2
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

