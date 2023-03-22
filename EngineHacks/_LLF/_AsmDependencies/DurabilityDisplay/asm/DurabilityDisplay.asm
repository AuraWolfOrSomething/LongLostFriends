.thumb

.equ origin, 0x08016A40
.include "../DurabilityDisplayDefs.s"

.global FindDurabilityDisplayExceptionEntry
.type FindDurabilityDisplayExceptionEntry, %function

.global NewGetItemNameString
.type NewGetItemNameString, %function

.global NewGetItemUses
.type NewGetItemUses, %function


		FindDurabilityDisplayExceptionEntry:
		ldr		r2, =DurabilityDisplayExceptionList
		
		LoopThroughList:
		ldrb	r1, [r2]
		cmp		r1, #0
		beq		NoEntryFound
		
			cmp		r0, r1
			beq		ReturnEntry
			
				add		r2, #0x10
				b		LoopThroughList
		
		NoEntryFound:
		mov		r2, #0
		
		ReturnEntry:
		mov		r0, r2
		bx		r14
		
		.align
		.ltorg


@-----------------------------------
@NewGetItemNameString
@-----------------------------------


		NewGetItemNameString:
		push	{r4-r5,r14}
		mov		r1, #0xFF
		and		r1, r0
		asr		r4, r0, #8 @item's current uses
		lsl		r2, r1, #3
		add		r2, r1
		lsl		r2, #2
		ldr		r5, =ItemTable
		add		r5, r2 @item entry on item table
		ldrb	r0, [r5,#6] @item id
		bl		FindDurabilityDisplayExceptionEntry
		cmp		r0, #0
		beq		ContinueNewGetItemNameString
		
			ldr		r1, [r0,#0x08]		
			cmp		r1, #0
			beq		ContinueNewGetItemNameString
			
				mov		r0, r4
				mov		lr, r1
				mov		r1, r5
				.short	0xF800
				b		ReturnItemNameString
		
		ContinueNewGetItemNameString:
		ldrh	r0, [r5]
		bl		bl_StringGetFromIndex
		@ldr		r3, =StringGetFromIndex
		@mov		lr, r3
		@.short	0xF800
		bl		bl_StringExpandTactName
		@ldr		r3, =StringExpandTactName
		@mov		lr, r3
		@.short	0xF800
		
		ReturnItemNameString:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------
@NewGetItemUses
@-----------------------------------


		NewGetItemUses:
		push	{r4-r5,r14}
		mov		r1, #0xFF
		and		r1, r0
		asr		r4, r0, #8 @item's current uses
		lsl		r2, r1, #3
		add		r2, r1
		lsl		r2, #2
		ldr		r5, =ItemTable
		add		r5, r2 @item entry on item table
		ldrb	r0, [r5,#6] @item id
		bl		FindDurabilityDisplayExceptionEntry
		cmp		r0, #0
		beq		ContinueNewGetItemUses
		
			ldr		r1, [r0,#0x0C]		
			cmp		r1, #0
			beq		ContinueNewGetItemUses
			
				mov		r0, r4
				mov		lr, r1
				mov		r1, r5
				.short	0xF800
				b		ReturnItemUses
		
		ContinueNewGetItemUses:
		@check if indestructible
		ldr		r2, [r5,#8]
		mov		r1, #8
		tst		r2, r1
		beq		PreReturnItemUses

			mov		r4, #0xFF
		
		PreReturnItemUses:
		mov		r0, r4
		
		ReturnItemUses:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


