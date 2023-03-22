.thumb

.global GetUnitSelectionValueThingExtension
.type GetUnitSelectionValueThingExtension, %function


		GetUnitSelectionValueThingExtension:
		
		IsCharOrClassUnselectable: @0801D570
		ldr		r0, [r4]
		ldr		r1, [r4,#4]
		ldr		r0, [r0,#0x28]
		ldr		r1, [r1,#0x28]
		orr		r0, r1
		mov		r1, #0x80
		lsl		r1, #0x0D
		tst		r0, r1
		bne		GrayedOutOrUnselectable
		
		CheckPlanUsability:
		@check if map menu command "Plan" is usable
			@if not, skip grayed out check and allegiance check
		ldr		r0, =MM_PlanUsability
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		bne		StatusEffectCheck
		
			ldr		r0, [r4,#0x0C]
			mov		r1, #2
			tst		r0, r1
			beq		AllegianceCheck
			
				GrayedOutOrUnselectable: @0801D584
				mov		r0, #1
				b		End
		
			AllegianceCheck: @0801D55A
			ldrb	r0, [r4,#0x0B]
			lsr		r0, #6
			cmp		r0, #0
			bne		NotPlayerUnitOrUnderStatus
		
		StatusEffectCheck: @0801D588
		mov		r0, #0x30
		ldrb	r0, [r4,r0]
		mov		r1, #0x0F
		and		r1, r0
		cmp		r1, #2
		beq		NotPlayerUnitOrUnderStatus
		
			cmp		r1, #4
			beq		NotPlayerUnitOrUnderStatus
		
		SelectableUnit: @0801D59A
		mov		r0, #2
		b		End
		
		NotPlayerUnitOrUnderStatus: @0801D59E
		mov		r0, #3
		
		End: @0801D5A0
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


