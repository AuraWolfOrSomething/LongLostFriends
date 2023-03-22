.thumb

.global NewPopulateUnitInventory
.type NewPopulateUnitInventory, %function


		NewPopulateUnitInventory:
		push	{r14}
		ldrb	r2, [r1,#0x0C]
		cmp		r2, #0
		beq		ReturnToLoop
		
			ldr		r2, =GenerateInventoryForUnit
			mov		lr, r2
			.short	0xF800
		
		ReturnToLoop:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

