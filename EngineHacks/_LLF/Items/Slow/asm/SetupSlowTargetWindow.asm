.thumb

.include "../SlowDefs.s"

.global SetupSlowTargetWindow
.type SetupSlowTargetWindow, %function


		SetupSlowTargetWindow:
		push	{r4-r7,r14}
		add		sp, #-0x0C
		str		r0, [sp,#8] @target unit
		
		mov		r1, #0x0A
		ldr		r2, =GetUnitInfoWindowX
		mov		lr, r2
		.short	0xF800
		mov		r4, r0
		
		mov		r0, #0x0A
		str		r0, [sp]
		mov		r0, #1
		str		r0, [sp,#4]
		
		ldr		r0, =UnitInfoWindow_DrawBase
		mov		lr, r0
		mov		r0, #0
		ldr		r1, [sp,#8]
		mov		r2, r4
		mov		r3, #0
		.short	0xF800
		mov		r5, r0
		mov		r7, #0x38
		add		r7, r5
		
		@Display what unit's highest rank would be lowered to
		mov		r0, r7
		ldr		r1, [sp,#8]
		ldr		r3, =UnitInfoWindow_SlowDrawMov
		mov		lr, r3
		.short	0xF800
		mov		r1, r4
		add		r1, #0x61
		lsl		r1, #1
		ldr		r6, =gBg0MapBuffer
		add		r1, r6
		mov		r0, r7
		ldr		r2, =Text_Display
		mov		lr, r2
		.short	0xF800

		add		sp, #0x0C
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

