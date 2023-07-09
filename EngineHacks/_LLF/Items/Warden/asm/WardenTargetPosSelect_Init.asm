.thumb

.include "../WardenDefs.s"

.global WardenTargetPosSelect_Init
.type WardenTargetPosSelect_Init, %function


		WardenTargetPosSelect_Init:
		push	{r4-r6,r14}
		mov		r5, r0
		ldr		r6, =gGameState
		ldrb	r1, [r6,#4]
		mov		r0, #1
		orr		r0, r1
		strb	r0, [r6,#4]
		
		@mov		r0, #0
		@str		r0, [r5]
		@mov		r0, #1
		@ldr		r1, =prNewFreeSelect
		@orr		r1, r0
		@mov		r0, r5
		@mov		lr, r1
		@.short	0xF800
		
		@Cursor
		ldr		r0, =gAP_SelectCursorThing
		mov		r1, #0
		ldr		r2, =AP_Create
		mov		lr, r2
		.short	0xF800
		@mov		r7, r0
		str		r0, [r5,#0x30]
		mov		r1, #0
		ldr		r2, =gMapRange
		ldr		r2, [r2]
		ldrh	r3, [r6,#0x16]
		lsl		r3, #2
		add		r1, r3, r2
		ldr		r1, [r1]
		ldrh	r3, [r6,#0x14]
		add		r1, r3
		@ldrb	r3, [r1]
		
		@Allow tile staff user is on to be a valid target
		mov		r3, #1
		strb	r3, [r1]
		
		@If cursor is on unselectable tile, use the x cursor
		@cmp		r3, #0
		@bne		SetCursor
		
			@ldr		r0, [r5,#0x30]
			@mov		r1, #1
		
		@SetCursor:
		mov		r1, #0
		ldr		r2, =AP_SetAnimation
		mov		lr, r2
		.short	0xF800
		
		@str	r7, [r5,#0x54]
		@mov	r0, #2
		@mov	r1, #0x4A
		@strh	r0, [r5,r1]
		
		@Text at the bottom
		ldr		r0, =WardenTargetBottomTextLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r0, r5
		ldr		r2, =StartBottomHelpText
		mov		lr, r2
		.short	0xF800
		
		ldr		r4, =gActiveUnit
		ldr		r4, [r4]
		ldrb	r0, [r4,#0x10]
		ldrb	r1, [r4,#0x11]
		ldr		r2, =ShouldMoveCameraPosSomething
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r0, r5
			ldrb	r1, [r4,#0x10]
			ldrb	r2, [r4,#0x11]
			ldr		r3, =EnsureCameraOntoPosition
			mov		lr, r3
			.short	0xF800
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

