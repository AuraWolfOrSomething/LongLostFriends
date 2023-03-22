.thumb

.include "../PriceModifyingItemsDefs.s"

.global CouponDiscount
.type CouponDiscount, %function


		CouponDiscount:
		push	{r4-r5,r14}
		mov		r4, r0
		ldr		r5, =CouponInfoLink
		mov		r0, r1
		
		@if buying a coupon, don't apply coupon discount
		ldrb	r1, [r5]
		cmp		r1, r2
		beq		End
		
			@check if unit has a coupon
			ldr		r3, =CheckIfUnitHasItem
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		End
		
				ldrb	r1, [r5,#1]
				add		r4, r1
		
		End:
		mov		r0, r4
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

