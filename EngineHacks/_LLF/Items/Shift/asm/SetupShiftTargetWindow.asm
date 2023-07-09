.thumb

.include "../ShiftDefs.s"

.global SetupShiftTargetWindow
.type SetupShiftTargetWindow, %function


		SetupShiftTargetWindow:
		push	{r4-r6,r14}
		add		sp, #-0x0C
		str		r0, [sp,#8] @target unit
		
		mov		r1, #0x0A
		ldr		r2, =GetUnitInfoWindowX
		mov		lr, r2
		.short	0xF800
		mov		r4, r0
		
		mov		r0, #0x0A
		str		r0, [sp]
		mov		r0, #2
		str		r0, [sp,#4]
		
		ldr		r0, =UnitInfoWindow_DrawBase
		mov		lr, r0
		mov		r0, #0
		ldr		r1, [sp,#8]
		mov		r2, r4
		mov		r3, #0
		.short	0xF800
		mov		r5, r0
		add		r5, #0x38
		
		@Display change in Pow
		mov		r0, r5
		ldr		r1, [sp,#8]
		ldr		r3, =UnitInfoWindow_ShiftDrawPower
		mov		lr, r3
		.short	0xF800
		mov		r1, r4
		add		r1, #0x61
		lsl		r1, #1
		ldr		r6, =gBg0MapBuffer
		add		r1, r6

		mov		r0, r5
		ldr		r2, =Text_Display
		mov		lr, r2
		.short	0xF800
		add		r5, #8
		
		@Display change in Spd
		mov		r0, r5
		ldr		r1, [sp,#8]
		ldr		r2, =UnitInfoWindow_ShiftDrawSpeed
		mov		lr, r2
		.short	0xF800
		mov		r1, r4
		add		r1, #0xA1
		lsl		r1, #1
		add		r1, r6
		mov		r0, r5
		ldr		r2, =Text_Display
		mov		lr, r2
		.short	0xF800
		@add		r5, #8
		
		@Display duration of debuff for this unit
		@mov		r0, r5
		@ldr		r1, [sp,#8]
		@ldr		r2, =UnitInfoWindow_DrawShiftDuration
		@mov		lr, r2
		@.short	0xF800
		@add		r4, #0xE1
		@lsl		r4, #1
		@add		r4, r6
		@mov		r0, r5
		@mov		r1, r4
		@ldr		r2, =Text_Display
		@mov		lr, r2
		@.short	0xF800
		
		add		sp, #0x0C
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

