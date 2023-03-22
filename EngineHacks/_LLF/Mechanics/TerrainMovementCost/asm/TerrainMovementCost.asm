.thumb

.global TerrainMovementCost
.type TerrainMovementCost, %function

.equ gActiveUnit, 0x03004E50
.equ gCurrentMovCostTable, 0x03004BB0

@r4 = current list/table being looped through
@r5 = can fly despite class (0 if not)
@r6 = set traversable terrain to this number (ignored if 0)
@r7 = subtract traversable terrain by this number
@sp = whatever r0 is when routine is called
@sp,#0x04 = unit

		TerrainMovementCost:
		push	{r4-r7,r14}
		add		sp, #-0x08
		str		r0, [sp]
		ldr		r0, =gActiveUnit
		ldr		r0, [r0]
		cmp		r0, #0
		bne		InitiateLoop_GiveFlightList
		
		@called from dangerzone
		mov		r0, r2
		
		InitiateLoop_GiveFlightList:
		str		r0, [sp,#4]
		ldr		r4, =GiveFlightMovementList
		mov		r5, #0
		
			LoopThroughChecks_GiveFlight:
			ldr		r3, [r4]
			cmp		r3, #0
			beq		InitiateLoop_SetMovList
			
			ldr		r0, [sp,#0x04]
			mov		lr, r3
			.short	0xF800
			add		r5, r0
			add		r4, #4
			b		LoopThroughChecks_GiveFlight
		
		InitiateLoop_SetMovList:
		ldr		r4, =SetTerrainMovementList
		mov		r6, #0
		
			LoopThroughChecks_Set:
			ldr		r3, [r4]
			cmp		r3, #0
			beq		InitiateLoop_SubMovList
			
			ldr		r0, [sp,#0x04]
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		ContinueLoopThroughChecks_Set
			
				@if no current set mov cost, use this
				cmp		r6, #0
				beq		NewSetMovCost
				
				@if previous set mov cost is greater than this set cost, use this set cost
			      @if not, continue loop
				cmp		r0, r6
				bge		ContinueLoopThroughChecks_Set
				
					NewSetMovCost:
					mov		r6, r0
			
			ContinueLoopThroughChecks_Set:
			add		r4, #4
			b		LoopThroughChecks_Set
		
		InitiateLoop_SubMovList:
		ldr		r4, =SubtractTerrainMovementList
		mov		r7, #0
		
			LoopThroughChecks_Subtract:
			ldr		r3, [r4]
			cmp		r3, #0
			beq		InitiateLoop_MovCostTable
			
			ldr		r0, [sp,#0x04]
			mov		lr, r3
			.short	0xF800
			add		r7, r0
			add		r4, #4
			b		LoopThroughChecks_Subtract
		
		InitiateLoop_MovCostTable:
		ldr		r1, [sp]
		mov		r2, #0 @looping counter
		ldr		r3, =AlwaysUntraversableTable
		ldr		r4, =gCurrentMovCostTable
		
		Loop_MovCostTable:
		ldrb	r0, [r3,r2]
		cmp		r0, #1
		bne		CheckTerrainNormalCost
		
			@terrain that can never be traversed
			mov		r0, #0xFF
			b		StoreMovCost
		
			CheckTerrainNormalCost:
			add		r0, r1, r2
			ldrb	r0, [r0]
			cmp		r0, #0xFF
			bne		CheckSetMovCost
			
				@if unit can't fly, they can't traverse this terrain
				cmp		r5, #0
				beq		StoreMovCost
				
			CheckSetMovCost:
			cmp		r6, #0
			beq		CheckSubtractMovCost
			
				@if tile's normal mov cost is lower than set mov cost, don't use set mov cost
				cmp		r0, r6
				ble		CheckSubtractMovCost
				
				mov		r0, r6
			
			CheckSubtractMovCost:	
			cmp		r7, #0
			beq		StoreMovCost
			
				sub		r0, r7
				
				@minimum cost of 1
				cmp		r0, #1
				bge		StoreMovCost
				
				mov		r0, #1
						
		StoreMovCost:
		strb	r0, [r4,r2]
		add		r2, #1
		cmp		r2, #0x40
		ble		Loop_MovCostTable
		
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


