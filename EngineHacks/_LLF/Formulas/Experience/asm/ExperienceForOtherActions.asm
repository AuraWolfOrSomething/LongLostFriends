.thumb

.equ origin, 0
.include "../ExperienceDefs.s"
@.include "RecordPlaythroughStatsDefinitions.asm"

.global ExperienceForOtherActions
.type ExperienceForOtherActions, %function

		
		ExperienceForOtherActions:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =gTargetBattleUnit
		add		r1, #0x48
		ldrb	r1, [r1]
		ldr		r3, =ItemStealExperienceList
		
		LoopThroughList:
		ldrb	r2, [r3]
		cmp		r2, #0
		beq		NotOnList
		
			cmp		r2, r1
			beq		GetExpValue
			
				add		r3, #2
				b		LoopThroughList
		
		GetExpValue:
		ldrb	r0, [r3,#1]
		b		IncludeBonusEXPForUndeployedChapterCount
		
		NotOnList:
		mov		r0, #20 @default of 20 exp
		
		IncludeBonusEXPForUndeployedChapterCount:
		mov		r1, r4
		ldr		r3, =BonusEXPForUndeployedChapters
		mov		lr, r3
		.short	0xF800
		
		mov		r2, r4
		add		r2, #0x6E
		strb	r0, [r2]
		@ldr		r1, =PlaythroughStatsRAM
		@add		r1, #0x44
		@ldrh	r2, [r1]
		@add		r2, r0
		@ldr		r3, =MaxAccRecStat
		@cmp		r2, r3
		@ble		StoreAccumulatedExperience
		
		@mov		r2, r3
		
		@StoreAccumulatedExperience:
		@strh	r2, [r1]
		
		ldrb	r2, [r4,#9]
		add		r2, r0
		strb	r2, [r4,#9]
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

