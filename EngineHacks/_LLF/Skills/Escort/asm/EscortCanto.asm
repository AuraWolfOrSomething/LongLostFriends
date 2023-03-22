.thumb

.include "../EscortDefs.s"

.global EscortCanto
.type EscortCanto, %function


		EscortCanto:
		push	{r14}
		
		@check if dead
		ldrb	r0, [r4,#0x13]
		cmp		r0, #0
		beq		End
		
			@check if moved all the squares
			ldr		r3, =prGotoMovGetter
			mov		lr, r3
			mov		r0, r4
			.short	0xF800
			ldrb 	r1, [r6,#0x10]	@squares moved this turn
			cmp		r0, r1
			beq		End

				ldr		r3, =CanActiveUnitMove	@check if can move again
				mov		lr, r3
				.short	0xF800
				lsl		r0, #0x18
				cmp		r0, #0
				beq		End
		
					@check if rescued this turn
					ldrb  	r0, [r6,#0x11]  @action taken this turn
					cmp 	r0, #0x09
					beq 	ContinueRescueCheck
		
						ldr		r0, =gGameState
						add		r0, #0x3D
						ldrb	r0, [r0]
						mov		r1, #0x10
						tst		r0, r1
						beq		End
		
		ContinueRescueCheck:
		ldrb  	r0, [r6,#0x0C]  @allegiance byte of the current character taking action
		ldrb  	r1, [r4,#0x0B]  @allegiance byte of the character we are checking
		cmp 	r0, r1    @check if same character
		bne 	End
		
			@check if already cantoing
			ldr		r0, [r4,#0x0C]	@status bitfield
			mov		r1, #0x40	@has moved already
			and		r0, r1
			cmp		r0, #0
			bne		End
		
				@check for Escort or Escort+
				mov		r0, r4
				ldr		r3, =ReturnEscortTier
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				beq		End
		
					ldr		r0, [r4,#0x0C]	@status bitfield
					mov		r1, #0x02
					mvn		r1, r1
					and		r0, r1		@unset bit 0x2
					mov		r1, #0x40	@set canto bit
					orr		r0, r1
					str		r0, [r4,#0x0C]
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

