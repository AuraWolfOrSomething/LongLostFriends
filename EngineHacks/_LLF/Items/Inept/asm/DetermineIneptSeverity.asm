.thumb

.global DetermineIneptSeverity
.type DetermineIneptSeverity, %function


		DetermineIneptSeverity:
		push	{r14}
		ldr		r1, =AreDebuffsHalved
		mov		lr, r1
		.short	0xF800
		
		@2 weapon ranks with halving; 3 otherwise
		mov		r1, #2 @debuff amount
		lsr		r1, r0
		add		r1, #1
		neg		r0, r1
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

