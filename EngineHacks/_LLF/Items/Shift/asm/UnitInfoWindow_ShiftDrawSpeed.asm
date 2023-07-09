.thumb

.include "../ShiftDefs.s"

.global UnitInfoWindow_ShiftDrawSpeed
.type UnitInfoWindow_ShiftDrawSpeed, %function


		UnitInfoWindow_ShiftDrawSpeed:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r1 @unit
		ldr		r6, =Text_InsertString
		
		@Text: "Spd"
		ldr		r1, =Text_Clear
		mov		lr, r1
		.short	0xF800
		ldr		r0, =SpdLabelLink
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
		
		@Base Spd
		mov		r0, #0
		mov		r1, r5
		ldr		r2, =prAddUnitSpeed
		mov		lr, r2
		.short	0xF800
		mov		r3, r0
		ldr		r0, =Text_InsertNumberOr2Dashes
		mov		lr, r0
		mov		r0, r4
		mov		r1, #0x1A @spacing
		mov		r2, #2 @font
		.short	0xF800
		
		ldr		r0, =ArrowTextIdLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x24 @spacing
		mov		r2, #3 @font
		mov		lr, r6
		.short	0xF800
		
		@Base Pow
		mov		r0, #0
		mov		r1, r5
		ldr		r2, =prAddUnitPower
		mov		lr, r2
		.short	0xF800
		mov		r3, r0
		ldr		r0, =Text_InsertNumberOr2Dashes
		mov		lr, r0
		mov		r0, r4
		mov		r1, #0x38 @spacing
		mov		r2, #2 @font
		.short	0xF800
		
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

