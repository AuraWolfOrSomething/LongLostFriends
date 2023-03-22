.thumb

.global prGemLck
.type prGemLck, %function


		prGemLck:
		push	{r4,r14}
		mov		r4, r0	@stat
		
		mov		r0, r1 @unit
		mov		r1, #0x00 @value is different for each stat
		ldr		r3, =GetGemStatBoosts
		mov		lr, r3
		.short	0xF800
		add		r4, r0
		
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1

