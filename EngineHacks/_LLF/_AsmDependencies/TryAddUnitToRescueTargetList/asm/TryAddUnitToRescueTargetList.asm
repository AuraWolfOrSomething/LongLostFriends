.thumb

.equ origin, 0x08025344
.include "../TryAddUnitToRescueTargetListDefs.s"

.global TryAddUnitToRescueTargetList
.type TryAddUnitToRescueTargetList, %function


		TryAddUnitToRescueTargetList:
		push	{r4-r6,r14}
		mov		r4, r0
		ldr		r5, =gUnitSubject
		ldr		r6, =RescueCommandTargetConditionsList
		
		LoopThroughList:
		ldr		r2, [r6]
		cmp		r2, #0
		beq		AddToRescueTargetList
		
			ldr		r0, [r5]
			mov		r1, r4
			mov		lr, r2
			.short	0xF800
			cmp		r0, #0
			beq		End
			
				add		r6, #4
				b		LoopThroughList
		
		AddToRescueTargetList:
		mov		r0, #0x10
		ldsb	r0, [r4,r0]
		mov		r1, #0x11
		ldsb	r1, [r4,r1]
		mov		r2, #0x0B
		ldsb	r2, [r4,r2]
		mov		r3, #0
		bl		bl_AddTarget
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

