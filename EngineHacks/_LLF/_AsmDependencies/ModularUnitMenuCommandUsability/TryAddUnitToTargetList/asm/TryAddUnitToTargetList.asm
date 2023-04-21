.thumb

.equ origin, 0
.include "../TryAddUnitToTargetListDefs.s"

.global TryAddUnitToTargetList
.type TryAddUnitToTargetList, %function


		TryAddUnitToTargetList:
		push	{r4-r6,r14}
		mov		r4, r0
		ldr		r5, =gUnitSubject
		mov		r6, r1
		
		LoopThroughList:
		ldr		r2, [r6]
		cmp		r2, #0
		beq		AddTargetToTargetList
		
			ldr		r0, [r5]
			mov		r1, r4
			mov		lr, r2
			.short	0xF800
			cmp		r0, #0
			beq		End
			
				add		r6, #4
				b		LoopThroughList
		
		AddTargetToTargetList:
		ldr		r0, =AddTarget
		mov		lr, r0
		mov		r0, #0x10
		ldsb	r0, [r4,r0]
		mov		r1, #0x11
		ldsb	r1, [r4,r1]
		mov		r2, #0x0B
		ldsb	r2, [r4,r2]
		mov		r3, #0
		.short	0xF800
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

