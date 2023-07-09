.thumb

.include "../AbsorbDefs.s"

.global AbsorbUsability
.type AbsorbUsability, %function


		AbsorbUsability:
		push	{r4-r5,r14}
		mov		r4, r0
		mov		r5, r1
		ldr		r1, =IsAbsorbDebuffActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		bne		CannotUse
		
			mov		r0, r4
			mov		r2, r5
			ldr		r1, =AbsorbStaffRangeSetup
			ldr		r3, =IsGeneratedTargetListEmpty
			mov		lr, r3
			.short	0xF800
			b		End
			
			CannotUse:
			mov		r0, #0
		
		End:
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

