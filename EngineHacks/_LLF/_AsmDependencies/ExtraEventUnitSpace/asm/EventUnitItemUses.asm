.thumb

.include "../EeusDefs.s"

.global EventUnitItemUses
.type EventUnitItemUses, %function


		EventUnitItemUses:
		push	{r4-r5,r14}
		mov		r4, r0
		ldrb	r0, [r0]
		
		@if index isn't 0x80 and above, go to default (full uses)
		ldrb	r3, [r1,#6]
		mov		r2, #0x80
		tst		r3, r2
		beq		ItemHasFullUses
		
		@load chapter item uses table and check if there's a pointer
		ldr		r2, =gChapterData
		mov		r5, #0x0E
		ldsb	r5, [r2,r5]
		ldr     r2, =EEUS_ItemUsesTable @Load table with pointers to the table of each chapter
		lsl		r5, #2 @pointers are 4 bytes long
		add		r2, r5
		ldr		r2, [r2]
		cmp		r2, #0
		beq		ItemHasFullUses
		
		sub		r3, #0x81
		lsl		r3, #2 @entries for this module are 4 bytes long (1 per item, 4 max in events)
		add		r2, r3
		sub		r3, r4, r1 @get item slot number
		sub		r3, #0x0C
		ldrb	r3, [r2,r3]
		cmp		r3, #0
		beq		ItemHasFullUses
		
		@if a value other than 0 is set, take that value
		lsl		r3, #8
		add		r0, r3
		b		End
		
		@if set to use full uses, check max durability
		ItemHasFullUses:
		ldr		r3, =GetFullUses
		mov		lr, r3
		.short	0xF800
		
		End:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align

