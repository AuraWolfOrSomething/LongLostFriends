.thumb

.equ origin, 0
.include "../ActiveSupportDefs.s"

.global PrepSupportPairedEnding
.type PrepSupportPairedEnding, %function


		PrepSupportPairedEnding:
		push	{r4-r7,r14}
		mov		r4, r0
		@mov		r5, r1
		mov		r6, r2
		
		@Testing if this text will update without further work from me; simply display name of active partner
		
		@get current unit
		ldr		r0, [r1,#0x2C]
		add		r0, #1
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		mov		r5, r0
		
		@see if any support values are 0xFE (paired ending)
		
		mov		r2, #0x32
		mov		r3, #0
		
		CheckForPairedEndingLoop:
		add		r1, r2, r3
		ldrb	r0, [r5,r1]
		cmp		r0, #0xFE
		bne		NextSupportTotalValue
		
			mov		r0, r5
			mov		r1, r3
			ldr		r3, =GetROMUnitSupportingId
			mov		lr, r3
			.short	0xF800 @support id -> char id
			ldr		r3, =GetCharacterData
			mov		lr, r3
			.short	0xF800 @char id -> char entry on CharacterTable
			ldrh	r0, [r0]
			b		GotATextId
		
			NextSupportTotalValue:
			add		r3, #1
			cmp		r3, #6 @RS has partner limit of 6
			blt		CheckForPairedEndingLoop

				ldr		r0, =NormalEndingTextLink
				ldrh	r0, [r0]
		
		GotATextId:
		ldr		r3, =String_GetFromIndex
		mov		lr, r3
		.short	0xF800
		ldr		r3, =Text_InsertString
		mov		lr, r3
		mov		r3, r0
		mov		r0, r6
		mov		r1, #0x30
		mov		r2, #0
		.short	0xF800
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

