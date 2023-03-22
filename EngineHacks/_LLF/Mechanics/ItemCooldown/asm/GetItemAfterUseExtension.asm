.thumb

.global GetItemAfterUseExtension
.type GetItemAfterUseExtension, %function


		GetItemAfterUseExtension:
		
		@If item is indestructible, skip
		cmp		r0, #0
		bne		End
		
			@If item has at least one use left after taking one off
			add		r2, r1
			cmp		r2, #0xFF
			bgt		End
			
				ldr		r1, =ItemResetList
				
				@If on ItemResetList, don't break the item
				LoopThroughItemResetList:
				ldrb	r0, [r1]
				cmp		r0, #0
				beq		ItemBroke
				
					cmp		r0, r2
					beq		End
					
						add		r1, #4
						b		LoopThroughItemResetList
		
		ItemBroke:
		mov		r2, #0
		
		End:
		lsl		r0, r2, #0x10
		lsr		r0, #0x10
		bx		r14
		
		.align
		.ltorg

