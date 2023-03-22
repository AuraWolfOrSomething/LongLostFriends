.thumb

.equ CheckEventId, 0x08083DA8

.global McVicarProgressTracking
.type McVicarProgressTracking, %function


		McVicarProgressTracking:
		push	{r4-r6,r14}
		mov		r4, #0 @current progress
		ldr		r5, =McVicarImpressionEventIDList
		ldr		r6, =CheckEventId
		
		LoopThroughList:
		ldrh	r0, [r5]
		cmp		r0, #0
		beq		End
		
			add		r5, #2
			mov		lr, r6
			.short	0xF800
			cmp		r0, #0
			beq		LoopThroughList
			
				add		r4, #1
				b		LoopThroughList
		
		End:
		mov		r0, r4
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

