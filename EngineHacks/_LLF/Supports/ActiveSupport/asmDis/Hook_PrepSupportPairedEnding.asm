.thumb

.equ origin, 0x080A1EE0
.include "../ActiveSupportDefs.s"

.global Hook_PrepSupportPairedEnding
.type Hook_PrepSupportPairedEnding, %function


		Hook_PrepSupportPairedEnding:
		@Check if in prep or in extra
		mov		r0, #0x38
		ldrb	r0, [r5,r0]
		cmp		r0, #0
		beq		SupportExtra
		
			mov		r0, r4
			mov		r1, r5
			mov		r2, r6
			ldr		r3, =PrepSupportPairedEnding
			bl		bl_BXR3
			b		GoToSetFont
		
			SupportExtra:
			@Check how many supports this unit can still do
			  @If zero, use grey color font
			mov		r4, #0
			add		r5, #0x3D
			ldrb	r0, [r5]
			cmp		r0, #0
			bne		GetText_Remaining
		
				mov		r4, #1
		
			GetText_Remaining:
			mov		r7, #0
		
			RemainingPartnerTextLoop:
			ldr		r0, =SupportExtraTextIdLink
			ldrh	r0, [r0,r7]
			bl		bl_String_GetFromIndex
			mov		r3, r0
			mov		r0, r6
			mov		r1, #0x30
			lsl		r1, r7
			mov		r2, r4
			bl		bl_Text_InsertString
			add		r7, #1
			cmp		r7, #2
			blt		RemainingPartnerTextLoop
		
				@Display number of supports this unit hasn't unlocked yet
				ldrb	r0, [r5]
				bl		bl_080AEBEC
				mov		r1, r0
				lsl		r1, #3
				add		r1, #0x60
				mov		r0, r6
				cmp		r4, #0
				bne		GoToSetColorId @if white, change to blue
		
					mov		r4, #2
		
					GoToSetColorId:
					mov		r1, r4
					mov		r0, r6
					bl		bl_Text_SetColorId
					ldrb	r1, [r5]
					mov		r0, r6
					bl		bl_Text_DrawNumberOr2Dashes
		
		GoToSetFont:
		mov		r0, #0
		bl		bl_Text_SetFont
		add		sp, #0x20
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		
		@I would prefer to be as lazy as possible and not rewrite the part of the routine that comes before the hook
		.word 	someVRAMthing
		.word 	gPal_UIFont
		.word 	gCharacterData_1Indexed
		.ltorg

