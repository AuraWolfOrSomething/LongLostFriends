.thumb

.equ origin, 0x080193A4
.include "../HealingDefs.s"

.global NewUnitTryHeal
.type NewUnitTryHeal, %function


		NewUnitTryHeal:
		push	{r4-r6,r14}
		mov		r5, r0
		mov		r6, #0x13
		ldsb	r6, [r5,r6]
		add		r4, r6, r1
		bl		GetTrueMaxHealth
		cmp		r4, r0
		ble		SetMinimumZero
		
		mov		r0, r5
		bl		GetTrueMaxHealth
		mov		r4, r0
		
		SetMinimumZero:
		cmp		r4, #0
		@bge		GoToAddToAccumulatedHealing
		bge		End
		
			mov		r4, #0
		
		@StoreNewHealth:
		@strb	r4, [r5,#0x13]
		@sub		r0, r4, r6 @amount of healing
		
		@GoToAddToAccumulatedHealing:
		@ldr		r3, =AddToAccumulatedHealing
		@bx		r3
		
		End:
		strb	r4, [r5,#0x13] @new current hp
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		GetTrueMaxHealth:
		push	{r4,r14}
		mov		r4, r0
		bl		blGetUnitEquippedItem
		lsl		r0, #0x10
		lsr		r0, #0x10
		bl		blGetItemHealthBonus
		mov		r1, #0x12
		ldsb	r1, [r4,r1]
		add		r0, r1
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

