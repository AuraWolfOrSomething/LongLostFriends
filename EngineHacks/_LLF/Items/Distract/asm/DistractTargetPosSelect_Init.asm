@Basically all of this is just ripped from warp, so apologies for the lack of comments

.thumb

.include "../DistractDefs.s"

.global DistractTargetPosSelect_Init
.type DistractTargetPosSelect_Init, %function


		DistractTargetPosSelect_Init:
		push	{r4-r7,r14}
		mov		r6, r0
		
		@Text at the bottom
		ldr		r0, =DistractTargetBottomTextLink
		ldrh	r0, [r0,#2]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r0, r6
		ldr		r2, =StartBottomHelpText
		mov		lr, r2
		.short	0xF800
		
		ldr		r5, =gActionData
		ldrb	r0, [r5,#0x0D]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		mov		r7, r0
		
		mov		r0, r6
		mov		r1, #0x10
		ldsb	r1, [r7,r1]
		mov		r2, #0x11
		ldsb	r2, [r7,r2]
		ldr		r3, =EnsureCameraOntoPosition
		mov		lr, r3
		.short	0xF800
		
		ldr		r0, =HideMoveRangeGraphics
		mov		lr, r0
		.short	0xF800
		
		mov		r0, r7
		ldr		r2, =FillDistractTargetPosRangeMap
		mov		lr, r2
		.short	0xF800
		ldr		r2, =gGameState
		ldrb	r1, [r2,#4]
		mov		r0, #0xFD
		and		r0, r1
		strb	r0, [r2,#4]
		mov		r0, #1
		ldr		r1, =DisplayMoveRangeGraphics
		mov		lr, r1
		.short	0xF800
		
		mov		r0, #0x10
		ldsb	r0, [r7,r0]
		mov		r1, #0x11
		ldsb	r1, [r7,r1]
		ldr		r2, =SetCursorMapPosition
		mov		lr, r2
		.short	0xF800
		ldr		r0, =gAP_SelectCursorThing
		mov		r1, #0
		ldr		r2, =AP_Create
		mov		lr, r2
		.short	0xF800
		str		r0, [r6,#0x54]
		mov		r1, #0
		ldr		r2, =AP_SetAnimation
		mov		lr, r2
		.short	0xF800
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

