.thumb

.include "../GemDefs.s"

.global CheckIfGemIsActive
.type CheckIfGemIsActive, %function

@r4 = unit
@r5 = gem id
@r6 = list of gems
@r7 = if gem is active

		CheckIfGemIsActive:
		push	{r4-r7,r14}
		add		sp, #-0x08
		mov		r4, r0
		mov		r5, r1
		mov		r6, r13
		mov		r7, #0
		
		mov		r1, r6
		ldr		r2, =PromotedLimitGemList
		ldr		r3, =StoreInventoryAtStackPointer
		mov		lr, r3
		.short	0xF800
		mov		r3, #0
		b		LoopThroughList
		
		PromotionCheck:
		@if first gem isn't the gem we're looking for, check if the unit is promoted
		  @if so, don't check any other gems in inventory
		  @if not, continue checking
		  
		ldr		r0, [r4,#4]
		ldr		r0, [r0,#0x28]
		mov		r1, #0x80
		lsl		r1, #1
		tst		r0, r1
		bne		End
		
		LoopThroughList:
		ldrb	r0, [r6,r3]
		cmp		r0, #0
		beq		End
	
			cmp		r0, r5
			beq		ReturnGemActive
	
				CheckNextGem:
				add		r3, #1
				cmp		r3, #1
				bne		LoopThroughList
				b		PromotionCheck
		
		ReturnGemActive:
		mov		r7, #1
		
		End:
		mov		r0, r7
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align

