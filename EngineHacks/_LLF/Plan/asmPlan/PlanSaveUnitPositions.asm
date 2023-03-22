.thumb

.include "../PlanDefs.s"

.global PlanSaveUnitPositions
.type PlanSaveUnitPositions, %function


		PlanSaveUnitPositions:
		push	{r14}
		
		@Give audio cue feedback
		mov		r0, #0x6A
		ldr		r1, =m4aSongNumStart
		mov		lr, r1
		.short	0xF800
		
		@Save to suspend data
		ldr		r0, =PlayerPhase_Suspend
		mov		lr, r0
		.short	0xF800
		
		@Set event ID
		ldr		r0, =PlanEventIDLink
		ldrh	r0, [r0]
		ldr		r1, =SetEventID
		mov		lr, r1
		.short	0xF800
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

