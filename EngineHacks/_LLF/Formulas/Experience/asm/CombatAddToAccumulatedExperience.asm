.thumb

.include "RecordPlaythroughStatsDefinitions.asm"

.global CombatAddToAccumulatedExperience
.type CombatAddToAccumulatedExperience, %function


		CombatAddToAccumulatedExperience:
		ldr		r1, =PlaythroughStatsRAM
		add		r1, #0x44
		ldrh	r2, [r1]
		add		r2, r0
		ldr		r3, =MaxAccRecStat
		cmp		r2, r3
		ble		StoreNewExperience
		
		mov		r2, r3
		
		StoreNewExperience:
		strh	r2, [r1]
		
		@do vanilla stuff that was overwritten
		add		sp, #4
		pop		{r4-r5}
		pop		{r1}
		bx		r1

