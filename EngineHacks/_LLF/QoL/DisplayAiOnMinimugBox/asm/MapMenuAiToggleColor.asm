.thumb

.global MapMenuAiToggleColor
.type MapMenuAiToggleColor, %function


		MapMenuAiToggleColor:
		push	{r4-r5,r14}
		mov		r5, r0
		mov		r4, r1
		ldr		r0, =AiToggleColor
		mov		lr, r0
		.short	0xF800
		
		ldr		r1, =ChangeMapMenuCommandColor
		mov		lr, r1
		mov		r1, r0
		mov		r0, r4
		add		r0, #0x34
		mov		r2, r4
		mov		r3, r5
		.short	0xF800
		
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

