.thumb

.equ origin, 0x08028550
.include "../SupportBonusesDefs.s"

.global StoreAddedAffinityBonusesForSupportLevel
.type StoreAddedAffinityBonusesForSupportLevel, %function


		StoreAddedAffinityBonusesForSupportLevel:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r0, r1
		mov		r5, r2
		bl		bl_GetSupportBonusEntryPtr
		mov		r3, #1 @loop variable
		
		AddAffinityBonuses:
		ldrb	r1, [r0,r3]
		mul		r1, r5
		lsl		r6, r3, #1
		ldrh	r2, [r4,r6]
		add		r1, r2
		strh	r1, [r4,r6]
		add		r3, #1
		cmp		r3, #7
		blt		AddAffinityBonuses
		
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

