.thumb

.include "CountUnitsDefs.s"

.global AsmcCountUnitsInArea
.type AsmcCountUnitsInArea, %function


		AsmcCountUnitsInArea:
		push	{r4-r7}
		ldr		r2, =gEventSlot1 @area to check (top left corner; gEventSlot2 is bottom right corner)
		mov		r4, #0 @number of units in area
		ldr		r5, =gEventSlot3
		ldrb	r5, [r5] @which allegiances to exclude
		mov		r6, #0 @number of factions checked
		
		@Check if player units are excluded
		mov		r0, #1
		tst		r0, r5
		bne		NpcCheck
		
			ldr		r3, =PlayerBaseOffset
			mov		r7, #50 @max number of units to check
			b		LoopThroughUnits
		
		NpcCheck:
		mov		r6, #1
		mov		r0, #2
		tst		r0, r5
		bne		EnemyCheck
		
			ldr		r3, =NPCBaseOffset
			mov		r7, #20 @max number of units to check
			b		LoopThroughUnits
		
		EnemyCheck:
		mov		r6, #2
		mov		r0, #4
		tst		r0, r5
		bne		StoreResult
		
			ldr		r3, =EnemyBaseOffset
			mov		r7, #50 @max number of units to check
			b		LoopThroughUnits
		
		LoopThroughUnits:
		add		r3, #0x48
		ldr		r0, [r3]
		cmp		r0, #0
		beq		NextUnit
		
			@Ignore dead/captured units
			ldrb	r0, [r3,#0x13]
			cmp		r0, #0
			beq		NextUnit
				
				@Check if x-coord is within area
				ldrb	r0, [r3,#0x10]
				ldrb	r1, [r2]
				cmp		r0, r1
				blt		NextUnit
				
				ldrb	r1, [r2,#4]
				cmp		r0, r1
				bgt		NextUnit
				
					@Check if y-coord is within area
					ldrb	r0, [r3,#0x11]
					ldrb	r1, [r2,#1]
					cmp		r0, r1
					blt		NextUnit
					
					ldrb	r1, [r2,#5]
					cmp		r0, r1
					bgt		NextUnit
						
						add		r4, #1
				
						NextUnit:
						sub		r7, #1
						cmp		r7, #0
						bgt		LoopThroughUnits
						
							cmp		r6, #0
							beq		NpcCheck
							
								cmp		r6, #1
								beq		EnemyCheck
		
		StoreResult:
		ldr		r1, =gEventSlotC
		str		r4, [r1]
		pop		{r4-r7}
		bx		r14
		
		.align
		.ltorg

