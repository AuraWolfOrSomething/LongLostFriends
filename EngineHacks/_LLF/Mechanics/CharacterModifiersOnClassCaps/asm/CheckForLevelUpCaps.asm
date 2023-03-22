.thumb

.global CheckForLevelUpCaps
.type CheckForLevelUpCaps, %function


		CheckForLevelUpCaps:
		push	{r4-r7,r14}
		mov		r3, r0 @unit
		ldr		r4, [r3,#4] @unit's class
		mov		r5, r1
		add		r5, #0x73 @unit's level up
		mov 	r6, #0
		ldr		r7, =CharacterCapModifierTable
		
		@Find character's entry on table
		ldr		r0, [r0]
		ldrb	r0, [r0,#4]
		ldrb	r1, [r7]
		cmp		r0, r1
		blt		DefaultEntry
		
			ldrb	r1, [r7,#1]
			cmp		r0, r1
			ble		GetEntry
		
		DefaultEntry:
		ldrb	r0, [r7,#2] @If character id isn't in range, just use entry for this id
		
		GetEntry:
		lsl		r1, r0, #2
		add		r0, r1 @entries are 5 bytes long
		add		r7, r0
		
		@A: get unit stat's current value + amount from level up
		@B: get class cap + character mod
		@check if A > B
		  @if so, lower amount from level up so that A = B
		
		@For first cycle only (HP)
		mov		r2, #0x12
		ldsb	r0, [r3,r2]
		mov		r1, #0
		ldsb	r1, [r5,r1]
		add		r0, r1
		ldrb	r1, [r4,#0x13]
		b		ComparePotentialValueToCap
		
		NewCycle:
		mov		r2, #0x13
		add		r2, r6
		ldsb	r0, [r3,r2]
		mov		r1, #0
		ldsb	r1, [r5,r1]
		add		r0, r1
		ldrb	r1, [r4,r2] @coincidentally, the same value can be used for getting both the unit's current amount in stat and the class stat cap (other than HP)
		mov		r2, r6
		sub		r2, #1 @no HP mod; table starts with Pow
		ldsb	r2, [r7,r2]
		add		r1, r2
		
		ComparePotentialValueToCap:
		cmp		r0, r1
		ble		CheckNextStat
		
			ldrb	r0, [r3,r2]
			sub		r1, r0
			strb	r1, [r5]
		
			CheckNextStat:
			add		r5, #1
			add		r6, #1
			cmp		r6, #6
			blt		NewCycle
		
		@Lck
		mov		r2, #0x19
		ldsb	r0, [r3,r2]
		mov		r1, #0
		ldsb	r1, [r5,r1]
		add		r0, r1
		ldr		r1, =UniversalCapValuesLink
		ldrb	r1, [r1,#1]
		cmp		r0, r1
		ble		End

			ldrb	r0, [r3,r2]
			sub		r1, r0
			strb	r1, [r5]
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

