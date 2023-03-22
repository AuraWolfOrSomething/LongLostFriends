.thumb

.include "../BattleQuoteConditionalChecksDefs.s"

.global AsmcReturnOpponentID
.type AsmcReturnOpponentID, %function


		AsmcReturnOpponentID:
		ldr		r1, =gEventSlot1
		ldrb	r1, [r1] @the unit ID that we aren't looking for
		
		ldr		r0, =gCombatAttacker
		ldr		r0, [r0]
		ldrb	r0, [r0,#4]
		cmp		r0, r1
		bne		StoreID
		
			ldr		r0, =gCombatDefender
			ldr		r0, [r0]
			ldrb	r0, [r0,#4]
		
		StoreID:
		ldr		r1, =gEventSlotC
		str		r0, [r1]
		bx		r14
		
		.align
		.ltorg

