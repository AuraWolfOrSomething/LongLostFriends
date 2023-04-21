.thumb

.include "../../MultipleHelpTextPagesDefs.s"

.global NextPageOfTextForItemDesc
.type NextPageOfTextForItemDesc, %function


		NextPageOfTextForItemDesc:
		ldr		r3, =gSomeTextRelatedStuff
		ldrb	r3, [r3,#0x14]
		ldrb	r2, [r0,#1]
		cmp		r3, r2
		blt		GetNextPageNumber
		
			mov		r3, #0
		
		GetNextPageNumber:
		add		r2, r3, #1
		ldr		r3, =gSomeTextRelatedStuff
		strb	r2, [r3,#0x14]
		
		@remove item stats if not first page
		cmp		r2, #1
		beq		GetTextIdForNextPage
		
			@mov		r3, #0
			mov		r3, #0xFF
			lsl		r3, #8
			add		r3, #1
			strh	r3, [r1]
		
		GetTextIdForNextPage:
		lsl		r2, #1
		ldrh	r0, [r0,r2]
		bx		r14
		
		.align
		.ltorg
