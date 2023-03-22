.thumb

.include "../DistractDefs.s"

.global DistractTarget
.type DistractTarget, %function


		DistractTarget:
		push	{r4,r14}
		ldr		r3, =MakeTargetListForDistract
		mov		lr, r3
		.short	0xF800
		
		ldr		r0, =gMapMovement
		ldr		r0, [r0]
		mov		r1, #1
		neg		r1, r1
		ldr		r2, =ClearMapWith
		mov		lr, r2
		.short	0xF800
		
		ldr		r0, =gSelect_GenericStaff
		ldr		r1, =DistractTargetSelection_OnSelect
		ldr		r2, =StartTargetSelectionExt
		mov		lr, r2
		.short	0xF800
		mov		r4, r0
		
		@Display text at the bottom
		ldr		r0, =DistractTargetBottomTextLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r0, r4
		ldr		r2, =StartBottomHelpText
		mov		lr, r2
		.short	0xF800
		
		@If sound/music isn't on, don't play sound effect
		ldr		r0, =gChapterData
		add		r0, #0x41
		ldrb	r0, [r0]
		lsl		r0, #0x1E
		cmp		r0, #0
		blt		End
		
			mov		r0, #0x6A
			ldr		r1, =m4aSongNumStart
			mov		lr, r1
			.short	0xF800
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

