.thumb

.global CheckIfEnoughCaptives
.type CheckIfEnoughCaptives, %function


		CheckIfEnoughCaptives:
		push	{r4,r14}
		ldr		r3, =GetRequiredCaptiveAmount
		mov		lr, r3
		.short	0xF800
		mov		r4, r0
		ldr		r3, =GetCurrentCaptiveAmount
		mov		lr, r3
		.short	0xF800
		cmp		r0, r4
		blt		NotEnough
		
			mov		r0, #1
			b		End
		
		NotEnough:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

