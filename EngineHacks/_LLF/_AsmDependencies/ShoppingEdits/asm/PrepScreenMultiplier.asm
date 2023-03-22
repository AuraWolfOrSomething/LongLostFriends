.thumb

.include "../ShoppingEditsDefs.s"

.global PrepScreenMultiplier
.type PrepScreenMultiplier, %function


		PrepScreenMultiplier:
		@Check if there was no unit passed (if no unit, then a shop on the map is being looked at)
		cmp		r1, #0
		beq		End
		
			@Check if shop is being accessed during prep screen
			ldr		r1, =gGameState
			ldrb	r3, [r1,#4]
			mov		r1, #0x10
			tst		r1, r3
			beq		End
		
				@Find chapter's battle prep shop
				ldr		r1, =gChapterData
				mov		r3, #0x0E
				ldsb	r3, [r1,r3]
				ldr		r1, =ChapterBattlePrepShopTable
				lsl		r3, #2 @entries are 4 bytes long (pointers to the shop)
				add		r1, r3
				ldr		r1, [r1]
		
				LoopThroughBattlePrepShop:
				ldrb	r3, [r1]
				cmp		r3, r2
				beq		ItemFound
				
					cmp		r3, #0
					beq		End
					
						add		r1, #2
						b		LoopThroughBattlePrepShop
		
		@check if Bargain item (will have an event ID after item ID)
		  @if no id/0, apply prep screen multiplier
		ItemFound:
		ldrb	r3, [r1,#1]
		cmp		r3, #0
		bne		End

			add		r0, #50 @1.5x
		
		End:
		bx		r14
		
		.align
		.ltorg

