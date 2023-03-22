.thumb

.global StaffUsageRequisites
.type StaffUsageRequisites, %function


		StaffUsageRequisites:
		push	{r4-r6,r14}
		mov		r4, r0 @unit
		mov		r5, r1 @staff
		ldr		r6, =StaffUsageRequisiteList
		
		LoopThroughList:
		ldr		r2, [r6]
		cmp		r2, #0
		beq		CanUseStaff
		
			mov		lr, r2
			.short	0xF800
			cmp		r0, #0
			beq		End
			
				mov		r0, r4
				mov		r1, r5
				add		r6, #4
				b		LoopThroughList
		
		
		CanUseStaff:
		mov		r0, #1
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

