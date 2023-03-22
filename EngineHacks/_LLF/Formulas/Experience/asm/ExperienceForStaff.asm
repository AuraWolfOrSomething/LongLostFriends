.thumb

.equ origin, 0
.include "../ExperienceDefs.s"
@.include "RecordPlaythroughStatsDefinitions.asm"

.global ExperienceForStaff
.type ExperienceForStaff, %function


		ExperienceForStaff:
		push	{r4,r14}
		mov		r4, r0
		ldr		r3, =CanUnitNotLevelUp
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@Idk what this is for
			ldr		r0, =gUnknownStaffExpCheck
			ldr		r0, [r0]
			lsl		r0, #0x0D
			lsr		r0, #0x0D
			mov		r1, #2
			tst		r0, r1
			beq		GetStaffExpValue
			
				mov		r0, #1
				b		End
		
		GetStaffExpValue:
		mov		r0, r4
		add		r0, #0x48
		ldrh	r0, [r0]
		ldr		r3, =GetItemMight @get staff's might
		mov		lr, r3
		.short	0xF800
		
		@check if promoted unit
		ldr		r2, [r4]
		ldr		r1, [r4,#4]
		ldr		r2, [r2,#0x28]
		ldr		r1, [r1,#0x28]
		orr		r2, r1
		mov		r1, #0x80
		lsl		r1, #1
		tst		r2, r1
		beq		IncludeBonusEXPForUndeployedChapterCount
		
			@if promoted, cut exp in half
			lsr		r2, r0, #0x1F
			add		r2, r0
			asr		r0, r2, #1
		
		IncludeBonusEXPForUndeployedChapterCount:
		mov		r1, r4
		ldr		r3, =BonusEXPForUndeployedChapters
		mov		lr, r3
		.short	0xF800
		
		@Cap exp gain to 100
		cmp		r0, #100
		@ble		AddToAccumulatedExperience
		ble		End
		
			mov		r0, #100
		
		@AddToAccumulatedExperience:
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
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

