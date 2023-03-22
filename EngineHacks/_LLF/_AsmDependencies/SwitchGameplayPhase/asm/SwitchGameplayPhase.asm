.thumb

.equ origin, 0x0801538C
.include "../SwitchGameplayPhaseDefs.s"

.global SwitchGameplayPhase
.type SwitchGameplayPhase, %function


		SwitchGameplayPhase:
		push	{r4,r14}
		ldr		r4, =gChapterData
		ldrb	r0, [r4,#0x0F]
		
		GetNextPhase:
		ldr		r2, =GetNextFactionPhase
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0
		bne		SameTurn
		
			ldr		r0, =PhaseOrder @go back to the beginning for initial phase
			ldrh	r1, [r4,#0x10]
			ldr		r2, =TurnLimit
			cmp		r1, r2
			bhi		SameTurn
			
					@Increment turncount
					add		r1, #1
					strh	r1, [r4,#0x10]
		
		SameTurn:
		ldrb	r1, [r0]
		strb	r1, [r4,#0x0F]
		ldr		r0, [r0,#4]
		cmp		r0, #0
		beq		End
		
			bl		bl_BXR0
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

