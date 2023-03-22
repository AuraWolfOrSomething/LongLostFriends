.thumb

.equ origin, 0
.include "../DurabilityDisplayDefs.s"

.global NewDrawItemMenuCommand
.type NewDrawItemMenuCommand, %function


		NewDrawItemMenuCommand:
		push	{r4-r7,r14}
		add		sp, #-0x04
		mov		r5, r0
		mov		r6, r1
		mov		r7, r3
		lsl		r2, #0x18
		asr		r2, #0x18
		str		r2, [sp]
		mov		r3, #0
		cmp		r2, #0
		bne		GoToTextSetParameters
		
			mov		r3, #1
		
		GoToTextSetParameters:
		mov		r1, #0
		mov		r2, r3
		ldr		r3, =TextSetParameters
		mov		lr, r3
		.short	0xF800
		
		@Item name
		mov		r0, r6
		ldr		r1, =NewGetItemNameString
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r0, r5
		ldr		r2, =TextDrawString
		mov		lr, r2
		.short	0xF800
		add		r1, r7, #4
		mov		r0, r5
		ldr		r2, =TextDisplay
		mov		lr, r2
		.short	0xF800
		
		@Current uses
		mov		r5, #1 @blue font
		ldr		r0, [sp]
		cmp		r0, #0
		beq		GoToGetItemUses
		
			mov		r5, #2 @gray font
		
		GoToGetItemUses:
		mov		r0, r6
		ldr		r1, =NewGetItemUses
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0xFF
		beq		CheckIfItem
		
			mov		r2, r0
			mov		r0, r7
			add		r0, #0x16
			mov		r1, r5
			ldr		r3, =DrawUiNumberOrDoubleDashes
			mov		lr, r3
			.short	0xF800
		
		@Icon
		CheckIfItem:
		cmp		r6, #0
		bne		LoadItemIcon
		
			mov		r1, #1
			neg		r1, r1
			b		GoToGetItemIconId
		
		LoadItemIcon:
		mov		r0, #0xFF
		and		r0, r6
		lsl		r1, r0, #3
		add		r1, r0
		lsl		r1, #2
		ldr		r4, =ItemTable
		add		r4, r1
		ldrb	r1, [r4,#0x1D]
		
		GoToGetItemIconId:
		mov		r2, #0x80
		lsl		r2, #7
		mov		r0, r7
		ldr		r3, =DrawIcon
		mov		lr, r3
		.short	0xF800
		
		End:
		add		sp, #0x04
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

