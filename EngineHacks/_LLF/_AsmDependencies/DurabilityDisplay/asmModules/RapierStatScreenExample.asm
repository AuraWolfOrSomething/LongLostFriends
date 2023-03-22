.thumb

.equ origin, 0
.include "../DurabilityDisplayDefs.s"

.global RapierStatScreenExample
.type RapierStatScreenExample, %function


		RapierStatScreenExample:
		push	{r4-r7,r14}
		add		sp, #-0x08
		str		r3, [sp]
		str		r0, [sp,#4]
		mov		r5, r1
		mov		r7, r2
		
		@If unit can't wield, keep gray font
		  @Otherwise, use orange font for item name
		cmp		r5, #1
		beq		GoToSetColorId
		
			mov		r5, #3
		
		GoToSetColorId:
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
		
		@Check if unit can wield item
		mov		r4, #4 @green font
		cmp		r5, #1
		bne		DrawSlashMarker
	
			mov		r4, #1 @gray font
	
		DrawSlashMarker:
		mov		r0, r7
		add		r0, #0x12 @default spacing is 0x18, so this shifts it to the left
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
		add		r0, #0x10 @default spacing is 0x16, so this shifts it to the left
		mov		r1, r4
		
		@always show 1
		@ldr		r2, [sp,#4]
		@asr		r2, #8 @item's current uses
		mov		r2, #1
		ldr		r3, =DrawUiNumberOrDoubleDashes
		mov		lr, r3
		.short	0xF800
	
		@next: display max durability
		mov		r0, r7
		add		r0, #0x16 @default spacing is 0x1C, so this shifts it to the left
		mov		r1, r4
		
		@always show 2
		@ldrb	r2, [r6,#0x14]
		mov		r2, #2
		ldr		r3, =DrawUiNumberOrDoubleDashes
		mov		lr, r3
		.short	0xF800
		
		mov		r1, r7 @normally adds 4 to r1 afterwards, so having no addition will shift the name to the left
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
		add		r0, #0x1A @normally no addition, so this shifts it to the right
		ldr		r3, =DrawIcon
		mov		lr, r3
		.short	0xF800
		
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		
		.align
		.ltorg

