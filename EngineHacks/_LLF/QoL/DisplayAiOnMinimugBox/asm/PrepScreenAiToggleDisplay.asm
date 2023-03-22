.thumb

.include "../DisplayAiOnMinimugBoxDefs.s"

.global PrepScreenAiToggleDisplay
.type PrepScreenAiToggleDisplay, %function

		PrepScreenAiToggleDisplay:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =PrepScreenAiToggleDisplayIDLink
		ldrb	r1, [r1]
		str		r1, [r0,#0x58]
		
		@Change on -> off or off -> on
		ldr		r0, =ToggleAiDisplay
		mov		lr, r0
		.short	0xF800
		
		@Redraw list
		mov		r0, r4
		ldr		r1, =SetUpPrepScreenMapMenu
		mov		lr, r1
		.short	0xF800
		mov		r0, r4
		mov		r1, #0x3D
		ldr		r2, =ProcGoto
		mov		lr, r2
		.short	0xF800
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg
		

