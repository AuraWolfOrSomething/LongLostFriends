.thumb

.include "../PlanDefs.s"

.global MM_SuspendUsability
.type MM_SuspendUsability, %function


		MM_SuspendUsability:
		push	{r14}
		ldr		r0, =gChapterData
		ldrb	r1, [r0,#0x14]
		mov		r0, #8
		tst		r0, r1
		bne		NoSuspend_Tutorial
		
			@check if map menu command "Plan" is usable
			  @if not, don't allow this
			ldr		r0, =MM_PlanUsability
			mov		lr, r0
			.short	0xF800
			cmp		r0, #1
			bne		NoSuspend

				b		End
		
		NoSuspend_Tutorial:
		mov		r0, #2
		b		End
		
		NoSuspend:
		mov		r0, #3
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


