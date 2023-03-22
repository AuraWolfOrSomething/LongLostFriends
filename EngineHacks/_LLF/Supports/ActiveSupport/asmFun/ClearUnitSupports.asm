.thumb

.equ origin, 0x080283E0
.include "../ActiveSupportDefs.s"

.global ClearUnitSupports
.type ClearUnitSupports, %function


		ClearUnitSupports:
		push	{r4-r7,r14}
		mov		r5, r0
		bl		bl_GetROMUnitSupportCount
		cmp		r0, #0
		ble		End
		
			mov		r7, r0 @number of partners
			mov		r6, #0 @loop variable
		
			FindPartner:
			mov		r0, r5
			mov		r1, r6
			bl		bl_GetUnitSupportingUnit
			mov		r4, r0 @partner
			cmp		r4, #0
			beq		NextPartner
			
				ldr		r0, [r5]
				ldrb	r1, [r0,#4]
				mov		r0, r4
				bl		bl_GetSupportDataIdForOtherUnit
				add		r0, #0x32
				mov		r2, #0
				strb	r2, [r4,r0]
				mov		r3, #0x32
				add		r3, r6
				strb	r2, [r5,r3]
			
				@check if this partner is dead unit's active support
				  @if so, clear it
				mov		r3, #0x38
				ldrb	r0, [r5,r3]
				ldr		r1, [r4]
				ldrb	r1, [r1,#4]
				cmp		r0, r1
				bne		NextPartner
			
					strb	r2, [r4,r3]
					strb	r2, [r5,r3]
			
				NextPartner:
				add		r6, #1
				cmp		r6, r7
				blt		FindPartner
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

