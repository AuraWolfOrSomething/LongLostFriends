.thumb

.include "../SlowDefs.s"

.global SlowTarget
.type SlowTarget, %function


		SlowTarget:
		push	{r4,r14}
		ldr		r3, =MakeTargetListForSlow
		mov		lr, r3
		.short	0xF800
		ldr		r0, =gMapMovement
		ldr		r0, [r0]
		mov		r1, #1
		neg		r1, r1
		ldr		r2, =ClearMapWith
		mov		lr, r2
		.short	0xF800
		
		ldr		r0, =gMenu_SlowTargetMenu
		ldr		r1, =StartTargetSelection
		mov		lr, r1
		.short	0xF800
		mov		r4, r0
		
		ldr		r0, =SlowTargetBottomTextLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r0, r4
		ldr		r2, =StartBottomHelpText
		mov		lr, r2
		.short	0xF800
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

