.thumb

.include "../CheckBeforeMiscEventsDefs.s"

.global Ch3_IsWallAt35HP
.type Ch3_IsWallAt35HP, %function


		Ch3_IsWallAt35HP:
		push	{r4,r14}
		
		@if not Chapter 3, skip
		ldr		r0, =gChapterData
		ldrb	r0, [r0,#0x0E]
		cmp		r0, #3
		bne		End
		
			@if event ID is already set, skip
			ldr		r4, =Ch3WallReached35HPEventIDLink
			ldrh	r0, [r4]
			ldr		r1, =CheckEventID
			mov		lr, r1
			.short	0xF800
			cmp		r0, #1
			beq		End
			
				@check wall HP
				ldr		r2, =Ch3Wall
				ldr		r3, =gTrapArray
				
				LoopThroughArray:
				ldr		r0, [r3]
				cmp		r0, #0
				beq		End
				
					ldrh	r0, [r2]
					ldrh	r1, [r3]
					cmp		r0, r1
					bne		NextTrap
					
						ldrb	r0, [r3,#3]
						cmp		r0, #35
						ble		GoToSetEventID
						
							b		End
					
					NextTrap:
					add		r3, #4
					b		LoopThroughArray
				
		GoToSetEventID:
		ldrh	r0, [r4]
		ldr		r1, =SetEventID
		mov		lr, r1
		.short	0xF800
				
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


