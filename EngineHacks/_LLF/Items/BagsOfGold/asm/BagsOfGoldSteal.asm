.thumb

.equ origin, 0x324CC

.global BagsOfGoldSteal
.type BagsOfGoldSteal, %function

.equ NotBagOfGold, . + 0x324FC - origin
.equ bl_GetItemCost, . + 0x1763C - origin
.equ bl_GetPartyGoldAmount, . + 0x24DE8 - origin
.equ bl_SetPartyGoldAmount, . + 0x24E04 - origin
.equ ReturnToVanilla, . + 0x3250A - origin


		BagsOfGoldSteal:
		and		r0, r6
		ldr 	r3, =BagsOfGoldList
		
		LoopThroughList:
		ldrb 	r1, [r3]
		cmp		r1, #0
		beq		NotBagOfGold
		
			add		r3, #1
			cmp		r0, r1
			bne		LoopThroughList

		@Get value of bag
		mov		r0, r6
		bl		bl_GetItemCost
		lsr		r4, r0, #1
		bl		bl_GetPartyGoldAmount
		add		r0, r4
		bl		bl_SetPartyGoldAmount
		b		ReturnToVanilla
		
		.align
		.ltorg

