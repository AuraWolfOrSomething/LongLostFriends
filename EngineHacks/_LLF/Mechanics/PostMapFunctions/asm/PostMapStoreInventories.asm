.thumb

.include "../PostMapFunctionsDefs.s"

.global PostMapStoreInventories
.type PostMapStoreInventories, %function


		PostMapStoreInventories:
		push	{r4-r7}
		
		@First, check if the convoy even has space for potential items
		ldr		r0, =ConvoySizePointer
		ldrb	r4, [r0]
		ldr		r0, =ConvoyPointer
		ldr		r5, [r0]
		sub		r5, #2
		add		r4, #2
		
		NextEmptySupplySlot:
		cmp		r4, #0
		beq		End @if no more space, then skip the rest of routine
		
			sub		r4, #1
			add		r5, #2
			ldrh	r1, [r5]
			cmp		r1, #0
			bne		NextEmptySupplySlot
		
		@If there's at least one empty supply slot, go through player units
		ldr		r6, =PlayerCharacterStructStart
		mov		r7, #0
		mov		r3, #0x48 @this is only used at one particular point, but since there's enough freedom with registers, do it outside of loops
		
		NewUnit:
		@Check if any unit here
		ldr		r0, [r6]
		cmp		r0, #0
		beq		CheckIfMoreUnits
			
			@Check if unit has a captured enemy
			CheckIfRescuingEnemy:
			ldrb	r0, [r6,#0x1B]
			mov		r1, #0x80
			and		r0, r1
			cmp		r0, #0
			beq		CheckIfMoreUnits
			
				@If so, store the captured enemy's inventory
				ldrb	r0, [r6,#0x1B]
				sub		r0, #0x81
				ldr		r1, =EnemyCharacterStructStart
				mul		r0, r3
				add		r0, r1
				add		r0, #0x1E
				mov		r2, #0
					
				StoreInConvoyLoop:
				ldrh	r1, [r0,r2]
				cmp		r1, #0
				beq		CheckIfMoreUnits
					
					strh	r1, [r5]
					add		r5, #2
					sub		r4, #1
					cmp		r4, #0
					beq		End
						
						add		r2, #2
						cmp		r2, #10
						blt		StoreInConvoyLoop
						
						b		CheckIfMoreUnits
		
		CheckIfMoreUnits:
		add 	r7, #1
		cmp 	r7, #0x3E
		bge 	End
		
		add 	r6, #0x48
		b 		NewUnit
		
		End:
		pop 	{r4-r7}
		bx 		r14

		.ltorg
		.align

