.thumb

.global NoDoublingCapture
.type NoDoublingCapture, %function


		NoDoublingCapture:
		push	{r14}
		ldr		r1, =Is_Capture_Set
		mov		lr, r1
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

