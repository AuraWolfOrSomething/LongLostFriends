.thumb

.equ origin, 0x08028870
.include "../ItemEffectDefs.s"

.global CanUnitUseItem
.type CanUnitUseItem, %function


		CanUnitUseItem:
		push	{r4-r5,r14}
		mov		r4, r0 @unit
		mov		r5, r1 @item short
		
		@Check if this is a staff; if so, check if unit can use staffs
		mov		r0, r5
		bl		bl_GetItemAttributes
		mov		r1, #4
		tst		r1, r0
		beq		GoToGetItemIndex
		
			mov		r0, r4
			mov		r1, r5
			bl		bl_CanUnitWieldStaff
			lsl		r0, #0x18
			cmp		r0, #0
			bne		GoToGetItemIndex
			
				b		CannotUseItem
		
		GoToGetItemIndex:
		mov		r0, r5
		bl		bl_GetItemIndex
		sub		r0, #FirstItemWithEffect
		cmp		r0, #NumberOfItemsWithEffect
		bls		LoadEntry
		
			b	CannotUseItem
		
		LoadEntry:
		lsl		r0, #2
		ldr		r1, =ItemUsabilityTable
		add		r0, r1
		ldr		r0, [r0]
		mov		r1, r5
		
		@If this routine is new, do not immediately jump there
		mov		r2, #8
		lsl		r2, #8
		add		r2, #3
		lsl		r2, #16
		cmp		r2, r0
		ble		DoNotJump
		
			mov		r15, r0
		
		DoNotJump:
		mov		lr, r0
		mov		r0, r4
		.short	0xF800
		b		ConditionComplete
		
		.align
		.ltorg

