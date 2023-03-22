.thumb

.equ origin, 0x08028290
.include "../SupportPointEarningDefs.s"

.global AddSupportPoints
.type AddSupportPoints, %function


		AddSupportPoints:
		push	{r4-r7,r14}
		
		@ProcessSupportGains, which calls this, already does this check
		@mov		r2, r0
		@ldr		r0, [r2]
		@ldr		r0, [r0,#0x2C]
		@cmp		r0, #0 @if no support list pointer, skip
		@beq		End
		
		@add		r0, #0x0E
		@add		r0, r1
		@ldrb	r6, [r0] @pair's support point rate
		
		ldr		r3, [r0]
		ldr		r3, [r3,#0x2C]
		add		r3, r1
		add		r3, #0x0E
		ldrb	r6, [r3] @pair's support point rate
		
		@if both units are deployed, multiply support point rate by 2
		@if both unit are undeployed, multiply support point rate by 1.5
		mov		r4, r6
		lsr		r4, r2
		add		r6, r4
		add		r7, r0, r1
		add		r7, #0x32
		
		ldrb	r5, [r7] @current support points
		ldr		r4, =gSupportConvoReadyValueList
		bl		bl_GetSupportLevelBySupportIndex
		
		@make sure new total doesn't skip convo and immediately go to next rank
		lsl		r0, #2
		ldr		r1, [r4,r0]
		add		r0, r5, r6
		cmp		r0, r1
		ble		StoreNewSupportTotal
		
			sub		r6, r1, r5
		
		StoreNewSupportTotal:
		add		r0, r5, r6
		strb	r0, [r7]
		
		@Since ProcessSupportGains is at the end of the chapter instead of from Turn 2 and after, I don't think I need this
		@ldr		r1, =gChapterData
		@ldrh	r0, [r1,#0x16]
		@add		r0, r6
		@strh	r0, [r1,#0x16]

		End: @080282CC
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

