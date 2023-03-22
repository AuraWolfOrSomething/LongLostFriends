.thumb

.global CalculateSupportBonusRange
.type CalculateSupportBonusRange, %function


		CalculateSupportBonusRange:
		mov		r0, #3
		bx		r14
		
		@the following code makes the range supports unlocked / 3 + 3
		@push	{r4,r14}
		@mov		r4, r0
		@add		r4, #0x32
		@mov		r2, #0 @support ranks reached
		@mov		r3, #0 @loop variable
		
		@NewSupportPartner:
		@ldrb	r0, [r4,r3]
		@mov		r1, #1
		
		@CountRanksReached:
		@add		r1, #0x50
		@cmp		r0, r1
		@blt		CheckNextSupportPartner
		
			@add		r2, #1
			@b		CountRanksReached
		
			@CheckNextSupportPartner:
			@add		r3, #1
			@cmp		r3, #6 @RS caps support partners at 6 instead of 7
			@blt		NewSupportPartner

		@mov		r0, r2
		@mov		r1, #3
		@swi		#6 @divide value by 3
		@add		r0, #3 @base range
		@pop		{r4}
		@pop		{r1}
		@bx		r1
		
		.align
		.ltorg

