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
		
		@Fade to black for a moment
		@ldr		r0, =CallMapEventEngine		@event engine thingy
		@mov		lr, r0
		@ldr		r0, =ActResetMapEvent
		@mov		r1, #0x01		@0x01 = wait for events
		@.short	0xF800
		
		@Update visual display
		ldr		r0, =EndBMAPMAIN
		mov		lr, r0
		.short	0xF800
		ldr		r0, =gProcStatePool
		
		@ldr		r1, =GameControl_8030FE4
		@mov		lr, r1
		@.short	0xF800
		
		ldr		r1, =StartMapMain
		mov		lr, r1
		.short	0xF800
		
		ldr		r0, =gProc_MapMain
		mov		r1, #2
		ldr		r2, =ProcStart
		mov		lr, r2
		.short	0xF800
		ldr		r1, =MapMain_ResumeFromPhaseIdle
		mov		lr, r1
		.short	0xF800
		
		@Update visual display
		@ldr		r0, =RefreshEntityMaps
		@mov		lr, r0
		@.short	0xF800
		@ldr		r0, =SMS_UpdateFromGameData
		@mov		lr, r0
		@.short	0xF800

		pop		{r0}
		bx		r0
		
		.align
		.ltorg
		
		
