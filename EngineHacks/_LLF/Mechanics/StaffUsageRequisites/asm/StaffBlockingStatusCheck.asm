.thumb

.global StaffBlockingStatusCheck
.type StaffBlockingStatusCheck, %function


		StaffBlockingStatusCheck:
		add		r0, #0x30
		ldrb	r0, [r0]
		mov		r1, #0x0F
		and		r0, r1
		cmp		r0, #2 @sleep
		beq		CannotWield
		
			cmp		r0, #4 @berserk
			beq		CannotWield
		
				cmp		r0, #3 @silence
				beq		CannotWield
		
					mov		r0, #1
					b		End
		
		CannotWield:
		mov		r0, #0
		
		End:
		bx		r14
		
		.align
		.ltorg

