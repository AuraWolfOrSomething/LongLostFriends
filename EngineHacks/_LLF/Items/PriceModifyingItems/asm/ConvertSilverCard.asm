
.thumb

.include "../PriceModifyingItemsDefs.s"

.global ConvertSilverCard
.type ConvertSilverCard, %function


		ConvertSilverCard:
		push	{r4-r7,r14}
		add		sp, #-0x0C
		@mov		r4, r0 @unit
		@mov		r5, r1 @item that was purchased
		
		str		r0, [sp] @unit
		str		r1, [sp,#4] @item that was purchased
		
		mov		r6, r2 @additional discounts to include/ignore when getting the total discount
		mov		r7, #0 @if new silver card was bought
		str		r7, [sp,#8] @used silver card discount if it should be used when determining total discount
		
		@check if a new silver card was just bought
		ldr		r4, =NewSilverCardParameterLink
		ldrb	r2, [r4]
		cmp		r1, r2
		bne		CountNewSilverCards
		
			mov		r7, #1
		
		@if there's 0 or if the 1 found was just bought, skip to end
		@otherwise, keep going
		
		CountNewSilverCards:
		ldrb	r1, [r4]
		ldr		r3, =CountCopiesOfItem
		mov		lr, r3
		.short	0xF800
		cmp		r0, r7
		ble		End
		
			mov		r7, #0 @if used silver card was bought
		
		@check if a used silver card was just bought
		ldr		r5, =UsedSilverCardParameterLink
		ldrb	r1, [r5]
		@cmp		r5, r1
		
		ldr		r2, [sp,#4]
		cmp		r2, r1
		
		bne		CountUsedSilverCards
		
			mov		r7, #1
		
		@check if there are no used silver cards in inventory
		  @if there's 0 or if the 1 found was just bought, do not add used silver card discount
		  @otherwise, add it
		
		CountUsedSilverCards:
		@mov		r0, r4
		
		ldr		r0, [sp]
		ldr		r3, =CountCopiesOfItem
		mov		lr, r3
		.short	0xF800
		cmp		r0, r7
		ble		CalculateDiscountDuringPurchase
		
			ldrb	r1, [r5,#1]
			str		r1, [sp,#8]
		
		@check if uncapped discount - new silver card + used silver card >= discount cap
		    @if so, skip to end
		
		CalculateDiscountDuringPurchase:
		@mov		r0, r4
		@mov		r1, r5
		
		ldr		r0, [sp]
		ldr		r1, [sp,#4]
		
		ldr		r3, =GetDiscountPercentage
		mov		lr, r3
		.short	0xF800
		ldr		r1, =PriceDiscountIncludeIgnoreLink
		ldsb	r1, [r1,r6]
		add		r0, r1
		ldrb	r1, [r4,#1]
		sub		r0, r1
		ldr		r1, [sp,#8]
		add		r0, r1
		ldr		r2, =PriceDiscountCapLink
		ldrb	r2, [r2]
		cmp		r0, r2
		bge		End
		
			@check if new silver card discount = used silver card discount
			  @if so, skip to end
			@ldrb	r2, [r5,#2]
			@cmp		r2, r1
			@beq		End
		
				@Find new silver card
				@mov		r0, r4
				
				ldr		r0, [sp]
				
				ldrb	r1, [r4]
				mov		r2, #0
				ldr		r3, =FindItemInUnitInventory
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				beq		End
				
					ldrb	r1, [r5]
					strh	r1, [r0]
		
		End:
		add		sp, #0x0C
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

