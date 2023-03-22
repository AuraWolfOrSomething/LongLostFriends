.thumb

.global GetRequiredCaptiveAmount
.type GetRequiredCaptiveAmount, %function


		GetRequiredCaptiveAmount:
		push	{r14}
		ldr		r3, =GetChapterCaptiveListEntry
		mov		lr, r3
		.short	0xF800
		ldrb	r0, [r0,#2]
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

