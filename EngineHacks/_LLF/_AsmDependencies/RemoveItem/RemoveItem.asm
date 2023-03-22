@r0 = character
@r1 = item

.thumb

.global RemoveItem
.type RemoveItem, %function


		RemoveItem:
		add		r0, #0x1E
		mov		r3, #0x00 @how many items have been checked
		
		LoopThroughItems_1:
		ldrb	r2, [r0]
		cmp		r2, r1
		beq		ItemFound
		
		CheckIfEntireInventoryChecked_1:
		add		r3, #0x01
		cmp		r3, #0x05
		beq		End
		add		r0, #0x02
		b		LoopThroughItems_1
		
		ItemFound:
		mov		r2, #0x00
		strh	r2, [r0]
		
		CheckIfEntireInventoryChecked_2:
		add		r3, #0x01
		cmp		r3, #0x05
		beq		End
		add		r0, #0x02
		@b		LoopThroughItems_2
		
		LoopThroughItems_2:
		ldrh	r2, [r0]
		
		MoveItemUp:
		mov		r1, r0
		sub		r1, #0x02
		strh	r2, [r1]
		b		CheckIfEntireInventoryChecked_2
		
		End:
		@empties inventory slot 5 in case unit had 5 items before this routine
		mov		r2, #0x00
		strh	r2, [r0]
		bx		r14
			
		.align
		
		ActiveUnit:
		.long	0x03004E50
		
		MemorySlot4:
		.long	0x030004C8

