.thumb

.equ origin, 0x0802FC48
.include "../ItemEffectDefs.s"

.global ActionStaffDoorChestUseItem
.type ActionStaffDoorChestUseItem, %function


		ActionStaffDoorChestUseItem:
		push	{r4-r7,r14}
		mov		r7, r8
		push	{r7}
		mov		r6, r0
		ldr		r4, =gActionData
		ldrb	r0, [r4,#0x0C]
		bl		bl_GetUnit
		ldrb	r1, [r4,#0x12]
		lsl		r1, #1
		add		r0, #0x1E
		add		r0, r1
		ldrh	r0, [r0]
		bl		bl_GetItemIndex
		mov		r8, r0
		ldr		r0, =gActiveBattleUnit
		add		r0, #0x7E
		mov		r2, #0
		strb	r2, [r0]
		mov		r0, r8
		sub		r0, #FirstItemWithEffect
		cmp		r0, #NumberOfItemsWithEffect
		bls		LoadEntry
		
			b		EffectComplete
		
		LoadEntry:
		lsl		r0, #2
		ldr		r1, =ItemEffectTable
		add		r0, r1
		ldr		r0, [r0]
		mov		r1, r8
		
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
		mov		r0, r6
		.short	0xF800
		b		EffectComplete
		
		.align
		.ltorg

