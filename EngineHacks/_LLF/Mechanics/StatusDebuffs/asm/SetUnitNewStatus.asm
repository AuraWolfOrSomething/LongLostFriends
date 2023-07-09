.thumb

.global SetUnitNewStatus
.type SetUnitNewStatus, %function


		SetUnitNewStatus:
		push	{r4-r5,r14}
		mov		r4, r0
		mov		r5, r1
		cmp		r1, #0
		beq		StoreStatus
		
			ldr		r1, =IsWardenActive
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			bne		RemoveWarden

				mov		r2, #0x0F
				and		r5, r2
				add		r5, #0x50 @5 turns

				StoreStatus:
				mov		r0, #0x30
				strb	r5, [r4,r0]
				b		End
				
				RemoveWarden:
				mov		r0, r4
				ldr		r1, =RemoveWardenBuffOnUnit
				mov		lr, r1
				.short	0xF800
				
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

