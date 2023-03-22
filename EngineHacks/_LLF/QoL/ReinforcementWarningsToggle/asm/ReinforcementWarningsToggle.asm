.thumb

.include "../ReinforcementWarningsToggleDefs.s"

.global ReinforcementWarningsToggle
.type ReinforcementWarningsToggle, %function


		ReinforcementWarningsToggle:
		push	{r4,r14}
		ldr		r4, =ReinforcementWarningsToggleEventIDLink
		
		@If warnings are off, turn them on
		  @Otherwise, if they're on, turn them off
		ldr		r0, =ReinforcementWarningsStatus
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		beq		TurnDisplayOff

			ldr		r1, =SetEventID
			b		ChangeDisplay
		
		TurnDisplayOff:
		ldr		r1, =UnsetEventID
		
		ChangeDisplay:
		ldrb	r0, [r4]
		mov		lr, r1
		.short	0xF800
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

