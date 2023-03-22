.thumb

.equ Text_SetColorId, 0x08003E60
.equ String_GetFromIndex, 0x800A240
.equ Text_DrawString, 0x08004004
.equ GetBgMapBuffer, 0x08001C4C
.equ Text_Display, 0x08003E70

.global ChangeMapMenuCommandColor
.type ChangeMapMenuCommandColor, %function


		ChangeMapMenuCommandColor:
		push	{r4-r6,r14}
		mov		r4, r2
		mov		r5, r0
		mov		r6, r3
		
		@copying what the Guide does
		ldr		r2, =Text_SetColorId
		mov		lr, r2
		.short	0xF800
		ldr		r0, [r4,#0x30]
		ldrh	r0, [r0,#4]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r0, r5
		ldr		r2, =Text_DrawString
		mov		lr, r2
		.short	0xF800
		mov		r0, r6
		add		r0, #0x64
		ldrb	r0, [r0]
		lsl		r0, #0x1C
		lsr		r0, #0x1E
		ldr		r1, =GetBgMapBuffer
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r2, #0x2C
		ldsh	r0, [r4,r2]
		lsl		r0, #5
		mov		r3, #0x2A
		ldsh	r2, [r4,r3]
		add		r0, r2
		lsl		r0, #1
		add		r1, r0
		mov		r0, r5
		ldr		r3, =Text_Display
		mov		lr, r3
		.short	0xF800
		
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

