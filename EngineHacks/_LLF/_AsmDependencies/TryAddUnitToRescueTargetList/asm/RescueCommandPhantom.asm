.thumb

.global RescueCommandPhantom
.type RescueCommandPhantom, %function


		RescueCommandPhantom:
		mov		r2, #0
		
		@If the active unit is a phantom, they cannot rescue
		ldr		r0, [r0,#4]
		ldrb	r0, [r0,#4]
		cmp		r0, #0x51
		beq		End

			@If the target is a phantom, they cannot be rescued
			ldr		r1, [r1,#4]
			ldrb	r1, [r1,#4]
			cmp		r1, #0x51
			beq		End
			
				mov		r2, #1
		
		End:
		mov		r0, r2
		bx		r14
		
		.align
		.ltorg

