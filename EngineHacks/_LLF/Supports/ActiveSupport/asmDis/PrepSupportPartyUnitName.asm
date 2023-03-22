.thumb

.global PrepSupportPartyUnitName
.type PrepSupportPartyUnitName, %function


		PrepSupportPartyUnitName:
		push	{r14}
		cmp		r0, #0
		beq		GrayFont
		
		@check if in prep or in extra
		  @if extra, do further checks to r0
		  @if prep, check if unit has active
		ldr		r2, [sp,#4]
		add		r2, #0x42
		ldrb	r2, [r2]
		cmp		r2, #0
		beq		ExtraSupportAreAllSupportsUnlocked
		
			mov		r0, r1
			ldr		r3, =GetUnitBySupportPartyId
			mov		lr, r3
			.short	0xF800
			
			mov		r1, #0x38
			ldrb	r0, [r0,r1]
			cmp		r0, #0
			bne		GreenFont
		
				b		End
		
		GrayFont:
		mov		r0, #1
		b		End
		
		ExtraSupportAreAllSupportsUnlocked:
		cmp		r0, #2
		bne		WhiteFont
		
			GreenFont:
			mov		r0, #4
			b		End
		
		WhiteFont:
		mov		r0, #0
		
		End:
		pop		{r1}
		bx		r1

		.align
		.ltorg

