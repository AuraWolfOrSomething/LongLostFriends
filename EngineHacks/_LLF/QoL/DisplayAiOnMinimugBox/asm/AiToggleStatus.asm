.thumb

.include "../DisplayAiOnMinimugBoxDefs.s"

.global AiToggleStatus
.type AiToggleStatus, %function


		AiToggleStatus:
		push	{r14}
		ldr		r0, =AiToggleEventIDLink
		ldrh	r0, [r0]
		ldr		r1, =CheckEventID
		mov		lr, r1
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

