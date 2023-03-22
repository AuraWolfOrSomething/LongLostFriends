.thumb

.global EnsureNoUnitStatCapOverflow
.type EnsureNoUnitStatCapOverflow, %function


		EnsureNoUnitStatCapOverflow:
		push	{r4-r7,r14}
		mov		r4, r0 @unit
		ldr		r5, [r4,#4] @unit's class
		mov		r6, #0
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
		
		@get unit stat and compare to final cap
		  @if higher than cap, set stat to cap
		
		@For first cycle only (HP)
		mov		r2, #0x12
		ldsb	r0, [r4,r2]
		ldrb	r1, [r5,#0x13]
		b		ComparePotentialValueToCap
		
		NewCycle:
		mov		r2, #0x13
		add		r2, r6
		ldsb	r0, [r4,r2]
		ldrb	r1, [r5,r2] @coincidentally, the same value can be used for getting both the unit's current amount in stat and the class stat cap (other than HP)
		mov		r3, r6
		sub		r3, #1 @no HP mod; table starts with Pow
		ldsb	r3, [r7,r3]
		add		r1, r3
		
		ComparePotentialValueToCap:
		cmp		r0, r1
		ble		CheckNextStat
		
			strb	r1, [r4,r2]
		
			CheckNextStat:
			add		r6, #1
			cmp		r6, #6
			blt		NewCycle
		
				@Lck
				mov		r2, #0x19
				ldsb	r0, [r4,r2]
				ldr		r1, =UniversalCapValuesLink
				ldrb	r1, [r1,#1]
				cmp		r0, r1
				ble		CheckCon

					strb	r1, [r4,r2]
		
		CheckCon:
		mov		r3, #0x1A
		ldsb	r3, [r4,r3]
		mov		r2, #0x19
		ldsb	r2, [r5,r2]
		mov		r0, #0x11
		ldsb	r0, [r5,r0]
		ldr		r6, [r4]
		mov		r1, #0x13
		ldsb	r1, [r6,r1]
		add		r0, r1
		sub		r2, r0
		cmp		r3, r2
		ble		CheckMov
		
			ldrb	r1, [r6,#0x13]
			ldrb	r0, [r5,#0x11]
			add		r1, r0
			ldrb	r0, [r5,#0x19]
			sub		r0, r1
			strb	r0, [r4,#0x1A]
		
		CheckMov:
		mov		r2, #0x1D
		ldsb	r2, [r4,r2]
		mov		r1, #0x12
		ldsb	r1, [r5,r1]
		ldr		r6, =UniversalCapValuesLink
		ldrb	r6, [r6,#1]
		sub		r0, r6, r1
		cmp		r2, r0
		ble		End
		
			ldrb	r1, [r5,#0x12]
			sub		r0, r6, r1
			strb	r0, [r4,#0x1D]
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

