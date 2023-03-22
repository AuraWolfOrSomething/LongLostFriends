.thumb

.include "../EventSilentEditInventoryDefs.s"

.global EventSilentGiveItem
.type EventSilentGiveItem, %function


		EventSilentGiveItem:
		push	{r14}
		
		@Get unit
		ldr		r0, =gEventSlot1
		ldrb	r0, [r0]
		ldr		r1, =GetUnitByCharId
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			add		r0, #0x1E
			mov		r3, #0
			
			LoopThroughInventory:
			lsl		r2, r3, #1
			ldrh	r1, [r0,r2]
			cmp		r1, #0
			beq		PutItemInThisSlot
			
				add		r3, #1
				cmp		r3, #5
				blt		LoopThroughInventory
				
					@If unit has no empty slots, then they don't get the item
					b		End
			
			PutItemInThisSlot:
			ldr		r1, =gEventSlot2
			ldrh	r1, [r1]
			strh	r1, [r0,r2]
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

