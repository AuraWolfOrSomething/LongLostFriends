.thumb

.include "../LullDefs.s"

.global LullTarget
.type LullTarget, %function


		LullTarget:
		push	{r14}
		ldr		r0, =gProc_LullTargetPosSelection
		mov		r1, #3
		ldr		r2, =ProcStart
		mov		lr, r2
		.short	0xF800
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
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

