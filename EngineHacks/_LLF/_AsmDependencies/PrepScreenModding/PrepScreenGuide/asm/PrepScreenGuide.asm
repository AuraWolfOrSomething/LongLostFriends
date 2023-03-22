.thumb

.global PrepScreenGuide
.type PrepScreenGuide, %function

.equ ProcGoto, 0x08002F24


		PrepScreenGuide:
		push	{r14}
		ldr		r1, =PrepScreenGuideIDLink
		ldrb	r1, [r1]
		str		r1, [r0,#0x58]
		ldr		r1, =PrepScreenGuideProcLabelLink
		ldrb	r1, [r1]
		ldr		r3, =ProcGoto
		mov		lr, r3
		.short	0xF800
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

