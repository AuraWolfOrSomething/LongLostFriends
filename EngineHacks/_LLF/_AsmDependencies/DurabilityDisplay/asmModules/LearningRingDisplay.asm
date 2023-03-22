.thumb

.equ origin, 0
.include "../DurabilityDisplayDefs.s"

.global LearningRingStatScreenDisplay
.type LearningRingStatScreenDisplay, %function

.global LearningRingNameDisplay
.type LearningRingNameDisplay, %function

.global LearningRingDurabilityDisplay
.type LearningRingDurabilityDisplay, %function


		LearningRingStatScreenDisplay:
		push	{r4-r7,r14}
		add		sp, #-0x08
		str		r3, [sp]
		str		r0, [sp,#4]
		mov		r5, r1
		mov		r7, r2
		
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
	
		@Finish displaying item name
		add		r1, r7, #4
		ldr		r0, [sp]
		ldr		r2, =TextDisplay
		mov		lr, r2
		.short	0xF800
		ldr		r0, [sp]
		sub		r0, #0x28
		str		r0, [sp]
		ldr		r1, =TextClear
		mov		lr, r1
		.short	0xF800
		
		@Stat text
		ldr		r3, =LearningRingCycle
		ldr		r2, [sp,#4]
		lsr		r2, #4
		ldrb	r2, [r3,r2]
		ldr		r3, =StatTextIDLink
		lsl		r2, #1
		ldrh	r0, [r3,r2]
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
		mov		r1, r7
		add		r1, #0x1A
		ldr		r0, [sp]
		ldr		r2, =TextDisplay
		mov		lr, r2
		.short	0xF800
		
		@Current uses
		mov		r0, r7
		add		r0, #0x16
		mov		r1, #2 @blue font
		ldr		r2, [sp,#4]
		lsl		r2, #28
		lsr		r2, #28
		ldr		r3, =DrawUiNumberOrDoubleDashes
		mov		lr, r3
		.short	0xF800
		
		@Item icon
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
		
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@LearningRingNameDisplay
@-----------------------------------------

		LearningRingNameDisplay:
		push	{r14}
		
		@Display name if uses are 0
		lsl		r2, r0, #28
		lsr		r2, #28
		cmp		r2, #0
		beq		UseItemName
		
			@Display current stat if at least 1 use left
			lsr		r2, r0, #4
			ldr		r3, =LearningRingCycle
			ldrb	r2, [r3,r2]
			ldr		r3, =StatTextIDLink
			lsl		r2, #1
			ldrh	r0, [r3,r2]
			b		GoToStringGetFromIndex
		
		UseItemName:
		ldrh	r0, [r1]
		
		GoToStringGetFromIndex:
		ldr		r1, =StringGetFromIndex
		mov		lr, r1
		.short	0xF800
		ldr		r1, =StringExpandTactName
		mov		lr, r1
		.short	0xF800
		
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@LearningRingDurabilityDisplay
@-----------------------------------------

		LearningRingDurabilityDisplay:
		lsl		r0, #28
		lsr		r0, #28
		bx		r14
		
		.align
		.ltorg

