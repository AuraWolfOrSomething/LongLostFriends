.thumb

.global GetStatAverage
.type GetStatAverage, %function


			GetStatAverage:
			push	{r4-r7}
			mov		r4, r0
			mov		r5, r1
			mov		r7, #0
			
			ldr		r2, [r4]
			ldr		r3, [r4,#4]

			@load character base stat
			mov		r1, #0x0C
			add		r1, r5
			ldrsb	r6, [r2,r1]

			@load class base stat (unless it's luck)
			cmp		r5, #6
			bge		CheckIfUnitHasPromoted

				sub		r1, #1
				ldrb	r1, [r3,r1]
				add		r6, r1
			
			CheckIfUnitHasPromoted:
			mov		r0, #0
			ldr		r0, [r2,#0x28]
			mov		r1, #0x80
			lsl		r1, #1
			tst		r0, r1
			bne		GetCurrentLevel @if unit starts promoted, get current level
			
				@if unit starts unpromoted, check if currently in a promoted class
				@didn't do this right
				ldr		r0, [r3,#0x28]
				tst		r0, r1
				beq		GetCurrentLevel
			
					@if unpromoted -> promoted
					mov		r7, #1
			
			GetCurrentLevel:
			@get current level unless unpromoted -> promoted and currently calculating averages for leveling while unpromoted (in that case, use 10)
			ldrb	r0, [r4,#8]
			cmp		r7, #1
			bne		GetBaseLevel
			
			mov		r0, #10
			
			@get base level unless unpromoted -> promoted and currently calculating averages for leveling while promoted (in that case, use 1)
			GetBaseLevel:
			ldrb	r1, [r2,#0x0B]
			cmp		r7, #2
			bne		SubtractLevelAmounts
			
				mov		r1, #1
			
			SubtractLevelAmounts:
			sub		r0, r1
			cmp		r0, #0
			ble		CheckIfCalculationComplete @multiply if postive
			
				@get growth
				mov		r1, #0x1C
				add		r1, r5
				ldrb	r1, [r2,r1]
				mul		r0, r1
				mov		r1, #0
				
				AverageIncrease:
				cmp		r0, #100
				blt		GetStatCap
				
					sub		r0, #100
					add		r1, #1
					b		AverageIncrease
				
				GetStatCap:
				add		r6, r1
				cmp		r5, #6
				bne		CheckClassCap
				
					@Lck
					ldr		r1, =UniversalCapValuesLink
					ldrb	r0, [r1]
					b		CheckIfCapped
				
				CheckClassCap:
				mov		r1, r3
				cmp		r7, #1
				bne		LoadClassCap
				
					@find previous class entry on class table
					ldrb	r0, [r2,#5] @class id of class in support viewer
					lsl		r1, r0, #6
					lsl		r2, r0, #4
					add		r1, r2
					lsl		r2, r0, #2
					add		r1, r2
					ldr		r0, =ClassTable
					add		r1, r0
				
				LoadClassCap:
				mov		r0, #0x13
				add		r0, r5
				add		r1, r0
				ldrb	r0, [r1]
				
				@load character cap mod
				cmp		r5, #0 @no char cap for HP
				beq		CheckIfCapped
				
					push	{r0}
					ldr		r0, [r4]
					ldrb	r0, [r0,#4]
					ldr		r2, =CharacterCapModifierTable
					ldrb	r1, [r2]
					cmp		r0, r1
					blt		DefaultCharCap
					
						ldrb	r1, [r2,#1]
						cmp		r0, r1
						ble		GetCharCapEntry
					
							DefaultCharCap:
							ldrb	r0, [r2,#2] @If character id isn't in range, just use entry for this id
							
					GetCharCapEntry:
					lsl		r1, r0, #2
					add		r0, r1 @entries are 5 bytes long
					add		r2, r0
					sub		r0, r5, #1
					ldsb	r1, [r2,r0]
					
					pop		{r0}
					add		r0, r1
				
				@if averages would calculate stat being above cap, set average to the cap
				CheckIfCapped:
				cmp		r6, r0
				ble		CheckIfCalculationComplete
				
				mov		r6, r0
			
			CheckIfCalculationComplete:
			cmp		r7, #1
			bne		ReturnStatAverage
			
				@add promotion bonuses
				cmp		r5, #6
				beq		GoCalculatePromotedLeveling
			
					mov		r0, #0x22
					add		r0, r5
					ldrb	r0, [r3,r0]
			
			GoCalculatePromotedLeveling:
			ldr		r2, [r4]
			mov		r7, #2
			b		GetCurrentLevel
			
		ReturnStatAverage:
		mov		r0, r6
		pop		{r4-r7}
		bx		r14
			
			
		.align
		.ltorg

