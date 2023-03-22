.thumb

.include "../CaptivesDefs.s"

.global GetCurrentCaptiveAmount
.type GetCurrentCaptiveAmount, %function

@r4 = captive counter
@r5 = loop variable
@r6 = pointer to captives in current chapter


		GetCurrentCaptiveAmount:
		push	{r4-r6,r14}
		ldr		r3, =GetChapterCaptiveListEntry
		mov		lr, r3
		.short	0xF800
		ldr		r6, [r0,#4] @ids that count as being captives
		mov		r4, #0
		mov		r5, #0
		ldr		r2, =gUnitArray
		
		NewUnit:
		ldrb	r0, [r2,#0x1B]
		mov		r1, #0x80
		tst		r0, r1
		beq		CheckIfMoreUnits
		
			sub		r0, #0x81
			lsl		r1, r0, #6
			lsl		r0, #3
			add		r0, r1
			ldr		r1, =gUnitArrayEnemyFaction
			add		r0, r1
			ldr		r0, [r0]
			ldrb	r0, [r0,#4]
			mov		r3, r6
		
			CheckIfCaptive:
			ldrb	r1, [r3]
			cmp		r1, #0 @if end of list is reached, not a captive
			beq		CheckIfMoreUnits
			
				cmp		r1, r0
				beq		AddToCounter
			
					add		r3, #6
					b		CheckIfCaptive

			AddToCounter:
			ldrb	r0, [r3,#1] @worth
			add		r4, r0 @add worth to counter

			CheckIfMoreUnits:
			add 	r5, #1
			cmp 	r5, #0x3E
			bge 	End
		
				add 	r2, #0x48
				b 		NewUnit
		
		End:
		mov		r0, r4
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

