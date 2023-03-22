.thumb

.equ origin, 0
.include "../ActiveSupportDefs.s"

.global SupportListSetNewActive
.type SupportListSetNewActive, %function

@r4 = proc stuff or something [non-wizarding hours B) ] -> loop variable
@r5 = unit
@r6 = unit's new active
@r7 = #0x38

@sp: if unit and partner don't have each other as active partners (bit 3)


		SupportListSetNewActive:
		push	{r4-r7,r14}
		add		sp, #-0x0C
		mov		r4, r0
		str		r4, [sp,#4]
		
		@get current unit
		ldr		r0, [r0,#0x2C]
		ldr		r3, =GetUnitBySupportPartyId
		mov		lr, r3
		.short	0xF800
		mov		r5, r0
		
		@get new partner
		mov		r0, #0x39
		ldrb 	r1, [r4,r0] @where cursor is (partner support id *4)
		mov		r0, #0x1F
		and		r1, r0
		lsr 	r1, #2 @partner support id (where are they on unit's support list)
		str		r1, [sp,#8]
		ldr		r0, [r4,#0x2C] @unit char id (where is this unit loaded in the party; starts at 0 in this instance)
		ldr		r3, =FindSupportPartnerCharId
		mov		lr, r3
		.short	0xF800
		ldr		r3, =GetUnitByCharId
		mov		lr, r3
		.short	0xF800
		mov		r6, r0
		
		mov		r4, #0
		str		r4, [sp]
		mov		r7, #0x38
		ldrb	r0, [r5,r7]
		ldr		r1, [r6]
		
		@check current active
		CheckActiveLoop:
		ldrb	r1, [r1,#4]
		cmp		r0, r1 @if new partner is old partner, skip
		beq		CheckIfRepeating_CheckActiveLoop
		
			str		r7, [sp]
			cmp		r0, #0
			beq		CheckIfRepeating_CheckActiveLoop
			
			ldr		r3, =GetUnitByCharId
			mov		lr, r3
			.short	0xF800
			mov		r1, #0
			strb	r1, [r0,r7] @old active partner no longer has this unit as active support
		
				CheckIfRepeating_CheckActiveLoop:
				ldrb	r0, [r6,r7]
				ldr		r1, [r5]
				add		r4, #1
				cmp		r4, #1
				beq		CheckActiveLoop
		
		@Check if these two already had each other as active
		  @If not, skip (pressed A to set as active)
		  @If so, continue (pressed A to set paired ending)
		ldr		r0, [sp]
		cmp		r0, #0
		bne		SetNewActives

			@check if A support
			  @if A, set as paired ending (unless already set)
			mov		r0, #0x32
			ldr		r1, [sp,#8]
			add		r0, r1
			ldrb	r0, [r5,r0]
			cmp		r0, #0xF1
			blt		SetNewActives
			
				cmp		r0, #0xFE
				beq		SetNewActives
	
					@erase any set paired endings on both units before setting paired ending for them
				
					mov		r7, r5
					mov		r4, #0
					mov		r2, #0x32
	
		ErasePrevEndingLoop:
		lsr		r1, r4, #1
		add		r3, r2, r1
		ldrb	r0, [r7,r3]
		cmp		r0, #0xF1
		ble		NextSupportTotalValue
			
			mov		r0, #0xF1
			strb	r0, [r7,r3]
			mov		r0, r7
			ldr		r3, =GetROMUnitSupportingId
			mov		lr, r3
			.short	0xF800
			ldr		r3, =GetUnitByCharId
			mov		lr, r3
			.short	0xF800
			
			@loop for partner that unit was previously paired with before continuing original loop
			mov		r3, #0
		
			ErasePrevEndingLoop_WithinLoop:
			mov		r2, #0x32
			add		r2, r3
			ldrb	r1, [r0,r2]
			cmp		r1, #0xF1
			ble		NextSupportTotalValue_WithinLoop
				
				mov		r1, #0xF1
				strb	r1, [r0,r2]
				
				NextSupportTotalValue_WithinLoop:
				add		r3, #1
				cmp		r3, #6 @RS has partner limit of 6
				blt		ErasePrevEndingLoop_WithinLoop
			
					mov		r2, #0x32
		
			NextSupportTotalValue:
			add		r4, #2
			cmp		r4, #0xC @RS has partner limit of 6 (6*2 = 0xC)
			blt		ErasePrevEndingLoop
		
				@Check if we need to do this loop for other unit still
				CheckIfRepeating_ErasePrevEndingLoop:
				cmp		r4, #0xD
				bge		SetPairedEnding
		
					mov		r7, r6
					mov		r4, #1
					b		ErasePrevEndingLoop
			
		SetPairedEnding:
		
		@Set paired ending on unit
		mov		r7, #0xFE
		ldr		r1, [sp,#8]
		mov		r4, #0x32
		add		r0, r4, r1
		strb	r7, [r5,r0]
		
		@Set paired ending on partner
		mov		r0, r6
		ldr		r1, [r5]
		ldr		r1, [r1,#4]
		ldr		r3, =GetSupportDataIdForOtherUnit
		mov		lr, r3
		.short	0xF800
		add		r0, r4
		strb	r7, [r6,r0]
		
		SetNewActives:
		mov		r1, #0x38
		
		@set new partner on this unit's active support
		ldr		r0, [r5]
		ldrb	r0, [r0,#4]
		strb	r0, [r6,r1]
		
		@set this unit on new partner's active support
		ldr		r0, [r6]
		ldrb	r0, [r0,#4]
		strb	r0, [r5,r1]
		
		@update screen (took from 080A2274)
		@mov		r4, r13
		ldr		r3, =Text_InitFont
		mov		lr, r3
		.short	0xF800
		ldr		r0, [sp,#4]
		ldr		r3, =Routine_080A20FC
		mov		lr, r3
		.short	0xF800
		ldr		r0, [sp,#4]
		ldr		r3, =Routine_080A1E7C
		mov		lr, r3
		.short	0xF800
		
		End:
		add		sp, #0x0C
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

