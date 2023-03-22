.thumb

.include "../EscortDefs.s"

.global CheckIfUnitCanSelectGive
.type CheckIfUnitCanSelectGive, %function


		CheckIfUnitCanSelectGive:
		push	{r4, lr}
		ldr		r0, =gActiveUnit
		ldr		r0, [r0]
		mov		r4, r0
		ldr		r3, =ReturnEscortTier
		mov		lr, r3
		.short	0xF800
		
		@skip canto check if unit has escort or escort+
		ldr		r2, [r4,#0x0C]
		cmp		r0, #0
		bne		HasEscort
		
			mov		r0, #0x40
			tst		r0, r2
			bne		CannotSelect
		
		HasEscort:
		@checks if unit has already used Give or Take
			@if so, can't use Give
		@ldr		r0, =gGameState
		@add		r0, #0x3D
		@ldrb	r1, [r0]
		@mov		r0, #1
		@tst		r0, r1
		@bne		CannotSelect
		
		mov		r0, #0x10
		tst		r2, r0
		beq		CannotSelect
		
			mov		r0, r4
			ldr		r3, =MakeGiveTargetList
			mov		lr, r3
			.short	0xF800
			ldr		r3, =GetTargetListSize
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		CannotSelect
		
				mov		r0, #1
				b		End
		
		CannotSelect:
		mov		r0, #3
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

