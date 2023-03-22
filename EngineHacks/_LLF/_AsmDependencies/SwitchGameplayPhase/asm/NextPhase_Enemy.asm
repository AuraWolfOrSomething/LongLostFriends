.thumb

.equ origin, 0
.include "../SwitchGameplayPhaseDefs.s"

.global NextPhase_Enemy
.type NextPhase_Enemy, %function


		NextPhase_Enemy:
		push	{r14}
		
		ldr		r0, =RandomizeRnsEventIDLink
		ldrh	r0, [r0]
		ldr		r1, =UnsetEventId
		mov		lr, r1
		.short	0xF800
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

