.thumb

.include "../GuardianDefs.s"

.global GuardianForEachTileInAoe
.type GuardianForEachTileInAoe, %function


		GuardianForEachTileInAoe:
		push	{r4-r7,r14}
		add		sp, #-0x0C
		str		r3, [r13] @routine to go to if a unit is in aoe range
		add		r3, r2, #4
		str		r3, [r13,#4] @aoe shape template
		ldrh	r3, [r2]
		str		r3, [r13,#8] @width and height of aoe shape's template (minus 1)
		
		@Start with the top left coordinate of the aoe
		ldrb	r3, [r2,#2] @center of aoe's x-coord
		sub		r4, r0, r3 @x-coord
		ldrb	r3, [r2,#3] @center of aoe's y-coord
		sub		r5, r1, r3 @y-coord
		mov		r6, #0 @position row
		mov		r7, #0 @row number
		
		IsTileInAoeShape:
		@Check if tile is on the map (no further up than upper border, then no further left than left border)
		cmp		r5, #0
		blt		NewRow

		cmp		r4, #0
		blt		GetTheNextTile
		
			@See if tile is covered by the aoe
			ldr		r0, [r13,#4]
			mov		r1, r13
			ldrb	r1, [r1,#8]
			mul		r1, r7
			add		r0, r1
			add		r0, r6
			ldrb	r0, [r0]
			cmp		r0, #0
			beq		GetTheNextTile
			
				@Check if a unit is on that tile
				ldr		r0, =gMapUnit
				ldr		r0, [r0]
				lsl		r1, r5, #2
				ldr		r0, [r0,r1]
				ldrb	r0, [r0,r4]
				cmp		r0, #0
				beq		GetTheNextTile
				
					@Confirmed that a unit is on that tile
					ldr		r1, =GetUnit
					mov		lr, r1
					.short	0xF800
					
					@Go to the routine passed down at the beginning of GuardianForEachTileInAoe
					ldr		r1, [r13]
					mov		lr, r1
					.short	0xF800
					
					@Add to the number of units affected by aoe (either adding 0 or 1)
					mov		r2, r13
					ldrh	r1, [r2,#0x0A]
					add		r1, r0
					strh	r1, [r2,#0x0A]
		
		GetTheNextTile:
		
		@Make sure we don't go off the map horizontally (right border)
		add		r4, #1
		add		r6, #1
		ldr		r1, =gMapSize
		ldrb	r0, [r1]
		cmp		r4, r0
		bge		NewRow
		
			@Make sure we don't exceed the aoe width
			mov		r0, r13
			ldrb	r0, [r0,#8]
			cmp		r6, r0
			blt		IsTileInAoeShape
			
				NewRow:
				sub		r4, r6
				mov		r6, #0
				
				@Make sure we don't go off the map vertically (bottom border)
				add		r5, #1
				ldr		r1, =gMapSize
				ldrb	r0, [r1,#2]
				cmp		r5, r0
				bge		ReturnAddedUnitCount
				
					@Make sure we don't exceed the aoe height
					add		r7, #1
					mov		r1, r13
					ldrb	r0, [r1,#9]
					cmp		r7, r0
					blt		IsTileInAoeShape

		ReturnAddedUnitCount:
		mov		r0, r13
		ldrh	r0, [r0,#0x0A]
		add		sp, #0x0C
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

