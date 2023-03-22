.thumb

.global PrepScreenMapMenuCommandColor
.type PrepScreenMapMenuCommandColor, %function


		PrepScreenMapMenuCommandColor:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, #0 @color
		ldr		r0, [r0,#0x34] @text ID
		ldr		r3, =PrepScreenMapMenuList
		
		LoopThroughFirstList:
		@if not found (end of the list), return r5
		ldr		r1, [r3,#4]
		cmp		r1, #0
		beq		ReturnR5
		
			ldrh	r1, [r3,#8]
			cmp		r0, r1
			beq		CheckForColorConditionalRoutine
			
				add		r3, #0x10
				b		LoopThroughFirstList
			
		CheckForColorConditionalRoutine:
		ldrb	r5, [r3,#0x0E] @color to use if no entry on second list
		ldr		r6, =PrepScreenMapMenuColorConditionalList
				
		LoopThroughSecondList:
		@if not found (end of the list), return r5
		ldr		r1, [r6]
		cmp		r1, #0
		beq		ReturnR5
		
			cmp		r0, r1
			beq		GoToContionalRoutine
			
				add		r6, #8
				b		LoopThroughSecondList
				
		GoToContionalRoutine:
		ldr		r0, [r6,#4]
		mov		lr, r0
		.short	0xF800
		b		End
		
		ReturnR5:
		mov		r0, r5
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

