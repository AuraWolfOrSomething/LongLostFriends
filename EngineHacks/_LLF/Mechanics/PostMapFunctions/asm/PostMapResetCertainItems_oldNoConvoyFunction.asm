.thumb

.include "PostMapFunctionsDefinitions.asm"

.global PostMapResetCertainItems
.type PostMapResetCertainItems, %function

@go through player unit inventories, then convoy


		PostMapResetCertainItems:
		push	{r4-r7,r14}
		ldr		r4, =PlayerCharacterStructStart
		mov		r5, #0 @units so far
		
		NewUnit:
		mov		r6, #0 @items from unit so far
		mov		r3, #0x1E @current spot in inventory
		
		InventoryLoop:
		ldrb	r0, [r4,r3]
		cmp		r0, #0
		beq		CheckIfMoreUnits @if nothing in item slot, done with this unit
		
			ldr		r7, =ItemResetList
		
		ItemResetListLoop:
			ldrb	r1, [r7]
			cmp		r1, #0
			beq		CheckIfMoreItems @ItemResetList is terminated by WORD 0
		
				cmp		r0, r1
				beq		ResetThisItem @if item matches item id of entry, read the rest of entry for proper reset
		
					add		r7, #4
					b		ItemResetListLoop
		
		ResetThisItem:
			ldrb	r0, [r7,#1]
			mov		r2, r3
			add		r2, #1
			
		@check if top nibble should be changed
			@if so, load new value
			@if not, load current top nibble
			ldrb	r1, [r7,#2]
			cmp		r1, #1
			bne		LoadCurrentState
			
				ldrb 	r1, [r7,#3]
				b		StoreNewState

				LoadCurrentState:
				ldrb 	r1, [r4,r2]
				lsr		r1, #4
				lsl		r1, #4
			
		StoreNewState:
			add		r0, r1
			strb	r0, [r4,r2]
		
		CheckIfMoreItems:
			add		r3, #2
			add		r6, #1
			cmp		r6, #5 @inventory limit is 5 items
			blt		InventoryLoop
		
		CheckIfMoreUnits:
		add 	r5, #1
		cmp 	r5, #0x46
		bge 	StartConvoyLoop
		
		add 	r4, #0x48
		b 		NewUnit
		
		
		StartConvoyLoop:
		ldr		r4, =ConvoyPointer
		ldr		r4, [r4]
		mov		r5, #0
		ldr		r6, =ConvoySize
		ldrb	r6, [r6]
		add		r6, #1
		
		ConvoySlotLoop:
		lsl		r1, r5, #1
		ldrb	r0, [r4,r1]
		cmp		r0, #0
		beq		EndOfRoutine @if spot is empty (empty spots start after all stored items), we're done
		
		cmp		r5, r6 @make sure we're not overwritting/checking whatever's immediately after the convoy in RAM
		bge		EndOfRoutine
		
		
		
		EndOfRoutine:
		pop 	{r4-r7}
		pop 	{r0}
		bx 		r0

		.ltorg
		.align

