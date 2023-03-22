.thumb

.include "../DistractDefs.s"

.global FillDistractTargetPosRangeMap
.type FillDistractTargetPosRangeMap, %function


		FillDistractTargetPosRangeMap:
		push	{r4-r7,r14}
		add		sp, #-0x04
		str		r0, [r13]
		
		ldr		r6, =gMapMovement
		ldr		r0, [r6]
		mov		r1, #1
		neg		r1, r1
		ldr		r7, =ClearMapWith
		mov		lr, r7
		.short	0xF800
		ldr		r0, =gMapRange
		ldr		r0, [r0]
		mov		r1, #0
		mov		lr, r7
		.short	0xF800
		
		ldr		r0, [r13]
		mov		r4, #0x10
		ldsb	r4, [r0,r4]
		mov		r5, #0x11
		ldsb	r5, [r0,r5]
		ldr		r1, =prMovGetter
		mov		lr, r1
		.short	0xF800
		
		@Limit movement from Distract staff to 4
		cmp		r0, #4
		ble		GoToSomething
		
			mov		r0, #4
		
		GoToSomething:
		@copy DisplayUnitEffectRange (0801CB70)
		mov		r1, r0
		ldr		r0, [r13]
		ldr		r2, =FillMovementMapForUnitAndMovement
		mov		lr, r2
		.short	0xF800
		
		ldr		r0, =gMapMovement2
		ldr		r0, [r0]
		mov		r1, #0
		mov		lr, r7
		.short	0xF800
		
		mov		r0, #1
		ldr		r1, =DisplayMoveRangeGraphics
		mov		lr, r1
		.short	0xF800
		
		add		sp, #0x04
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

