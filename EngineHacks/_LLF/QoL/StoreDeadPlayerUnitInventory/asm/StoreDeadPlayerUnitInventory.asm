.thumb

.include "../StoreDeadPlayerUnitInventoryDefs.s"

.global StoreDeadPlayerUnitInventory
.type StoreDeadPlayerUnitInventory, %function


		StoreDeadPlayerUnitInventory:
		push	{r4-r7,r14}
		
		@check if initiating unit is dead
		ldrb	r0, [r4,#0x13]
		cmp		r0, #0
		bne		CheckDefender
		
			@team check
			ldrb	r0, [r4,#0x0B]
			lsr		r0, #6
			cmp		r0, #0
			bne		CheckDefender
			
				mov		r6, r4
				b		CheckExceptions
		
		CheckDefender:
		ldrb	r0, [r5,#0x13]
		cmp		r0, #0
		bne		End
		
			@team check
			ldrb	r0, [r4,#0x0B]
			lsr		r0, #6
			cmp		r0, #0
			bne		End
			
				mov		r6, r5
				
		CheckExceptions:
		ldr		r7, =StoreDeadPlayerUnitInventoryExceptionList
		
		LoopThroughExceptionList:
		ldr		r1, [r7]
		cmp		r1, #0
		beq		CheckConvoySpace
		
			mov		r0, r6
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			bne		End
			
				add		r7, #4
				b		LoopThroughExceptionList
		
		CheckConvoySpace:
		ldr		r0, =ConvoySizePointer
		ldrb	r4, [r0]
		ldr		r0, =ConvoyPointer
		ldr		r5, [r0]
		sub		r5, #2
		add		r4, #2
		
		NextEmptySupplySlot:
		cmp		r4, #0
		beq		End @if no more space, then skip the rest of routine
		
			sub		r4, #1
			add		r5, #2
			ldrh	r1, [r5]
			cmp		r1, #0
			bne		NextEmptySupplySlot
		
			@Empty spot found
			add		r6, #0x1E
			mov		r2, #0
				
			StoreInConvoyLoop:
			lsl		r1, r2, #1
			ldrh	r0, [r6,r1]
			cmp		r0, #0
			beq		End
				
				strh	r0, [r5]
				add		r5, #2
				sub		r4, #1
				cmp		r4, #0
				beq		End
					
					add		r2, #1
					cmp		r2, #5
					blt		StoreInConvoyLoop
					
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		
		.align
		.ltorg

