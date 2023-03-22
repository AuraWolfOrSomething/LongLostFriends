.thumb

.equ origin, 0
.include "../SwitchGameplayPhaseDefs.s"

.global NextPhase_Player
.type NextPhase_Player, %function


		NextPhase_Player:
		push	{r14}
		
		@ldr		r0, =RandomizeRnsEventIDLink
		@ldrh	r0, [r0]
		@ldr		r1, =SetEventId
		@mov		lr, r1
		@.short	0xF800
		
		@if Turn 1, set rn used counter 0
		@ldr		r1, =gChapterData
		@ldrh	r0, [r1,#0x10]
		@cmp		r0, #1
		@bne		End
		
			@ldr		r1, =AfterPlaythroughStatsRAM
			@mov		r0, #0
			@str		r0, [r1]
		
		ldr		r2, =gChapterData
		ldr		r0, =TurnLimit
		ldrh	r1, [r2,#0x10]
		cmp		r1, r0
		bhi		End
		
				@Increment turncount
				add		r0, r1, #1
				strh	r0, [r2,#0x10]
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

