.thumb

.equ origin, 0x115A4

.global BagsOfGoldDrop
.type BagsOfGoldDrop, %function

.equ NotBagOfGold, . + 0x115CC - origin
.equ bl_GetItemCost, . + 0x1763C - origin
.equ bl_NewGoldGotPopup, . + 0x11644 - origin
.equ ReturnToVanilla, . + 0x115D4 - origin


		BagsOfGoldDrop:
		lsr		r0, r1, #0x10
		mov		r2, #0xFF
		and		r2, r0
		ldr 	r3, =BagsOfGoldList
		
		LoopThroughList:
		ldrb 	r1, [r3]
		cmp		r1, #0
		beq		NotBagOfGold
		
			add		r3, #1
			cmp		r2, r1
			bne		LoopThroughList

		@Get value of bag
		bl		bl_GetItemCost
		lsr		r2, r0, #1
		mov		r0, r4
		mov		r1, r5
		bl		bl_NewGoldGotPopup
		b		ReturnToVanilla
		
		.align
		.ltorg

