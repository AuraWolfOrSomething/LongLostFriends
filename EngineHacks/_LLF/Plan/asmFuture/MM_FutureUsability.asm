.thumb

.include "../PlanDefs.s"

.global MM_FutureUsability
.type MM_FutureUsability, %function


		MM_FutureUsability:
		push	{r4-r6,r14}
		mov		r6, r0
		mov		r4, r1
		mov		r5, r4
		add		r5, #0x34
		
		ldr		r0, =FutureCheckForRemainingTurnEvents
		mov		lr, r0
		.short	0xF800
		mov		r1, #4 @text color (green)
		cmp		r0, #0
		bne		ChangeTextColor
		
			mov		r1, #1 @gray
			
			@If Chapter 3 Part 1, use white text color
			ldr		r3, =gChapterData
			mov		r2, #0x0E
			ldsb	r2, [r3,r2]
			cmp		r2, #3
			bne		ChangeTextColor
			
				mov		r1, #0 
			
		ChangeTextColor:
		mov		r0, r5
		ldr		r2, =Text_SetColorId
		mov		lr, r2
		.short	0xF800
		
		DrawFutureText:
		@copying what the Guide does
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
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		
		.align
		.ltorg

