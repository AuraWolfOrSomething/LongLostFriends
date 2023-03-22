@ copies UnitHasItem (080179F8) for the most part, except this saves number of times the item has been found instead of immediately ending after the first time the item is found

.thumb

.equ GetItemIndex, 0x080174EC

.global CountCopiesOfItem
.type CountCopiesOfItem, %function


		CountCopiesOfItem:
		push	{r4-r7,r14}
		mov		r4, r0 @unit
		mov		r0, r1 @item we're looking for
		ldr		r3, =GetItemIndex
		mov		lr, r3
		.short	0xF800
		mov		r5, r0
		mov		r6, #0
		mov		r7, #0
		add		r4, #0x1E
		b		CheckIfNothing
		
		CheckIfItem:
		ldrh	r0, [r4]
		ldr		r3, =GetItemIndex
		mov		lr, r3
		.short	0xF800
		cmp		r0, r5
		bne		CheckNextItem
		add		r7, #1
		
		CheckNextItem:
		add		r4, #2
		add		r6, #1
		cmp		r6, #4
		bgt		ReturnCopyAmount
		
		CheckIfNothing:
		ldrh	r0, [r4]
		cmp		r0, #0
		bne		CheckIfItem
		
		ReturnCopyAmount:
		mov		r0, r7
		pop		{r4-r7}
		pop		{r1}
		bx		r1

