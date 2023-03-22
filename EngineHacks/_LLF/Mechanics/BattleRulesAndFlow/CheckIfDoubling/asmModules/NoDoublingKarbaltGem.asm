.thumb

.global NoDoublingKarbaltGem
.type NoDoublingKarbaltGem, %function


		NoDoublingKarbaltGem:
		push	{r14}
		ldr		r1, =KarbaltGemLink
		ldrb	r1, [r1]
		ldr		r3, =CheckIfGemIsActive
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

