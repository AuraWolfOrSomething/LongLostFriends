.thumb

.include "../ToggleDeploymentSwappingDefs.s"

.global CheckIfLockedPosition
.type CheckIfLockedPosition, %function


		CheckIfLockedPosition:
		push	{r4-r5,r14}
		mov		r4, r0
		ldr		r3, =CheckGameLinkArenaBit
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		bne		NotForced
		
			ldr		r3, =GetBattleMapType
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			bne		NotForced

				mov		r0, r4
				ldr		r2, =ForcedDeploymentList
				ldr		r3, =gChapterData
				
				@ForcedDeploymentList terminator
				mov		r5, #0xFF
				lsl		r5, #8
				add		r5, #0xFF
				b		CheckIfEndOfList
		
		CheckMode:
		ldrb	r0, [r2,#2]
		cmp		r0, #0xFF @if any mode, then don't check current mode
		beq		CheckChapter
		
		ldrb	r1, [r3,#0x1B]
		cmp		r0, r1
		bne		CheckNextEntry
		
			CheckChapter:
			ldrb	r0, [r2,#3]
			cmp		r0, #0xFF @if all chapter ids, then don't check current chapter
			beq		CheckCharacter
		
			mov		r1, #0x0E
			ldsb	r1, [r3,r1]
			cmp		r0, r1
			bne		CheckNextEntry
		
				CheckCharacter:
				ldrh	r0, [r2]
				cmp		r4, r0 @if character matches, they're forced into their position; otherwise, check next entry (if there is one)
				bne		CheckNextEntry
				
					mov		r0, #1
					b		End
					
				CheckNextEntry:
				add		r2, #4
		
				CheckIfEndOfList:
				ldrh	r0, [r2]
				cmp		r0, r5
				bne		CheckMode
		
		NotForced:
		mov		r0, #0
		
		End:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		
		.align
		.ltorg

