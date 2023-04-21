.thumb

.equ origin, 0
.include "../StatusDebuffsDefs.s"

.global UnitInfoWindow_DrawDebuffDuration
.type UnitInfoWindow_DrawDebuffDuration, %function


		UnitInfoWindow_DrawDebuffDuration:
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
		
		@Use generic debuff duration formula to get value
		mov		r0, r5
		ldr		r1, =CalculateDebuffDuration
		mov		lr, r1
		.short	0xF800
		ldr		r3, =Text_InsertNumberOr2Dashes
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x32 @spacing
		mov		r2, #2 @font
		.short	0xF800
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

