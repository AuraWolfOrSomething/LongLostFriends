.thumb

.equ origin, 0
.include "../SwitchGameplayPhaseDefs.s"

.global NextPhase_NPC
.type NextPhase_NPC, %function


		NextPhase_NPC:
		push	{r14}
		
		@always skip NPC phase in Chapter 1
		ldr		r1, =gChapterData
		ldrb	r0, [r1,#0x0E]
		cmp		r0, #1
		bne		End
		
			@failsafe in case this messes with the first phase of gameplay? (during preps, phase is set to NPC phase)
			@ldrh	r0, [r1,#0x10]
			@cmp		r0, #0
			@beq		End
			
			ldr		r0, =SwitchGameplayPhase
			mov		lr, r0
			.short	0xF800
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

