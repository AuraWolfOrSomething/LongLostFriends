.thumb

.global IsDistractDebuffActive
.type IsDistractDebuffActive, %function


		IsDistractDebuffActive:
		push	{r14}
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r0, [r0,#2]
		mov		r1, #2
		and		r0, r1
		cmp		r0, #0
		beq		End
		
			mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

