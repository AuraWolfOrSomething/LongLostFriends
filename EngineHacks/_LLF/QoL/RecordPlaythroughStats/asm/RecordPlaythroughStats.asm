.thumb

.include "RecordPlaythroughStatsDefinitions.asm"

.global ClearChapterPlaythroughStats
.type ClearChapterPlaythroughStats, %function

.global SavePlaythroughStats
.type SavePlaythroughStats, %function

.global PackChapterPlaythroughStats
.type PackChapterPlaythroughStats, %function

.global DetermineMostFatigueInChapter
.type DetermineMostFatigueInChapter, %function

.global ClearRecordedChapterInfo
.type ClearRecordedChapterInfo, %function



@-----------------------------------------
@ClearChapterPlaythroughStats
@-----------------------------------------

@Currently, not using the information saved other than for my own interest, so all I need to do is make sure this area is clear for the next chapter

		ClearChapterPlaythroughStats:
		push	{r14}
		ldr		r0, =PlaythroughStatsRAM
		mov		r1, #PlaythroughStatsSuspendSize
		mov		r2, #0
		bl		ClearRecordedChapterInfo
		
		pop		{r0}
		bx		r0


@-----------------------------------------
@SavePlaythroughStats
@-----------------------------------------

@observations from EMS unit saving
@r0 = current location in save data
@r1 = declared size of chunk
@save unit into space allocated from stack, then call WriteAndVerifySramFast

		SavePlaythroughStats:
		push	{r4-r7,r14}
		mov		r4, r0 @current spot in save data
		mov		r5, r1 @size of chunk
		mov		r6, #PlaythroughStatsChapterSize
		sub		sp, #PlaythroughStatsChapterSize
		
		@Get chapter id
		ldr		r2, =ChapterDataStruct
		mov		r3, #0x0E
		ldsb	r3, [r2,r3]
		cmp		r3, #0 @if new game, skip; no chapter done yet
		beq		SPS_End
		
		sub		r3, #1 @we want to save the chapter we just cleared, but this value is already updated to the next chapter id
		
		@To do: for instances where the player has to choose which chapter(s) to play (e.g. route split), change chapter id to its "true equivalent" before storing
		
		@Get area to store chapter info and make sure it doesn't go past chunk
		  @if it would, don't save this
		mul		r3, r6
		cmp		r3, r1
		bge		SPS_End
		
		add		r4, r3
		
		@Before transferring to IRAM, decide the 3 units with the most fatigue accumulated (ties will be noted)
		ldr		r0, =PlaythroughStatsRAM
		mov		r1, #PlayerUnitRosterSize
		bl		DetermineMostFatigueInChapter

		@Transfer from RAM to IRAM
		mov		r1, sp
		bl		PackChapterPlaythroughStats
		
		@Transfer from IRAM to Cart RAM
		mov		r0, sp
		mov		r1, r4
		mov		r2, r6
		ldr		r3, =WriteAndVerifySramFast
		mov		lr, r3
		.short	0xF800
		
		SPS_End:
		@Clear area out for next chapter
		bl		ClearChapterPlaythroughStats
		
		add		sp, #PlaythroughStatsChapterSize
		pop		{r4-r7}
		pop		{r0}
		bx		r0


@-----------------------------------------
@PackChapterPlaythroughStats
@-----------------------------------------

@arguments given upon being called:
@r0 = PlaythroughStatsRAM
@r1 = Space from stack

		PackChapterPlaythroughStats:
		push	{r4-r7,r14}
		
		@Fatigue: Units that accumulated the most fatigue, second most, and third most (or ties, and how many units tied)
		@After each id/tie, the amount
		
		ldrh	r2, [r0]
		strh	r2, [r1]
		ldrh	r2, [r0,#2]
		strh	r2, [r1,#2]
		ldrh	r2, [r0,#4]
		strh	r2, [r1,#4]
		
		mov		r3, r0
		add		r3, #0x3C
		
		@Damage dealt on player phase 
		ldrh	r2, [r3]
		strh	r2, [r1,#6]
		
		@Damage dealt on enemy phase
		ldrh	r2, [r3,#2] 
		strh	r2, [r1,#8]
		
		@Damage received
		ldrh	r2, [r3,#4]
		strh	r2, [r1,#0xA]
		
		@Damage healed
		ldrh	r2, [r3,#6]
		strh	r2, [r1,#0xC]
		
		@Experience gained
		ldrh	r2, [r3,#8]
		strh	r2, [r1,#0xE]
		
		@Number of powerful item uses expended
		@ldrb	r2, [r3,#0xA]
		@strb	r2, [r1,#0x10]
		
		@Number of enemies captured
		ldrb	r2, [r3,#0xB]
		strb	r2, [r1,#0x11]
		
		@Turn count (only storing since there's free space)
		ldr		r2, =ChapterDataStruct
		ldrh	r2, [r2,#0x10]
		strh	r2, [r1,#0x12]	
		
		@Side objectives completed
		@str		r2, [r1,#0x14]
		
		@END
		pop		{r4-r7}
		pop		{r1}
		bx		r1



@-----------------------------------------
@DetermineMostFatigueInChapter
@-----------------------------------------

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
		cmp		r2, #0
		beq		NextUnit
		
		@if it's lower than the highest so far, skip to NextUnit
		@if it's the highest so far, store unitID in r6 and new fatigue in r7
		cmp		r2, r7
		blt		NextUnit
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
		add		r6, #1 @fatigue stored at unitID-1, so add 1 to get unitID
		mov		r7, r2
		
		NextUnit:
		add		r4, #1
		cmp		r4, r1
		blt		MainLoop
		
		cmp		r7, #0
		beq		NoFatigueAccumulated
		
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
		
		@if no tie, clear the unit that held the record
		mov		r3, #0
		sub		r6, #1
		strb	r3, [r0,r6]
		b		CheckIfResetMainLoop
		
		GoToCAF_TiedUnits:
		mov		r2, r7
		bl 		ClearRecordedChapterInfo
		
		CheckIfResetMainLoop:
		@check if we've done this 3 times
		  @if not, repeat main loop
		add		r5, #1
		cmp		r5, #3
		blt		InitMainLoop
		
		NoFatigueAccumulated:
		@Once the info we want to eventually store in the save file has been extracted, clear RAM and then only store that info 
		mov		r2, #0
		bl		ClearRecordedChapterInfo
		
		mov		r3, r13
		ldrh	r2, [r3]
		strh	r2, [r0]
		ldrh	r2, [r3,#2]
		strh	r2, [r0,#2]
		ldrh	r2, [r3,#4]
		strh	r2, [r0,#4]
		
		add		sp, #8
		pop		{r4-r7}
		pop		{r1}
		bx		r1


@-----------------------------------------
@ClearRecordedChapterInfo
@-----------------------------------------

@arguments given upon being called:
@r0 = PlaythroughStatsRAM
@r1 = PlayerUnitRosterSize OR PlaythroughStatsSuspendSize
@r2 = Minimum fatigue that should be cleared; if r1 is PlaythroughStatsSuspendSize, 0 should be passed for intended use

@if PlayerUnitRosterSize is passed, it will only clear out accumulated fatigue information greater than or equal to r2
@if PlaythroughStatsSuspendSize is passed, it will clear all information gathered

		ClearRecordedChapterInfo:
		push	{r4}
		mov		r4, #0
		
		CRCI_Loop:
		ldrb	r3, [r0,r4]
		cmp		r3, r2
		blt		CRCI_Next
		
		mov		r3, #0
		strb	r3, [r0,r4]
		
		CRCI_Next:
		add		r4, #1
		cmp		r4, r1
		blt		CRCI_Loop
		
		pop		{r4}
		bx		r14

