.thumb

.equ origin, 0
.include "../HealingDefs.s"

.global CheckStaffHealingEnhancement
.type CheckStaffHealingEnhancement, %function


		CheckStaffHealingEnhancement:
		push	{r4-r7,r14}
		mov		r4, r0 @user
		mov		r5, #0 @staff healing enhancement
		mov		r6, #0 @loop variable
		
		InventoryLoop:
		ldr		r7, =StaffHealingEnhancementList @go back to the beginning of this list so we can check all item ids again
		lsl		r0, r6, #1
		add		r0, #0x1E
		add		r2, r4, r0
		
		CheckIfItemIsOnList:
		ldrb	r0, [r2]
		
		@if no item found in inventory slot, then unit has no more items
		cmp		r0, #0
		beq		End
		
			ListLoop:
			@if item is found, see if unit has rank to use it
			ldrb	r1, [r7]
			cmp		r0, r1
			beq		CanUnitWieldEnhancementItem
				
				@if item didn't match, check if end of the list; if not, keep looping through the list
				add		r7, #2
				cmp		r1, #0
				bne		ListLoop
				
			@otherwise, check if unit has any more inventory slots
			CheckIfEndOfInventory:
			add		r6, #1
			cmp		r6, #4
			ble		InventoryLoop
					
				@if not, we're done
				b		End
			
		CanUnitWieldEnhancementItem:
		mov		r0, r4
		ldr		r2, =CanUnitWieldWeapon
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0 @if unit can't wield weapon, no enhancement
		beq		CheckIfEndOfInventory
		
		ReturnAmount:
		ldrb	r0, [r7,#1] @the item's enhancement
		
		@if this item's enhancement is less than the last enhancement, don't use it
		cmp		r0, r5
		blt		CheckIfEndOfInventory
		
			mov		r5, r0
			b		CheckIfEndOfInventory
		
		End:
		mov		r0, r5
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

