.thumb

.include "../AiDefinitions.s"

.global AiTargetExceptionCheck
.type AiTargetExceptionCheck, %function


		AiTargetExceptionCheck:
		push	{r4,r14}
		ldr		r0, [r0]
		ldrb	r0, [r0,#4] @character id
		mov		r4, r1
		ldr		r3, =AiTargetExceptionList
		ldr		r2, =ChapterDataStruct
		ldrb	r2, [r2,#0x0E] @chapter id
		
		@check for matching target ID and chapter ID
		  @if not found, valid target
		  @if found, go to assigned conditional routine and return its returned value
		LoopThroughExceptionList:
		ldrb	r1, [r3]
		cmp		r1, #0
		beq		ValidTarget
		
			cmp		r1, r0 @check entry unit ID
			bne		GoToNextExceptionEntry
		
				ldrb	r1, [r3,#1] @check entry chapter ID
				cmp		r1, r2
				bne		GoToNextExceptionEntry
		
					mov		r0, r4
					ldr		r3, [r3,#4]
					mov		lr, r3
					.short	0xF800
					b		CheckAiWhatResultIsValidTargetList
		
			GoToNextExceptionEntry:
			add		r3, #8
			b		LoopThroughExceptionList
		
		ValidTarget:
		mov		r0, #1
		
		CheckAiWhatResultIsValidTargetList:
		ldr		r3, =AiWhatResultIsValidTargetList
		
		LoopThroughResultList:
		ldr		r1, [r3]
		cmp		r1, #0 @if end of list reached, assume return value of 1 = valid target
		beq		End
		
			cmp		r1, r4
			beq		EditReturnIfNeeded
		
				add		r3, #8
				b		LoopThroughResultList
		
		@if 1 = valid target, skip
		@if 0 = valid target, check returning value
		  @if 0, return 1 instead
		  @if 1, return 0 instead
		EditReturnIfNeeded:
		ldrb	r1, [r3,#4]
		cmp		r1, #1
		beq		End
		
			cmp		r0, #1
			beq		ReturnZero
		
				mov		r0, #1
				b		End
		
			ReturnZero:
			mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

