.thumb

.global ShouldPlayerPhaseEnd
.type ShouldPlayerPhaseEnd, %function


		ShouldPlayerPhaseEnd:
		push	{r14}

		@if the option "auto turn end" is off, don't end
		mov		r2, r1
		add		r2, #0x41
		ldrb	r2, [r2]
		lsl		r2, #0x19
		cmp		r2, #0
		blt		PhaseContinue
		
		@check player unit count
		  @if 1 or more, don't end
		mov		lr, r0
		ldrb	r0, [r1,#0x0F]
		.short	0xF800
		cmp		r0, #0
		bne		PhaseContinue

		@check if map menu command "Plan" is usable (normal gameplay)
			@if not, don't end
		ldr		r0, =MM_PlanUsability
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		bne		PhaseContinue
		
		@Player phase ends
		mov		r0, #1
		b		End
		
		PhaseContinue:
		mov		r0, #0
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


