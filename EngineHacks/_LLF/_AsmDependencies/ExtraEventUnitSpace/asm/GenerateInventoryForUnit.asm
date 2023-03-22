.thumb

.include "../EeusDefs.s"

.global GenerateInventoryForUnit
.type GenerateInventoryForUnit, %function


		GenerateInventoryForUnit:
		push	{r4-r7,r14}
		mov		r4, r0 @unit storing at enemy faction
		mov		r5, r1 @unit loading from events
		mov		r6, #0 @counter
		mov		r7, #0x0C @event unit inventory
		
		ItemLoop:
		add		r0, r5, r7
		mov		r1, r5
		ldr		r3, =EventUnitItemUses
		mov		lr, r3
		.short	0xF800
		
		mov		r1, r0
		mov		r0, r4
		ldr		r3, =UnitAddItem
		mov		lr, r3
		.short	0xF800
		add		r6, #1
		add		r7, #1
		cmp		r6, #4
		bge		End
		
		ldrb	r0, [r5,r7]
		cmp		r0, #0
		bne		ItemLoop
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0

