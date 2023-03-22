.thumb

.equ origin, 0x08028E60
.include "../ItemEffectDefs.s"

.global ItemEffect_Call
.type ItemEffect_Call, %function


		ItemEffect_Call:
		push	{r4-r5,r14}
		mov		r5, r0 @unit
		mov		r4, r1 @item short
		
		@Clear ui graphics
		bl		bl_ClearBG0BG1
		mov		r0, #0
		bl		bl_EndFaceById
		
		mov		r0, r4
		bl		bl_GetItemIndex
		sub		r0, #FirstItemWithEffect
		cmp		r0, #NumberOfItemsWithEffect
		bls		LoadEntry
		
			b	DefaultTargetSelection
		
		LoadEntry:
		lsl		r0, #2
		ldr		r1, =ItemTargetTable
		add		r0, r1
		ldr		r0, [r0]
		mov		r1, r4
		
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
		mov		r0, r5
		.short	0xF800
		b		TargetComplete
		
		.align
		.ltorg

