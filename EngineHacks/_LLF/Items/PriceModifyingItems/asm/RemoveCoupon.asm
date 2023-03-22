@note: this routine isn't currently written to use PriceDiscountIncludeIgnoreLink, as it's currently called as the first remove/convert price item routine
@if you want to give another item "priority"/call another item first, this should be rewritten to use PriceDiscountIncludeIgnoreLink (look at ConvertSilverCard)

.thumb

.include "../PriceModifyingItemsDefs.s"

.global RemoveCoupon
.type RemoveCoupon, %function


		RemoveCoupon:
		push	{r4-r6,r14}
		mov		r4, r0 @unit
		mov		r5, r1 @item that was purchased
		ldr		r6, =CouponInfoLink
		
		@check if coupon was just bought; if so, don't remove coupon
		ldrb	r2, [r6]
		cmp		r1, r2
		beq		End
		
			@check if there is even a coupon in the unit's inventory
			mov		r1, r2
			ldr		r3, =CheckIfUnitHasItem
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		End
		
				@check uncapped discount percent
				  @if uncapped discount - coupon discount >= discount cap, don't remove coupon
				mov		r0, r4
				mov		r1, r5
				ldr		r3, =GetDiscountPercentage
				mov		lr, r3
				.short	0xF800
				ldrb	r1, [r6,#1]
				sub		r0, r1
				ldr		r1, =PriceDiscountCapLink
				ldrb	r1, [r1]
				cmp		r0, r1
				bge		IgnoreCoupon
		
					@actually remove coupon
					mov		r0, r4
					ldrb	r1, [r6]
					ldr		r3, =RemoveItem
					mov		lr, r3
					.short	0xF800
					mov		r0, #1
					b		End
		
		IgnoreCoupon:
		mov		r0, #2
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

