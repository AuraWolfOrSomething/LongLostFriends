.thumb

.include "../DistractDefs.s"

.global DistractTargetSelection_OnSelect
.type DistractTargetSelection_OnSelect, %function


		DistractTargetSelection_OnSelect:
		push	{r4,r14}
		
		@Player has chosen a target
		mov		r4, r1
		ldr		r1, =EndTargetSelection
		mov		lr, r1
		.short	0xF800
		
		@Next part: allowing player to choose where target goes
		ldr		r1, =gActionData
		ldrb	r0, [r4,#2]
		strb	r0, [r1,#0x0D]
		ldr		r0, =gProc_DistractTargetPosSelection
		mov		r1, #3
		ldr		r2, =ProcStart
		mov		lr, r2
		.short	0xF800
		mov		r0, #4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

