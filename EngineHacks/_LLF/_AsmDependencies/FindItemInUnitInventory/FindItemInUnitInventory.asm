@ copies UnitHasItem (080179F8) for the most part, except once the item has been found, it returns where it was found

.thumb

.equ GetItemIndex, 0x080174EC

.global FindItemInUnitInventory
.type FindItemInUnitInventory, %function

@r0 = unit
@r1 = item we're looking for
@r2 = 0 if zero durability is included, 1 if zero durability is excluded



		FindItemInUnitInventory:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r0, r1
		mov		r7, r2
		ldr		r3, =GetItemIndex
		mov		lr, r3
		.short	0xF800
		mov		r5, r0
		mov		r6, #0
		add		r4, #0x1E
		b		CheckIfNothing
		
		CheckIfItem:
		ldr		r3, =GetItemIndex
		mov		lr, r3
		.short	0xF800
		cmp		r0, r5
		bne		CheckNextItem
		
			cmp		r7, #0
			beq		ReturnItemLocation
		
				ldrb	r0, [r4,#1]
				cmp		r0, #0
				beq		CheckNextItem
		
		ReturnItemLocation:
		mov		r0, r4
		b		End
		
		CheckNextItem:
		add		r4, #2
		add		r6, #1
		cmp		r6, #4
		bgt		ReturnNothing
		
				CheckIfNothing:
				ldrh	r0, [r4]
				cmp		r0, #0
				bne		CheckIfItem
				
		ReturnNothing:
		mov		r0, #0
		
		End:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

