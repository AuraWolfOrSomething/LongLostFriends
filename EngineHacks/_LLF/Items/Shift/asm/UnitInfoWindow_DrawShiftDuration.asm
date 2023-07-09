.thumb

.include "../ShiftDefs.s"

.global UnitInfoWindow_DrawShiftDuration
.type UnitInfoWindow_DrawShiftDuration, %function


		UnitInfoWindow_DrawShiftDuration:
		push	{r4-r5,r14}
		mov		r4, r0
		mov		r5, r1 @unit
		
		@Text: "Duration"
		ldr		r1, =Text_Clear
		mov		lr, r1
		.short	0xF800
		ldr		r0, =DurationLabelLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		ldr		r3, =Text_InsertString
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0 @spacing
		mov		r2, #3 @font
		.short	0xF800
		
		ldr		r3, =Text_InsertNumberOr2Dashes
		mov		lr, r3
		mov		r3, #3
		mov		r0, r4
		mov		r1, #0x32 @spacing
		mov		r2, #2 @font
		.short	0xF800
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

