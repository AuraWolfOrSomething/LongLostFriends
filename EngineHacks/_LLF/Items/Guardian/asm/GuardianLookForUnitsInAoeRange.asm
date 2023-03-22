.thumb

.include "../GuardianDefs.s"

.global GuardianLookForUnitsInAoeRange
.type GuardianLookForUnitsInAoeRange, %function


		GuardianLookForUnitsInAoeRange:
		push	{r4-r7,r14}
		add		sp, #-0x0C
		mov		r4, #0 @x-coord
		mov		r5, #0 @y-coord
		mov		r6, r0 @staff user
		mov		r7, r1 @routine to go to if a unit is in aoe range
		str		r2, [sp] @aoe shape template
		
		@Get staff range before beginning loop
		ldr		r0, =GuardianStaffIdLink
		ldrb	r0, [r0]
		mov		r1, #0xFF
		and		r0, r1
		lsl		r1, r0, #3
		add		r0, r1
		lsl		r0, #2
		ldr		r1, =ItemTable
		add		r0, r1
		ldrb	r0, [r0,#0x19]
		lsr		r1, r0, #4
		str		r1, [sp,#4] @min range
		mov		r1, #0x0F
		and		r0, r1
		str		r0, [sp,#8] @max range
		
		IsTileInStaffRange:
		mov		r0, r6
		mov		r1, r4
		mov		r2, r5
		ldr		r3, =GetDistanceFromCoords
		mov		lr, r3
		.short	0xF800
		ldr		r1, [sp,#8]
		cmp		r0, r1
		bgt		NextTile
		
			ldr		r1, [sp,#4]
			cmp		r0, r1
			blt		NextTile
			
				ldr		r0, =GuardianForEachTileInAoe
				mov		lr, r0
				mov		r0, r4
				mov		r1, r5
				ldr		r2, [sp]
				mov		r3, r7
				.short	0xF800
				cmp		r0, #0
				bne		End
			
					NextTile:
					add		r4, #1
					ldr		r1, =gMapSize
					ldrb	r0, [r1]
					cmp		r4, r0
					blt		IsTileInStaffRange
					
						@new row
						mov		r4, #0
						add		r5, #1
						ldrb	r0, [r1,#2]
						cmp		r5, r0
						blt		IsTileInStaffRange
		
		End:
		add		sp, #0x0C
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

