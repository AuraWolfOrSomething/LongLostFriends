.thumb

.equ gActiveBattleUnit, 0x0203A4EC
.equ GetUnit, 0x08019430
.equ gEventSlotC, 0x030004E8

.global AsmcWasDefenderCaptured
.type AsmcWasDefenderCaptured, %function


		AsmcWasDefenderCaptured:
		push	{r14}
		ldr		r0, =gActiveBattleUnit
		ldrb	r0, [r0,#0x0B]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		ldr		r1, =Is_Capture_Set
		mov		lr, r1
		.short	0xF800
		ldr		r1, =gEventSlotC
		str		r0, [r1]
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

