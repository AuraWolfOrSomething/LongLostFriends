.thumb

.global NewCanUsePromotionItem
.type NewCanUsePromotionItem, %function

.equ origin, 0x080291A8
.include "../PromotionDefs.s"

@Vanilla order of checks:
@lord check (check item id if so and then make sure the lord can't use the other lord's item) -> level -> item id -> class on list

@New order of checks (not galaxy brain):
@item id -> class on list -> level

@r4 = can unit use this promotion item
@r5 = unit

@r1 = promotion item in inventory (don't need this for long in current routine, so we're not saving this)

		NewCanUsePromotionItem:
		push	{r4-r5,r14}
		mov		r5, r0
		mov		r4, #0
		
		mov		r0, r1
		bl		bl_GetItemIndex
		
		ldr		r3, =PromotionItemTable
		
		@make sure this item is even a promotion item
		  @once that's confirmed, load the list of classes that can use this item
		  @if not, we're done
		  
		CheckIfPromotionItemLoop:
		ldrb	r1, [r3]
		cmp		r1, #0
		beq		End
		
			cmp		r1, r0
			beq		EntryFound
		
				add		r3, #8
				b		CheckIfPromotionItemLoop
		
		EntryFound:
		ldr		r2, [r3,#4] @list of classes that can use this item
		ldr		r0, [r5,#4] @unit's class
		ldrb	r0, [r0,#4] @the class id
		
		@check if class is on this list
		  @if so, get unit level
		  @if not, we're done
		
		PromotionItemClassListLoop:
		ldrb	r1, [r2]
		add		r2, #1
		cmp		r1, #0
		beq		End @if we've reached the end of the list, go to End
		
			cmp		r1, r0
			bne		PromotionItemClassListLoop
		
		ldrb	r0, [r5,#8] @unit's level
		ldrb	r1, [r3,#2] @minimal level item allows
		cmp		r0, r1
		blt		End

			mov		r4, #1
		
		End:
		mov		r0, r4
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

