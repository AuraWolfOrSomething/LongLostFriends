.thumb

.include "../EventSilentEditInventoryDefs.s"

.global EventEditUses
.type EventEditUses, %function


		EventEditUses:
		push	{r4,r14}
		
		@Get unit
		ldr		r0, =gEventSlot1
		ldrb	r0, [r0]
		ldr		r1, =GetUnitByCharId
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			ldr		r4, =gEventSlot2
			ldrh	r1, [r4]
			mov		r2, #1
			ldr		r3, =FindItemInUnitInventory
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		End
			
				ldrh	r1, [r4]
				strh	r1, [r0]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

