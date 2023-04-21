.thumb

.equ origin, 0
.include "../TryAddUnitToTargetListDefs.s"

.global TargetCheckTradeRescueeAllegiance
.type TargetCheckTradeRescueeAllegiance, %function


		TargetCheckTradeRescueeAllegiance:
		push	{r4,r14}
		mov		r4, r0
		ldrb	r0, [r0,#0x0B]
		ldrb	r1, [r1,#0x0B]
		ldr		r2, =AreAllegiancesEqual
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0
		bne		CanTrade
		
			@Allow trading with captured units
			ldrb	r1, [r4,#0x13]
			cmp		r1, #0
			beq		CanTrade
			
				mov		r0, #0
				b		End
				
		CanTrade:
		mov		r0, #1
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

