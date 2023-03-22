.thumb

.equ gChapterData, 0x0202BCF0

.global CheckIfRecruitOrFatigue
.type CheckIfRecruitOrFatigue, %function


		CheckIfRecruitOrFatigue:
		cmp		r0, #0 @if no character, display Fatigue
		beq		End
		
			@If unit is already in player faction, display Fatigue
			ldrb	r1, [r0,#0x0B]
			lsr		r1, #6
			cmp		r1, #0
			beq		DisplayFatigue
		
				ldr		r1, [r0]
				ldrb	r1, [r1,#4] @character id
				ldr		r3, =DisplayRecruitmentInfoTextList
				ldr		r2, =gChapterData
				ldrb	r2, [r2,#0x0E] @chapter id
		
				LoopThroughList:
				ldrb	r0, [r3]
				cmp		r0, #0 @if 0, end of list reached; display Fatigue
				beq		End
				
					cmp		r0, r1 @if character doesn't match, check next entry
					bne		GoToNextEntry
				
						ldrb	r0, [r3,#1]
						cmp		r0, r2 @if chapter doesn't match, check next entry
						bne		GoToNextEntry
				
							@current unit and chapter match this entry; we already checked allegiance earlier, so display recruitment information
							mov		r0, r3
							b		End
				
							GoToNextEntry:
							add		r3, #6
							b		LoopThroughList
		
		DisplayFatigue:
		mov		r0, #0
		
		End:
		bx		r14

