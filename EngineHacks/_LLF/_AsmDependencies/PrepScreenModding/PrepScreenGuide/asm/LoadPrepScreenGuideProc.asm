.thumb

.global LoadPrepScreenGuideProc
.type LoadPrepScreenGuideProc, %function

.equ ProcStartBlocking, 0x08002CE0


		LoadPrepScreenGuideProc:
		push	{r14}
		mov		r1, r0
		ldr		r0, =PrepScreenGuideProc
		ldr		r2, =ProcStartBlocking
		mov		lr, r2
		.short	0xF800
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

