.thumb

.global NewPromoBonusRoutine
.type NewPromoBonusRoutine, %function

.equ origin, 0x0802BD50
.include "../PromotionDefs.s"

@r4 = new class
@r5 = unit

		NewPromoBonusRoutine:
		push	{r4-r7,r14}
		add		sp, #-0x04
		mov		r5, r0
		
		@Get new class data
		lsl		r0, r1, #0x18
		lsr		r0, #0x18
		bl		bl_GetClassData
		mov		r4, r0
		
		@Find character's entry on cap mod table
		ldr		r6, =CharacterCapModifierTable
		ldr		r0, [r5]
		ldrb	r0, [r0,#4]
		ldrb	r1, [r6]
		cmp		r0, r1
		blt		DefaultEntry
		
			ldrb	r1, [r6,#1]
			cmp		r0, r1
			ble		GetEntry
			
				DefaultEntry:
				ldrb	r0, [r6,#2] @If character id isn't in range, just use entry for this id
		
		GetEntry:
		lsl		r1, r0, #2
		add		r0, r1 @entries are 5 bytes long
		add		r6, r0
		
		@Setting up for stat loop
		mov		r0, r4
		add		r0, #0x22
		str		r0, [r13]
		mov		r3, #0 @loop variable

		@For first cycle only (HP)
		mov		r2, #0x12
		ldrb	r7, [r4,#0x13] @class cap
		b		CombineStatAndBonus
		
		CombineStatAndBonusLoop:
		mov		r2, #0x13
		add		r2, r3
		ldrb	r7, [r4,r2] @class cap
		mov		r0, r3
		sub		r0, #1 @no HP mod; table starts with Pow
		ldsb	r0, [r6,r0]
		add		r7, r0
		
		CombineStatAndBonus:
		ldrb	r0, [r5,r2]
		ldr		r1, [r13]
		ldrb	r1, [r1,r3]
		add		r0, r1
		
		@make sure stat+bonus doesn't exceed cap
		cmp		r0, r7
		ble		StoreNewStat
		
			mov		r0, r7
		
			StoreNewStat:
			strb	r0, [r5,r2]
		
			@check if we're done with stats and are on weapon ranks now
			add		r3, #1
			cmp		r3, #6
			blt		CombineStatAndBonusLoop

		@new loop (weapon ranks)
		mov		r3, #0
		mov		r2, r4
		add		r2, #0x2C @new class's base WEXP
		ldr		r6, [r5,#4]
		add		r6, #0x2C @current class's base WEXP
		mov		r7, r5
		add		r7, #0x28 @unit's weapon ranks
		
		WeaponRankLoop:
		@character WEXP - current class base WEXP
		ldrb	r0, [r7,r3]
		ldrb	r1, [r6,r3]
		sub		r0, r1
		cmp		r0, #0
		bge		AddNewWEXP
		
			mov		r0, #0
		
			AddNewWEXP:
			@difference + new class base WEXP
			ldrb	r1, [r2,r3]
			cmp		r1, #1 @if new promo has base rank E, give some WEXP
			bne		CapWEXP
			
				mov		r1, #16
			
			CapWEXP:
			add		r0, r1
			cmp		r0, #0xFB @Set to S rank if new value is greater than that
			ble		StoreWEXP
			
				mov		r0, #0xFB
			
			StoreWEXP:
			strb	r0, [r7,r3]
			add		r3, #1
			cmp		r3, #7
			ble		WeaponRankLoop
		
		@Store new level and new exp
		@mov		r0, #1
		@strb	r0, [r5,#8]
		@mov		r0, #0 @new exp
		@strb	r0, [r5,#9]
		
		@Fully heal unit
		ldrb	r0, [r5,#0x12]
		strb	r0, [r5,#0x13]
		
		@Get old class's id and new class's id (not currently needed, but is useful for things like removing anima WEXP for Pupil -> Shaman)
		@ldr		r0, [r5,#4]
		@ldrb	r0, [r0,#4]
		@ldrb	r1, [r4,#4]
		
		@Store new class pointer
		str		r4, [r5,#4]

		@End:
		add		sp, #0x04
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

