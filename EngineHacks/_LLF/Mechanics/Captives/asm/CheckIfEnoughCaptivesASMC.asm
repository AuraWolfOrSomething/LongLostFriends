.thumb

.include "../CaptivesDefs.s"

.global CheckIfEnoughCaptivesASMC
.type CheckIfEnoughCaptivesASMC, %function


		CheckIfEnoughCaptivesASMC:
		push	{r14}
		ldr		r3, =CheckIfEnoughCaptives
		mov		lr, r3
		.short	0xF800
		ldr		r1, =gEventSlotC
		str		r0, [r1]
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

