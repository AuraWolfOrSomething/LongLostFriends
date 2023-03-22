.thumb

.include "../CaptivesDefs.s"

.global GameOverCaptiveCheckASMC
.type GameOverCaptiveCheckASMC, %function

@in gameplay, enemies can:
@1) be left alone (fine)
@2) be captured (fine)
@3) be captured, then dropped (not fine)
@4) be killed (not fine)
@5) escape the map (not fine)
@if the sum of 1 & 2 is not enough to complete the chapter's captive objective, call gameover event

		GameOverCaptiveCheckASMC:
		push	{r4-r5,r14}
		ldr		r3, =GetRequiredCaptiveAmount
		mov		lr, r3
		.short	0xF800
		mov		r4, r0
		ldr		r3, =GetCurrentCaptiveAmount
		mov		lr, r3
		.short	0xF800
		mov		r5, r0
		ldr		r3, =GetPossibleCaptiveAmount
		mov		lr, r3
		.short	0xF800
		add		r0, r5
		cmp		r0, r4
		bge		End
		
			ldr		r3, =StartGameOverEvent
			mov		lr, r3
			.short	0xF800
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

