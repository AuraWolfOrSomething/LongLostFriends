.thumb

.equ origin, 0x080285B0
.include "../SupportBonusesDefs.s"

.global GetUnitSupportBonuses
.type GetUnitSupportBonuses, %function


		GetUnitSupportBonuses:
		push	{r4-r7,r14}
		mov		r6, r10
		mov		r5, r9
		mov		r4, r8
		push	{r4-r6}
		add		sp, #-0x04
		mov		r7, r0
		mov		r6, r1
		mov		r0, #0
		mov		r9, r0
		mov		r0, r6
		bl		bl_InitSupportBonuses
		mov		r0, r7
		bl		bl_GetROMUnitSupportCount
		mov		r10, r0
		mov		r1, #0
		mov		r8, r1
		cmp		r9, r10
		bge		StoreTrueSupportBonuses
		
			sub		r0, #1
			str		r0, [sp]
		
		Label_0x080285DE: @080285DE
		mov		r1, r9
		asr		r1, #1
		mov		r9, r1
		mov		r0, r7
		mov		r1, r8
		bl		bl_GetUnitSupportingUnit
		mov		r5, r0
		cmp		r5, #0
		beq		Label_0x08028674
	
			ldr		r0, =gGameState
			ldrb	r1, [r0,#4]
			mov		r0, #0x40
			tst		r0, r1
			bne		Label_0x08028624
	
				mov		r0, r7
				mov		r1, r5
				ldr		r3, =CheckIfReceivingSupportBonuses
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				beq		Label_0x08028674
	
				Label_0x08028624: @08028624
				ldr		r0, [r5,#0x0C]
				ldr		r1, =Word1
				tst		r0, r1
				bne		Label_0x08028674
		
					ldr		r0, [r7]
					ldrb	r1, [r0,#4]
					mov		r0, r5
					bl		bl_GetSupportDataIdForOtherUnit
					mov		r1, r0
					mov		r0, r5
					bl		bl_GetSupportLevelBySupportIndex
					mov		r4, r0
					
					ldr		r0, [r5]
					ldrb	r1, [r0,#9]
					mov		r0, r6
					mov		r2, r4
					bl		bl_StoreAddedAffinityBonusesForSupportLevel
					
					mov		r0, r7
					mov		r1, r8
					bl		bl_GetSupportLevelBySupportIndex
					mov		r5, r0
					
					ldr		r0, [r7]
					ldrb	r1, [r0,#9]
					mov		r0, r6
					mov		r2, r5
					bl		bl_StoreAddedAffinityBonusesForSupportLevel
					cmp		r4, #0
					beq		Label_0x08028674
		
						cmp		r5, #0
						beq		Label_0x08028674
		
							mov		r0, #1
							ldr		r1, [sp]
							lsl		r0, r1
							add		r9, r0
		
							Label_0x08028674: @08028674
							mov		r0, #1
							add		r8, r0
							cmp		r8, r10
							blt		Label_0x080285DE

		StoreTrueSupportBonuses: @0802867C
		mov		r2, #1 @loop variable
		
		StoreTrueSupportBonusesLoop:
		lsl		r3, r2, #1
		ldrh	r0, [r6,r3]
		mov		r1, #10
		swi		#6 @divide value by 10
		strb	r0, [r6,r2]
		add		r2, #1
		cmp		r2, #7
		blt		StoreTrueSupportBonusesLoop
		
		mov		r0, r9
		add		sp, #0x04
		pop		{r4-r6}
		mov		r8, r4
		mov		r9, r5
		mov		r10, r6
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

