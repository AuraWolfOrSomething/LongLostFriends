.thumb

.equ origin, 0
.include "../DurabilityDisplayDefs.s"

.global StatScreenDrawItem
.type StatScreenDrawItem, %function


		StatScreenDrawItem:
		push	{r4-r7,r14}
		add		sp, #-0x08
		str		r0, [sp]
		str		r1, [sp,#4]
		mov		r5, r2
		mov		r7, r3
		ldr		r1, =TextClear
		mov		lr, r1
		.short	0xF800
		
		ldr		r0, [sp,#4]
		mov		r1, #0xFF
		and		r1, r0
		lsl		r2, r1, #3
		add		r2, r1
		lsl		r2, #2
		ldr		r6, =ItemTable
		add		r6, r2
		ldrb	r0, [r6,#6]
		ldr		r1, =FindDurabilityDisplayExceptionEntry
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		ContinueStatScreenDrawItem
		
			ldr		r1, [r0,#0x04]
			cmp		r1, #0
			beq		ContinueStatScreenDrawItem
			
				ldr		r0, [sp,#4]
				asr		r0, #8 @item's current uses
				mov		lr, r1
				mov		r1, r5
				mov		r2, r7
				ldr		r3, [sp]
				.short	0xF800
				b		EndStatScreenDrawItem
		
		ContinueStatScreenDrawItem:
		ldr		r0, [sp]
		mov		r1, r5
		ldr		r2, =Text_SetColorId
		mov		lr, r2
		.short	0xF800
		ldrh	r0, [r6]
		ldr		r1, =StringGetFromIndex
		mov		lr, r1
		.short	0xF800
		ldr		r1, =StringExpandTactName
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		ldr		r0, [sp]
		ldr		r2, =TextDrawString
		mov		lr, r2
		.short	0xF800
		
		ldr		r1, [r6,#8]
		mov		r3, #8
		tst		r1, r3
		bne		GoToTextDisplay
		
			@Check if unit can wield item
			mov		r4, #0 @white font
			cmp		r5, #1
			bne		DrawSlashMarker
		
				mov		r4, #1 @gray font
		
			DrawSlashMarker:
			mov		r0, r7
			add		r0, #0x18
			mov		r1, r4
			mov		r2, #0x16
			ldr		r3, =DrawSpecialUiChar
			mov		lr, r3
			.short	0xF800
			
			cmp		r4, #1
			beq		DisplayCurrentDurability
		
				mov		r4, #2 @blue font
		
			DisplayCurrentDurability:
			mov		r0, r7
			add		r0, #0x16
			mov		r1, r4
			ldr		r2, [sp,#4]
			asr		r2, #8 @item's current uses
			ldr		r3, =DrawUiNumberOrDoubleDashes
			mov		lr, r3
			.short	0xF800
		
			@next: display max durability
			mov		r0, r7
			add		r0, #0x1C
			mov		r1, r4
			ldrb	r2, [r6,#0x14]
			ldr		r3, =DrawUiNumberOrDoubleDashes
			mov		lr, r3
			.short	0xF800
		
		GoToTextDisplay:
		add		r1, r7, #4
		ldr		r0, [sp]
		ldr		r3, =TextDisplay
		mov		lr, r3
		.short	0xF800
		
		@Drawing item icon
		ldr		r0, [sp,#4]
		cmp		r0, #0
		bne		Label_0x16AD4
		
			mov		r1, #1
			neg		r1, r1
			b		Label_0x16AD6
		
		Label_0x16AD4:
		ldrb	r1, [r6,#0x1D]
		
		Label_0x16AD6:
		mov		r2, #0x80
		lsl		r2, #7
		mov		r0, r7
		ldr		r3, =DrawIcon
		mov		lr, r3
		.short	0xF800
		
		EndStatScreenDrawItem:
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

