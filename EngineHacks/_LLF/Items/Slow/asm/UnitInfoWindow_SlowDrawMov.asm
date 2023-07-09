.thumb

.include "../SlowDefs.s"

.global UnitInfoWindow_SlowDrawMov
.type UnitInfoWindow_SlowDrawMov, %function


		UnitInfoWindow_SlowDrawMov:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r1 @unit
		ldr		r6, =Text_InsertString
		
		@Text: "Mov"
		ldr		r1, =Text_Clear
		mov		lr, r1
		.short	0xF800
		ldr		r0, =MovementTextIDLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0 @spacing
		mov		r2, #3 @font
		mov		lr, r6
		.short	0xF800
		
		@Get unit's mov
		mov		r0, r5
		ldr		r1, =prGotoMovGetter
		mov		lr, r1
		.short	0xF800
		mov		r7, r0
		cmp		r0, #0
		bgt		DisplayMov
		
			@Display -- if unit cannot mov
			mov		r7, #0
			ldr		r3, =Text_InsertNumberOr2Dashes
			mov		lr, r3
			mov		r0, r4
			mov		r1, #0x20 @spacing
			mov		r2, #2 @font
			mov		r3, #0xFF
			.short	0xF800
			b		DisplayArrow
			
			DisplayMov:
			ldr		r3, =Text_InsertNumberOr2Dashes
			mov		lr, r3
			mov		r3, r0
			mov		r0, r4
			mov		r1, #0x1C @spacing
			mov		r2, #2 @font
			.short	0xF800

		DisplayArrow:
		ldr		r0, =ArrowTextIdLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x26 @spacing
		mov		r2, #3 @font
		mov		lr, r6
		.short	0xF800
		
		@Display mov after Slow
		cmp		r7, #0
		beq		UnitCannotMove
		
			mov		r0, r5
			ldr		r1, =DetermineSlowSeverity
			mov		lr, r1
			.short	0xF800
			sub		r7, r0
			cmp		r7, #0
			bne		UnitCanStillMove
			
				UnitCannotMove:
				ldr		r3, =Text_InsertNumberOr2Dashes
				mov		lr, r3
				mov		r0, r4
				mov		r1, #0x38 @spacing
				mov		r2, #2 @font
				mov		r3, #0xFF
				.short	0xF800
				b		End
				
				UnitCanStillMove:
				ldr		r3, =Text_InsertNumberOr2Dashes
				mov		lr, r3
				mov		r3, r7
				mov		r0, r4
				mov		r1, #0x34 @spacing
				mov		r2, #2 @font
				.short	0xF800
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

