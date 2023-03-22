.thumb

.include "RecordPlaythroughStatsDefinitions.asm"

.global AddToAccumulatedHealing
.type AddToAccumulatedHealing, %function


		AddToAccumulatedHealing:
		strb	r4, [r5,#0x13] @new current hp (overwritten in previous routine)
		sub		r0, r4, r6 @amount of healing
		cmp		r0, #0 @if no healing, skip
		ble		End
		
		ldr		r3, =PlaythroughStatsRAM
		add		r3, #0x42
		ldrh	r1, [r3]
		add		r1, r0
		ldr		r2, =MaxAccRecStat
		cmp		r1, r2
		ble		StoreNewAccumulatedHealing
		
		mov		r1, r2
		
		StoreNewAccumulatedHealing:
		strh	r1, [r3]
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0

