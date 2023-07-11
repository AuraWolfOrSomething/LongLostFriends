.thumb

.include "../PostMapFunctionsDefs.s"

.global PostMapResetCertainItems
.type PostMapResetCertainItems, %function

.global ItemResetListBranchLink
.type ItemResetListBranchLink, %function

@go through player unit inventories, then convoy

@player unit inventories:
@r4 = current unit
@r5 = pointer to spot in unit inventory
@r6 = loop variable
@r7 = inventory loop variable

@convoy:
@r4 = convoy
@r5 = loop variable
@r6 = convoy size

		PostMapResetCertainItems:
		push	{r4-r7,r14}
		ldr		r4, =PlayerCharacterStructStart
		mov		r6, #0 @units so far
		
		NewUnit:
		mov		r5, #0x1E @current spot in inventory
		mov		r7, #0 @items from unit so far
		
		InventoryLoop:
		ldrb	r0, [r4,r5]
		cmp		r0, #0
		beq		CheckIfMoreUnits @if nothing in item slot, done with this unit
		
		add		r1, r4, r5
		bl		ItemResetListBranchLink
		
		CheckIfMoreItems:
		add		r5, #2
		add		r7, #1
		cmp		r7, #5 @inventory limit is 5 items
		blt		InventoryLoop
		
		CheckIfMoreUnits:
		add 	r6, #1
		cmp 	r6, #0x3E
		bge 	StartConvoyLoop
		
		add 	r4, #0x48
		b 		NewUnit
		
		StartConvoyLoop:
		ldr		r4, =ConvoyPointer
		ldr		r4, [r4]
		mov		r5, #0
		ldr		r6, =ConvoySizePointer
		ldrb	r6, [r6]
		add		r6, #1
		
		ConvoySlotLoop:
		lsl		r1, r5, #1
		ldrb	r0, [r4,r1]
		cmp		r0, #0
		beq		End @if spot is empty (empty spots start after all stored items), we're done
		
		cmp		r5, r6 @make sure we're not overwritting/checking whatever's immediately after the convoy in RAM
		bge		End
		
		add		r1, r4
		bl		ItemResetListBranchLink
		add		r5, #1
		b		ConvoySlotLoop
		
		End:
		pop 	{r4-r7}
		pop 	{r0}
		bx 		r0

		.ltorg
		.align
		
		
		
		ItemResetListBranchLink:
		@r0 = item id loaded from unit/convoy
		@r1 = where to store the reset item (if on list)
		
		ldr		r3, =ItemResetList
		
		ItemResetListLoop:
		ldrb	r2, [r3]
		cmp		r2, #0
		beq		ReturnToPreviousFunction @ItemResetList is terminated by WORD 0
		
		cmp		r0, r2
		beq		ResetThisItem @if item matches item id of entry, read the rest of entry for proper reset
		
		add		r3, #4
		b		ItemResetListLoop
		
		ResetThisItem:
		ldrb	r0, [r3,#1]
		add		r1, #1
			
		@check if top nibble should be changed
		  @if so, load new value
		  @if not, load current top nibble
		ldrb	r2, [r3,#2]
		cmp		r2, #1
		bne		LoadCurrentState
			
		ldrb 	r2, [r3,#3]
		b		StoreNewState

		LoadCurrentState:
		ldrb 	r2, [r1]
		lsr		r2, #4
		lsl		r2, #4
			
		StoreNewState:
		add		r0, r2
		strb	r0, [r1]
		
		ReturnToPreviousFunction:
		bx		r14
