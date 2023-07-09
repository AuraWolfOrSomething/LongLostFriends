.thumb

.include "../SlowDefs.s"

.global SlowTargetChange
.type SlowTargetChange, %function


		SlowTargetChange:
		push	{r4,r14}
		mov		r4, r1
		
		mov		r0, #0
		ldsb	r0, [r4,r0]
		mov		r1, #1
		ldsb	r1, [r4,r1]
		ldr		r2, =ChangeActiveUnitFacing
		mov		lr, r2
		.short	0xF800
		
		ldrb	r0, [r4,#2]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		ldr		r1, =SetupSlowTargetWindow
		mov		lr, r1
		.short	0xF800
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

