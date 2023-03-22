.thumb

.global GetItemWorth
.type GetItemWorth, %function


		GetItemWorth:
		push	{r4}
		mov		r1, #0xFF
		and		r1, r0
		lsl		r2, r1, #3
		add		r2, r1
		lsl		r2, #2
		ldr		r1, =ItemTable
		add		r2, r1
		ldrb	r1, [r2,#6]
		
		@Check if on ItemResetList
		ldr		r3, =ItemResetList
		
		ItemResetListLoop:
		ldrb	r4, [r3]
		cmp		r4, #0
		beq		RegularItem
		
			add		r3, #4
			cmp		r1, r4
			bne		ItemResetListLoop

				@If on ItemResetList, always use max uses for calculating the price (the current stat is stored in durability, so that will mess with the price if not accounted for)
				ldrb	r0, [r2,#0x14]
				b		MultiplyByPricePerUse
		
		RegularItem:
		ldr		r3, [r2,#8]
		mov		r1, #8
		and		r3, r1
		cmp		r3, #0
		beq		ItemHasDurability
		
			ldrh	r0, [r2,#0x1A]
			b		ReturnWorth
		
		ItemHasDurability:
		asr		r0, #8
		
		MultiplyByPricePerUse:
		ldrh	r1, [r2,#0x1A]
		mul		r0, r1
		
		ReturnWorth:
		pop		{r4}
		bx		r14
		
		.align
		.ltorg

