.thumb

.equ GetUnit, 0x08019430

.global LowerLearningRingUse
.type LowerLearningRingUse, %function


		LowerLearningRingUse:
		push	{r4-r7,r14}
		mov		r4, r0
		ldrb	r0, [r4,#0x0B]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		mov		r5, r0
		ldr		r6, =LearningRingIDLink
		ldrb	r6, [r6]
		mov		r7, #0
		
		LoopThroughInventory:
		lsl		r0, r7, #1
		add		r0, #0x1E
		ldrb	r1, [r4,r0]
		cmp		r1, #0
		beq		End
		
			cmp		r1, r6
			bne		NextItem

				@Lower current uses by 1 if not at 0
				add		r0, #1
				ldrb	r1, [r4,r0]
				lsl		r2, r1, #0x1C
				lsr		r2, #0x1C
				cmp		r2, #0
				beq		NextItem
				
					sub		r2, #1
				
					@Progress stat cycle
					lsr		r1, #4
					add		r1, #1
					
					ldr		r3, =LearningRingCycle
					ldrb	r3, [r3,r1]
					cmp		r3, #0xFF
					bne		StoreStatChangeOnLearningRing
					
						mov		r1, #0
					
					StoreStatChangeOnLearningRing:
					lsl		r1, #4
					add		r2, r1
					strb	r2, [r4,r0]
			
					@update unit early (if learning ring activates from stealing with full inventory, uses reset (would also happen for anything else that would call InitBattleUnitFromUnit after use is subtracted)
					strb	r2, [r5,r0]
					
					NextItem:
					add		r7, #1
					cmp		r7, #4
					ble		LoopThroughInventory
					
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

