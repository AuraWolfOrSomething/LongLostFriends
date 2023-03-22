.thumb

.global GetUnitAtCursor
.type GetUnitAtCursor, %function

.equ gGameState, 0x0202BCB0
.equ gMapUnit, 0x0202E4D8
.equ GetUnit, 0x08019430
		
		GetUnitAtCursor:
		push	{r14}
		ldr		r3, =gGameState
		mov		r2, #0x16
		ldsh	r0, [r3,r2]
		ldr		r1, =gMapUnit
		ldr		r1, [r1]
		lsl		r0, #2
		add		r0, r1
		mov		r2, #0x14
		ldsh	r1, [r3,r2]
		ldr		r0, [r0]
		add		r0, r1
		ldrb	r0, [r0]
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

