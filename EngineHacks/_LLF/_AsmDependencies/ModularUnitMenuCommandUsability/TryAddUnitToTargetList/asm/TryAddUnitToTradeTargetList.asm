.thumb

.equ origin, 0x0802521C
.include "../TryAddUnitToTargetListDefs.s"

.global TryAddUnitToTradeTargetList
.type TryAddUnitToTradeTargetList, %function


		TryAddUnitToTradeTargetList:
		push	{r4-r7,r14}
		mov		r4, r0 @target unit
		ldrb	r0, [r0,#0x0B]
		ldr		r1, =gUnitSubject
		ldr		r1, [r1]
		ldrb	r1, [r1,#0x0B]
		bl		bl_AreAllegiancesEqual
		cmp		r0, #0
		bne		GoToTryAddUnitToTargetList
		
			@Allow trading with a captured unit traveling with active unit
			ldrb	r1, [r4,#0x13]
			cmp		r1, #0
			beq		GoToTryAddUnitToTargetList
		
				ldr		r5, =gChapterData
				ldrh	r5, [r5,#0x0E] @chapter id
				ldr		r6, [r4]
				ldrb	r6, [r6,#4] @char id
				ldr		r7, =TradeTargetExceptionsList
				
				LoopThroughList:
				ldr		r0, [r7]
				cmp		r0, #0
				beq		End
					
					ldrh	r0, [r7]
					cmp		r0, r5
					bne		NextEntry
					
						ldrb	r0, [r7,#2]
						cmp		r0, r6
						beq		EntryFound
						
							NextEntry:
							add		r7, #8
							b		LoopThroughList
							
				EntryFound:
				ldr		r0, [r7,#4]
				cmp		r0, #0
				beq		GoToTryAddUnitToTargetList
				
					mov		lr, r0
					mov		r0, r4
					.short	0xF800
					cmp		r0, #0
					beq		End
		
		GoToTryAddUnitToTargetList:
		mov		r0, r4
		ldr		r1, =TradeTargetConditionsList
		ldr		r2, =TryAddUnitToTargetList
		mov		lr, r2
		.short	0xF800
		
		@Attempt to add traveling unit to target list, if any
		ldr		r0, [r4,#0x0C]
		mov		r1, #0x10
		tst		r0, r1
		beq		End
		
			ldrb	r0, [r4,#0x1B]
			bl		bl_GetUnit
			ldr		r1, =TradeTargetRescueeConditionsList
			ldr		r2, =TryAddUnitToTargetList
			mov		lr, r2
			.short	0xF800
			
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

