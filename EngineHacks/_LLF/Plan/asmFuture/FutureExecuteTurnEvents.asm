.thumb

.include "../PlanDefs.s"

.global FutureExecuteTurnEvents
.type FutureExecuteTurnEvents, %function


		FutureExecuteTurnEvents:
		push	{r4-r6,r14}
		add		sp, #-8
		mov		r4, r0
		ldr		r5, [r4,#0x30]
		cmp		r5, #0
		bne		ContinueSettingUp
		
			@Break out of While Loop
			mov		r0, #0
			b		End
			
		ContinueSettingUp:
		mov		r6, #0x2A @number of "visible" turn events
		mov		r0, #0
		str		r0, [sp,#4] @parent proc to block during popup (I'll mess with this later)
		
		@Set event's event id to on
		ldrh	r0, [r5,#2]
		ldr		r1, =SetEventID
		mov		lr, r1
		.short	0xF800
		
		@SVAL
		mov		r2, #5
		lsl		r2, #8
		add		r2, #0x40
		
		@If first opcode in event isn't SVAL s0, skip checking the rest of the opcode
		ldr		r0, [r5,#4]
		ldr		r1, [r0]
		cmp		r1, r2
		bne		VisibleEvent
		
			@SVAL s0 0: Do not play event
			ldr		r0, [r0,#4]
			cmp		r0, #0
			beq		RemoveEventFromQueue
		
				@SVAL s0 1: Do not display turn number popup due to this event or count as a visible event
				cmp		r0, #1
				beq		GoToCallMapEventEngine
				
					@SVAL s0 2: Do not display turn number popup due to this event, but count this as a visible event
					cmp		r0, #2
					bne		VisibleEvent
					
						ldrb	r0, [r4,r6]
						add		r0, #1
						strb	r0, [r4,r6]
						b		GoToCallMapEventEngine
		
		VisibleEvent:
		ldrb	r0, [r4,r6]
		add		r0, #1
		strb	r0, [r4,r6]
		
		@only have turn number popup appear once per turn (enemy/npc + player)
		ldr		r0, =gChapterData
		ldrh	r0, [r0,#0x10] @current turn
		ldrh	r1, [r4,#0x2C] @turn number on last popup
		cmp		r0, r1
		beq		GoToCallMapEventEngine
			
			strh	r0, [r4,#0x2C]
			ldr		r1, =gPopupNumber
			str		r0, [r1]
			mov		r0, #4
			str		r0, [sp]
			
			ldr		r0, =Popup_CreateExt
			mov		lr, r0
			ldr		r0, =FutureNewTurnPopup @pDefinition
			mov		r1, #30 @time
			mov		r2, #1 @styleId
			mov		r3, #90
			lsl		r3, #2
			.short	0xF800
			
			@until I learn how to properly make the game wait for the popup to disappear, we're doing this
			ldr		r0, =FutureNewTurnPauseEvent
			mov		r1, #1
			ldr		r2, =CallMapEventEngine
			mov		lr, r2
			.short	0xF800

		GoToCallMapEventEngine:
		ldr		r0, [r5,#4]
		mov		r1, #1
		ldr		r2, =CallMapEventEngine
		mov		lr, r2
		.short	0xF800

		RemoveEventFromQueue:
		mov		r0, #0
		mov		r2, #0x30
		str		r0, [r4,r2]
		
		@Move the next events up
		mov		r1, #0x2C
		mov		r3, #MaxNumberOfTurnEventsToPlayForFaction
		lsl		r3, #2
		add		r3, r1
		
		AdjustEventQueueLoop:
		cmp		r2, r3
		bgt		StayInWhileLoop @failsafe (shouldn't happen but just in case
		
			cmp		r2, r3
			blt		MoveNextEventUp
			
				mov		r0, #0
				b		StoreEventToNextPosition
			
			MoveNextEventUp:
			add		r1, r2, #4
			ldr		r0, [r4,r1]
			
			StoreEventToNextPosition:
			str		r0, [r4,r2]
			add		r2, #4
			cmp		r0, #0
			bne		AdjustEventQueueLoop
		
		StayInWhileLoop:
		mov		r0, #1
		
		End:
		add		sp, #8
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

