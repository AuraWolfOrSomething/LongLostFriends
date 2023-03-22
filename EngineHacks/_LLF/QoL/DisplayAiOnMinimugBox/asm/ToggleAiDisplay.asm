.thumb

.include "../DisplayAiOnMinimugBoxDefs.s"

.global ToggleAiDisplay
.type ToggleAiDisplay, %function


		ToggleAiDisplay:
		push	{r4,r14}
		ldr		r4, =AiToggleEventIDLink
		
		@If AI display is off, turn it on
		  @Otherwise, if AI display is on, turn if off
		ldr		r0, =AiToggleStatus
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		beq		TurnDisplayOff

			ldr		r3, =SetEventID
			b		ChangeDisplay
		
		TurnDisplayOff:
		ldr		r3, =UnsetEventID
		
		ChangeDisplay:
		ldrb	r0, [r4]
		mov		lr, r3
		.short	0xF800
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

