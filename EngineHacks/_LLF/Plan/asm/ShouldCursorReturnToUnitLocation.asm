.thumb

.global ShouldCursorReturnToUnitLocation
.type ShouldCursorReturnToUnitLocation, %function


		ShouldCursorReturnToUnitLocation:
		push	{r4,r14}
		mov		r4, r2
		
		@do stuff that was overwritten
		and		r0, r1
		str		r0, [r2,#0x0C]
		
		@check if map menu command "Plan" is usable
			@if not (planning is on), always return cursor position to unit
		ldr		r0, =MM_PlanUsability
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		bne		PlaceCursorAtUnit
		
			@during normal gameplay, only place the cursor at unit location if unit is in player faction
			mov		r0, #0x0B
			ldsb	r0, [r4,r0]
			lsr		r0, #6
			b		End
		
		PlaceCursorAtUnit:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


