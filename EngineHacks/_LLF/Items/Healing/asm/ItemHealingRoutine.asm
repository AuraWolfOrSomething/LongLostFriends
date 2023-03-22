.thumb

.equ origin, 0
.include "../HealingDefs.s"

.global ItemHealingRoutine
.type ItemHealingRoutine, %function

@r0 = user (info not used atm, but could be useful to have for additional edits)
@r1 = item short


		ItemHealingRoutine:
		push	{r4-r5,r14}
		mov		r4, #0
		lsl		r3, r1, #0x18
		lsr		r3, #0x18
		ldr		r5, =ItemHealingList
		
		GoThroughItemHealingTable:
		ldrb	r0, [r5]
		cmp		r0, #0
		beq		End @if end of table reached, default to 0 hp restored
		
			cmp		r0, r3
			beq		EntryFound
		
				add		r5, #3
				b		GoThroughItemHealingTable
		
		EntryFound:
		ldrb	r4, [r5,#1]
		
		End:
		mov		r0, r4
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

