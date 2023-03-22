.thumb

.include "../CaptivesDefs.s"

.global CheckIfCaptiveDropped
.type CheckIfCaptiveDropped, %function


		CheckIfCaptiveDropped:
		push	{r14}
		ldr		r3, =GetChapterCaptiveListEntry
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0 @if no chapter captive list, skip this
		beq		End
		
			ldr		r3, [r0,#4] @ids that count as being captives
			ldr		r0, [r5]
			ldrb	r0, [r0,#4]
		
			CheckIfCaptive:
			ldrb	r1, [r3]
			cmp		r1, #0 @if end of list is reached, not a captive
			beq		End
			
				cmp		r1, r0
				beq		ActivateAssignedEventId
			
					add		r3, #6
					b		CheckIfCaptive

		ActivateAssignedEventId:
		ldrh	r0, [r3,#2]
		ldr		r3, =SetEventId
		mov		lr, r3
		.short	0xF800
		
		End:
		pop		{r1}
		mov		r0, #0
		
		@end of vanilla routine overwritten by bxing here, so those pops go here
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

