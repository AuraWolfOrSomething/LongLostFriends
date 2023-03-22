.thumb

.include "../PlanDefs.s"

.global ActResetUnitPositions
.type ActResetUnitPositions, %function


		ActResetUnitPositions:
		push	{r14}
		
		@Give audio cue feedback
		mov		r0, #0x6B
		ldr		r1, =m4aSongNumStart
		mov		lr, r1
		.short	0xF800
		
		@Reset to before planning
		mov		r0, #3
		ldr		r1, =LoadSuspendedGame
		mov		lr, r1
		.short	0xF800
		
		@Update visual display
		ldr		r0, =EndBMAPMAIN
		mov		lr, r0
		.short	0xF800
		ldr		r0, =gProcStatePool
		ldr		r1, =GameControl_8030FE4
		mov		lr, r1
		.short	0xF800

		pop		{r0}
		bx		r0
		
		.align
		.ltorg
		
		
