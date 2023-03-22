.thumb

.include "../PlanDefs.s"

.global FutureInit
.type FutureInit, %function


		FutureInit:
		push	{r14}

		@Initialize proc
		ldr		r1, [r0,#0x28]
		lsl		r1, #24
		lsr		r1, #24
		str		r1, [r0,#0x28]
		
		mov		r1, #0
		mov		r2, #0x2C
		
		InitLoop:
		str		r1, [r0,r2]
		add		r2, #4
		cmp		r2, #0x6C
		blt		InitLoop
		
		@Give audio cue feedback
		mov		r0, #0x6A
		ldr		r1, =m4aSongNumStart
		mov		lr, r1
		.short	0xF800
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

