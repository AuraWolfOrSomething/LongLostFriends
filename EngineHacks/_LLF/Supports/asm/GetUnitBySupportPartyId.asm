.thumb

.global GetUnitBySupportPartyId
.type GetUnitBySupportPartyId, %function

.equ gUnitArray, 0x0202BE4C


		GetUnitBySupportPartyId:
		add		r2, r0, #1 @number of units that have supports; number goes up to (and includes) this party id
		ldr		r3, =gUnitArray
		
		NewUnitLoop:
		ldr		r1, [r3]
		ldr		r1, [r1,#0x2C]
		
		@true if no support data
		cmp		r1, #0
		beq		CheckIfSuccessfulConversion
		
			@true if support partner count is 0
			ldrb	r1, [r1,#0x15]
			cmp		r1, #0
			beq		CheckIfSuccessfulConversion
			
				@otherwise, unit has supports
				sub		r2, #1
		
		CheckIfSuccessfulConversion:
		cmp		r2, #0
		ble		End
		
			add		r3, #0x48
			b		NewUnitLoop
		
		End:
		mov		r0, r3
		bx		r14
		
		.align
		.ltorg

