.thumb

.global AiToggleColor
.type AiToggleColor, %function


		AiToggleColor:
		push	{r14}
		ldr		r0, =AiToggleStatus
		mov		lr, r0
		.short	0xF800
		
		cmp		r0, #0
		beq		OffColor
			
			mov		r0, #3 @Orange
			b		End
			
		OffColor:
		mov		r0, #1 @gray
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

