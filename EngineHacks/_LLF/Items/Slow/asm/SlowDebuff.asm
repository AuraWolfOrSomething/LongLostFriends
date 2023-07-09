.thumb

.global SlowDebuff
.type SlowDebuff, %function


		SlowDebuff:
		push	{r4-r5,r14}
		mov		r5, r0 @stat
		mov		r4, r1 @unit
		
		mov		r0, r4
		ldr		r1, =IsSlowDebuffActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r0, r4
			ldr		r1, =DetermineSlowSeverity
			mov		lr, r1
			.short	0xF800
			sub		r5, r0
		
		End:
		mov		r0, r5
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

