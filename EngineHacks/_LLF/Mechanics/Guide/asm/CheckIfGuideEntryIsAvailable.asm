.thumb

.global CheckIfGuideEntryIsAvailable
.type CheckIfGuideEntryIsAvailable, %function


		CheckIfGuideEntryIsAvailable:
		push	{r14}
		ldr		r1, =NewGuideEntryAvailability
		mov		lr, r1
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

