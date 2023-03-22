.thumb

.include "../PlanDefs.s"

.global FutureStoreTurnEvents
.type FutureStoreTurnEvents, %function


		FutureStoreTurnEvents:
		push	{r4-r7,r14}
		mov		r4, r0
		add		r4, #0x30 @event queue
		mov		r1, #0x29
		ldrb	r5, [r0,r1] @phase we're looking for
		mov		r6, #0
		mov		r0, #0

		@get current chapter
		ldr		r1, =gChapterData
		mov		r0, #0x0E
		ldsb	r0, [r1,r0]
		ldr		r1, =GetChapterEventDataPointer
		mov		lr, r1
		.short	0xF800
		ldr		r7, [r0] @pointers to each turn event in this chapter
		
		@Copy what CheckEventDefinition (08082EC4) and EvCheck02_TURN (08083864) do, for the most part
		LoopThroughTurnBasedEvents:
		ldr		r0, [r7]
		cmp		r0, #0 @No more turn events
		beq		End
		
			@Check Event ID to see if event can still happen
			ldrh	r0, [r7,#2]
			ldr		r1, =CheckEventID
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			bne		GetAnotherTurnEvent
			
				@Check if phase matches what we're currently searching
				ldrh	r0, [r7,#0x0A]
				cmp		r0, r5
				bne		GetAnotherTurnEvent
				
					@Check if turn matches what we're currently searching
					ldrb	r0, [r7,#8] @start turn
					ldrb	r1, [r7,#9] @last turn (0x00 if event only plays for a single turn, 0xFF if it never stops)
					cmp		r1, #0
					bne		CheckEventLastTurn
					
						mov		r1, r0
						b		DoesEventPlayThisTurn
					
					CheckEventLastTurn:
					cmp		r1, #0xFF
					bne		DoesEventPlayThisTurn
					
						mov		r1, #0x7F
						lsl		r1, #24
					
					DoesEventPlayThisTurn:
					ldr		r2, =gChapterData
					ldrh	r2, [r2,#0x10]
					
					@check if start turn exceeds current turn (turn event will start happening farther in the future)
					cmp		r0, r2
					bgt		GetAnotherTurnEvent
					
						@check if current turn exceeds the ending turn (current turn exceeds turn event's range)
						cmp		r2, r1
						bgt		GetAnotherTurnEvent
						
							lsl		r1, r6, #2
							str		r7, [r4,r1]
							add		r6, #1
		
							GetAnotherTurnEvent:
							add		r7, #0x0C
							cmp		r6, #MaxNumberOfTurnEventsToPlayForFaction
							blt		LoopThroughTurnBasedEvents
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

