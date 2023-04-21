.thumb

.global AvoidFormula
.type AvoidFormula, %function


		AvoidFormula:
		push	{r4-r5,r14}
		mov		r4, r0 @unit
		lsr		r3, r1, #1 @AS*0.5
		add		r5, r1, r3 @AS*1.5
		add		r5, r2 @AS*1.5 + Lck
		
		@If unit is on terrain only accessible via Hhb, don't give avoid bonus
		ldr		r1, =DoesUnitNeedHhbForCurrentTerrain
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		bne		CheckForUnderflow
		
			@Terrain
			mov		r0, #0x57
			ldrb	r0, [r4,r0]
			add		r5, r0 @AS*1.5 + Lck + Terrain
		
		CheckForUnderflow:
		cmp		r5, #0
		bge		StoreAvoid
		
			mov		r5, #0
		
		StoreAvoid:
		mov		r0, #0x62
		strh	r5, [r4,r0]
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

