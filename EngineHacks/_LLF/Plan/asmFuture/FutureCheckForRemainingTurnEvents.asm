.thumb

.include "../PlanDefs.s"

.global FutureCheckForRemainingTurnEvents
.type FutureCheckForRemainingTurnEvents, %function


		FutureCheckForRemainingTurnEvents:
		push	{r4-r5,r14}
		ldr		r4, =gChapterData

		@Get current chapter
		mov		r0, #0x0E
		ldsb	r0, [r4,r0]
		ldr		r1, =GetChapterEventDataPointer
		mov		lr, r1
		.short	0xF800
		ldr		r5, [r0] @pointers to each turn event in this chapter
		
		LoopThroughTurnBasedEvents:
		ldr		r0, [r5]
		cmp		r0, #0 @No more turn events
		beq		End
		
			@Check Event ID to see if event can still happen
			ldrh	r0, [r5,#2]
			ldr		r1, =CheckEventID
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			bne		GetAnotherTurnEvent
			
				ldrh	r2, [r4,#0x10] @current turn
				
				@Check what phase this event is; if it's player phase, add 1 to the turn
				ldrh	r0, [r5,#10]
				cmp		r0, #0
				bne		CheckTurnEventTurns
				
					add		r2, #1
				
				CheckTurnEventTurns:
				ldrb	r0, [r5,#8]
				ldrb	r1, [r5,#9] @last turn (0x00 if event only plays for a single turn, 0xFF if it never stops)
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
					cmp		r2, r1
					bgt		GetAnotherTurnEvent
					
						@Events with SVAL s0 0 or SVAL s0 1 don't count
						ldr		r0, [r5,#4]
						ldr		r1, =FutureIsTurnEventEligible
						mov		lr, r1
						.short	0xF800
						cmp		r0, #0
						beq		GetAnotherTurnEvent
						
							b		End
		
		GetAnotherTurnEvent:
		add		r5, #0x0C
		b		LoopThroughTurnBasedEvents
		
		End:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

