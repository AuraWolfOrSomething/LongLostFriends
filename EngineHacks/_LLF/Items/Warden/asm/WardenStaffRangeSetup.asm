.thumb

.include "../WardenDefs.s"

.global WardenStaffRangeSetup
.type WardenStaffRangeSetup, %function


		WardenStaffRangeSetup:
		push	{r4,r14}
		mov		r4, r0
		
		mov		r0, #0
		mov		r1, #0
		ldr		r2, =InitTargets
		mov		lr, r2
		.short	0xF800
		
		@Try to add the staff user as target
		mov		r0, r4
		ldr		r1, =TryAddUnitToWardenTargetList
		mov		lr, r1
		.short	0xF800

		@If staff user counts as a target, skip to the end
		ldr		r0, =GetTargetListSize
		mov		lr, r0
		.short	0xF800
		cmp		r0, #0
		bne		End
		
			@If not, see if there is at least one target that would be added by being within aoe range (max range+aoe size)
			mov		r0, r4
			ldr		r1, =TryAddUnitToWardenTargetList
			ldr		r2, =WardenAoeEntry
			ldr		r3, =LookForUnitsInAoeRange
			mov		lr, r3
			.short	0xF800
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


