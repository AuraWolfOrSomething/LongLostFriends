.thumb

.include "../ReinforcementWarningsToggleDefs.s"

.global MapMenuReinWarnToggle
.type MapMenuReinWarnToggle, %function


		MapMenuReinWarnToggle:
		push	{r14}
		
		@Give audio cue feedback
		mov		r0, #0x6A
		ldr		r1, =m4aSongNumStart
		mov		lr, r1
		.short	0xF800
		
		ldr		r0, =ReinforcementWarningsToggle
		mov		lr, r0
		.short	0xF800
		mov		r0, #0x1B
		pop		{r1}
		bx		r1
		
		.align
		.ltorg
		

