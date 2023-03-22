.thumb

.equ GetItemData, 0x080177B0

.global ThoronEffect
.type ThoronEffect, %function


		ThoronEffect:
		push	{r4,r14}
		mov		r4, r0
		mov		r0, #0x4A
		ldrb	r0, [r4,r0]
		ldr		r2, =ThoronLink
		ldrb	r2, [r2]
		cmp		r0, r2
		bne		End
		
			@Check if opponent is using a bow
			mov		r0, #0x4A
			ldrb	r0, [r1,r0]
			ldr		r2, =GetItemData
			mov		lr, r2
			.short	0xF800
			ldrb	r0, [r0,#7]
			cmp		r0, #3
			bne		End
			
				@-9 damage taken
				mov		r1, #0x5C
				ldrb	r0, [r4,r1]
				add		r0, #9
				strb	r0, [r4,r1]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

