.thumb

.global TargetCheckAnyNegativeStatusDebuffNotAbsorb
.type TargetCheckAnyNegativeStatusDebuffNotAbsorb, %function


		TargetCheckAnyNegativeStatusDebuffNotAbsorb:
		push	{r4-r5,r14}
		mov		r4, #0
		mov		r5, r1
		
		mov		r0, r5
		ldr		r1, =IsAbsorbDebuffActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		bne		End
		
			mov		r4, #1
			mov		r0, r5
			ldr		r1, =IsAnyStatusActive
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			bne		End
			
				mov		r0, r5
				ldr		r1, =CountAllDebuffsActive
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				bne		End
				
					mov		r4, #0
		
		End:
		mov		r0, r4
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

