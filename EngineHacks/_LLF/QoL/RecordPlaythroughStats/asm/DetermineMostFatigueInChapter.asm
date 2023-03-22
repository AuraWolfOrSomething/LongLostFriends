.thumb

.include "RecordPlaythroughStatsDefinitions.asm"

.global DetermineMostFatigueInChapter
.type DetermineMostFatigueInChapter, %function

.global ClearAccumulatedFatigue
.type ClearAccumulatedFatigue, %function

@arguments given upon being called:
@r0 = PlaythroughStatsRAM
@r1 = PlayerUnitRosterSize

@r4 = loop variable 1 (added to r0 to check unit fatigue)
@r5 = loop variable 2 (check all player units' fatigue 3 times)
@r6 = current unit with highest fatigue
@r7 = current highest fatigue

@once unit(s) with most fatigue are found, store at stack, clear them, and then search again

		DetermineMostFatigueInChapter:
		push	{r4-r7,r14}
		sub		sp, #8
		
		@clear space for use later
		mov		r5, #0
		str		r5, [r13]
		str		r5, [r13,#4]
		
		InitMainLoop:
		mov		r4, #0
		mov		r6, #0
		mov		r7, #0
		
		MainLoop:
		@if no fatigue, skip to NextUnit
		ldrb	r2, [r0,r4]
		cmp		r2, r0
		beq		NextUnit
		
		@if it's lower than the highest so far, skip to NextUnit
		cmp		r2, r7
		blt		NextUnit
		
		@if it's the highest so far, store unitID in r6 and new fatigue in r7
		cmp		r2, r7
		bgt		NewHighestFound
		
		@if it's tied with the highest, check if it was already a tie
		  @if not, set bit for tie (0x80) and add 2
		  @if so, add 1
		mov		r3, #0x80
		tst		r6, r3
		bne		AnotherUnitTied
		
		add		r6, r3, #1
		
		AnotherUnitTied:
		add		r6, #1
		b		NextUnit
		
		NewHighestFound:
		mov		r6, r4
		mov		r7, r2
		
		NextUnit:
		add		r4, #1
		cmp		r4, r1
		blt		MainLoop
		
		@store r6 and r7
		mov		r3, r13
		lsl		r4, r5, #1
		strb	r6, [r3,r4]
		add		r4, #1
		strb	r7, [r3,r4]
		
		@clear fatigue that was just stored so it doesn't get "detected" on the next loop
		  @if no tie, we can just clear at [r0,r6]
		  @if there was a tie, then we need to go through [r0 to r0,r1-1] and clear all units that had fatigue equal to r7
		mov		r3, #0x80
		tst		r6, r3
		bne		GoToCAF_TiedUnits
		
		@if no tie, clear the unitID that held the record
		mov		r3, #0
		strb	r3, [r0,r6]
		b		CheckIfResetMainLoop
		
		GoToCAF_TiedUnits:
		mov		r2, r7
		bl 		ClearAccumulatedFatigue
		
		CheckIfResetMainLoop
		@check if we've done this 3 times
		  @if not, repeat main loop
		add		r5, #1
		cmp		r5, #3
		blt		InitMainLoop
		
		@Once the info we want to eventually store in the save file has been extracted, clear RAM and then only store that info 
		mov		r2, #0
		bl		ClearAccumulatedFatigue
		
		ldrh	r3, [r13]
		strh	r3, [r0]
		ldrh	r3, [r13,#2]
		strh	r3, [r0,#2]
		ldrh	r3, [r13,#4]
		strh	r3, [r0,#4]
		
		add		sp, #8
		pop		{r4-r7}
		pop		{r0}
		bx		r0


@arguments given upon being called:
@r0 = PlaythroughStatsRAM
@r1 = PlayerUnitRosterSize
@r2 = Minimum fatigue that should be cleared

		ClearAccumulatedFatigue:
		push	{r4}
		mov		r4, #0
		
		CAF_Loop:
		ldrb	r3, [r0,r4]
		cmp		r3, r2
		blt		CAF_Next
		
		mov		r3, #0
		strb	r3, [r0,r4]
		
		CAF_Next:
		add		r4, #1
		cmp		r4, r1
		blt		CAF_Loop
		
		pop		{r4}
		bx		r14

