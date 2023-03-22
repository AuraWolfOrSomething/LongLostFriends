.thumb

.global RetrieveEventUnitData
.type RetrieveEventUnitData, %function


		RetrieveEventUnitData:
		push	{r4}
		mov		r3, #0
		
		LoopThoroughUnitData:
		lsl		r4, r3, #2
		ldr		r2, [r0,r4]
		str		r2, [r1,r4]
		add		r3, #1
		cmp		r3, #10
		blt		LoopThoroughUnitData
		pop		{r4}
		bx		r14

