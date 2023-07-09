.thumb

.include "../LullDefs.s"

.global LullTargetPosSelect_Cancel
.type LullTargetPosSelect_Cancel, %function


		LullTargetPosSelect_Cancel:
		push	{r14}
		ldr		r0, =Text_ResetTileAllocation
		mov		lr, r0
		.short	0xF800
		ldr		r0, =HideMoveRangeGraphics
		mov		lr, r0
		.short	0xF800
		ldr		r0, =EndBottomHelpText
		mov		lr, r0
		.short	0xF800
		ldr		r1, =gActiveUnit
		ldr		r1, [r1]
		ldrb	r0, [r1,#0x10]
		ldrb	r1, [r1,#0x11]
		ldr		r2, =SetCursorMapPosition
		mov		lr, r2
		.short	0xF800
		ldr		r0, =gProc_GoBackToUnitMenu
		mov		r1, #3
		ldr		r2, =ProcStart
		mov		lr, r2
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

