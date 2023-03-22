.thumb

.include "../PriceModifyingItemsDefs.s"

.global SilverCardDiscount
.type SilverCardDiscount, %function


		SilverCardDiscount:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, r1
		ldr		r6, =NewSilverCardParameterLink
		
		@check if unit has a new silver card, then checks for used
		CheckForSilverCard:
		mov		r0, r5
		ldrb	r1, [r6]
		ldr		r3, =CheckIfUnitHasItem
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		bne		ApplySilverCard
		
			ldr		r0, =UsedSilverCardParameterLink
			cmp		r0, r6
			beq		End
			
				mov		r6, r0
				b		CheckForSilverCard
		
		ApplySilverCard:
		ldrb	r1, [r6,#1]
		add		r4, r1
		
		End:
		mov		r0, r4
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

