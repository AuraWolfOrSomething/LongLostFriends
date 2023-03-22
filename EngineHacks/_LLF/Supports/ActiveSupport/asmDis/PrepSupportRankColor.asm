.thumb

.equ origin, 0
.include "../ActiveSupportDefs.s"

.global PrepSupportRankColor
.type PrepSupportRankColor, %function


		PrepSupportRankColor:
		push	{r4-r5,r14}
		mov		r4, r0
		add		r0, #0x46
		add		r0, r1
		ldrb	r0, [r0]
		cmp		r0, r2
		ble		SupportNotUnlocked
		
			ldr		r0, [r4,#0x2C]
			mov		r5, r0
		
			ldr		r3, =FindSupportPartnerCharId
			mov		lr, r3
			.short	0xF800
			mov		r1, #0x34
			mul		r0, r1
			ldr		r1, =CharacterTable
			add		r4, r0, r1
			
			mov		r0, r5
			ldr		r3, =GetUnitBySupportPartyId
			mov		lr, r3
			.short	0xF800
		
			ldrb	r1, [r4,#4] @partner character ID
			ldr		r3, =IsSupportActive
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		End
		
				ldrb	r0, =ActiveSupportColorLink
				ldrb	r0, [r0]
				b		End
		
		SupportNotUnlocked:
		mov		r0, #1
		
		End:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

