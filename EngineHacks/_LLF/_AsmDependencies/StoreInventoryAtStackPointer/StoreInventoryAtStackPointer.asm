
@add sp, #-0x08 before calling this

@r3 = item slot that's being checked
@r4 = unit
@r5 = list of accepted items that unit has so far
@r6 = list of which items should be stored; 0 if all items
@r7 = number of accepted items that unit has so far

.thumb

.global StoreInventoryAtStackPointer
.type StoreInventoryAtStackPointer, %function


		StoreInventoryAtStackPointer:
		push	{r4-r7}
		mov		r4, r0
		mov		r5, r1
		mov		r6, r2
		mov		r0, #0
		str		r0, [r5]
		str		r0, [r5,#4]

		@get next item id
		@see if item id is on the list or not
		  @if on list, store it
		@check if any more items in inventory
		
		mov		r3, #0
		mov		r7, #0
		add		r4, #0x1E
		
		NextItemID:
		lsl		r1, r3, #1
		ldrb	r0, [r4,r1]
		cmp		r0, #0 @if nothin in item slot, then unit's inventory has been fully checked
		beq		EndOfStoring
		cmp		r6, #0 @if no list given, then no exceptions; all items will be stored
		beq		StoreItemID
		
			mov		r2, r6
		
			CheckIfOnList:
			ldrb	r1, [r2]
			cmp		r0, r1
			beq		StoreItemID
			
				cmp		r1, #0
				beq		CheckNextItem
				
					add		r2, #1
					b		CheckIfOnList
		
		StoreItemID:
		strb	r0, [r5,r7]
		add		r7, #1
		
		CheckNextItem:
		add		r3, #1
		cmp		r3, #5
		blt		NextItemID
		
		EndOfStoring:
		pop		{r4-r7}
		bx		r14
		
		.align
		.ltorg

