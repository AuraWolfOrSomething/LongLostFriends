.thumb

.include "../ShoppingEditsDefs.s"

.global AfterPurchase
.type AfterPurchase, %function


		AfterPurchase:
		push	{r4-r7,r14}
		mov		r5, r0
		mov		r0, #0xB9
		mov		r1, #8
		ldr		r3, =blr_08014B88
		mov		lr, r3
		.short	0xF800
		ldr		r1, =gActionData
		mov		r0, #0x17
		strb	r0, [r1,#0x11]
		ldr		r3, =GetPartyGoldAmount
		mov		lr, r3
		.short	0xF800
		mov		r4, r0
		ldr		r0, [r5,#0x2C] @unit
		mov		r1, r5
		add		r1, #0x5C
		ldrb	r2, [r1]
		lsl		r2, #1
		sub		r1, #0x2C
		add		r1, r2
		ldrh	r1, [r1]
		lsl		r6, r1, #24 @to check if a coupon was just bought
		lsr		r6, #24
		ldr		r3, =PriceModifiersMainLoop
		mov		lr, r3
		.short	0xF800
		lsl		r0, #0x10
		lsr		r0, #0x10
		sub		r4, r0
		mov		r0, r4
		ldr		r3, =SetPartyGoldAmount
		mov		lr, r3
		.short	0xF800
		
		@set bargain items as being purchased
		ldr		r0, [r5,#0x2C]
		mov		r1, r6
		ldr		r3, =SetPurchasedBargainItem
		mov		lr, r3
		.short	0xF800
		
		@r7 can be used to determine the total discount before removing/converting items as each routine that removes/converts items is called
		mov		r7, #0
		
		@remove coupon if non-coupon bought and coupon affected final price
		ldr		r0, [r5,#0x2C]
		mov		r1, r6
		ldr		r3, =RemoveCoupon
		mov		lr, r3
		.short	0xF800
		orr		r7, r0
		
		@replace any new silver cards with used silver cards (with certain exceptions)
		ldr		r0, [r5,#0x2C]
		mov		r1, r6
		mov		r2, r7
		ldr		r3, =ConvertSilverCard
		mov		lr, r3
		.short	0xF800
		
		@back to other vanilla stuff
		mov		r0, r5
		ldr		r3, =blr_080B42B4
		mov		lr, r3
		.short	0xF800
		mov		r0, r5
		ldr		r3, =blr_080B4F90
		mov		lr, r3
		.short	0xF800
		ldr		r0, =gMaybeABuffer
		ldr		r3, =blr_080B4ED4
		mov		lr, r3
		.short	0xF800
		
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

