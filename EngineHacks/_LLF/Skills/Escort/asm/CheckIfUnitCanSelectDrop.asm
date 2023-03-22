.thumb

.include "../EscortDefs.s"

.global CheckIfUnitCanSelectDrop
.type CheckIfUnitCanSelectDrop, %function


		CheckIfUnitCanSelectDrop:
		push	{r4, lr}
		ldr		r0, =gActiveUnit
		ldr		r0, [r0]
		mov		r4, r0
		ldr		r3, =ReturnEscortTier
		mov		lr, r3
		.short	0xF800
		
		@skip canto check if unit has escort+
		ldr		r2, [r4,#0x0C]
		cmp		r0, #2
		beq		HasEscortPlus
		
			mov		r0, #0x40
			tst		r0, r2
			bne		CannotSelect
		
		HasEscortPlus:
		mov		r0, #0x10
		tst		r2, r0
		beq		CannotSelect
		
			mov		r0, r4
			ldr		r3, =MakeDropTargetList
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

