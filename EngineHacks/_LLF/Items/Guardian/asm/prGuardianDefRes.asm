.thumb

.global prGuardianDefRes
.type prGuardianDefRes, %function


		prGuardianDefRes:
		push	{r4,r14}
		mov		r4, r0
		mov		r0, r1
		ldr		r1, =IsGuardianDamageActive
		mov		lr, r1
		.short	0xF800
		
		@If Guardian has Def/Res effect active, add +5
		cmp		r0, #0
		beq		End
		
			add		r4, #5
		
		End:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

