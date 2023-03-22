.thumb

.global GetDistance
.type GetDistance, %function

.global GetDistanceFromCoords
.type GetDistanceFromCoords, %function

@r0 = unit 1
@r1 = unit 2


		GetDistance:
		push	{r4,r14}
		
		@Horizontal Distance
		mov		r3, #0x10
		ldsb	r2, [r0,r3]
		ldsb	r3, [r1,r3]
		sub		r4, r3, r2
		cmp		r4, #0x00
		bge		VerticalDistance 
		sub		r4, r2, r3 @distance difference is a positive value, so we need the absolute value of the two x-coords
		
		VerticalDistance:
		mov		r3, #0x11
		ldsb	r2, [r0,r3]
		ldsb	r3, [r1,r3]
		sub		r0, r3, r2
		cmp		r0, #0x00
		bge		TotalDistance
		sub		r0, r2, r3 @have to get the absolute value once more
		
		TotalDistance:
		add		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg
		
@r0 = unit
@r1 = x-coord
@r2 = y-coord


		GetDistanceFromCoords:
		push	{r4,r14}
		mov		r3, #0x10
		ldsb	r3, [r0,r3]
		sub		r4, r3, r1
		cmp		r4, #0
		bge		GetUnitYCoord
		
			sub		r4, r1, r3
		
		GetUnitYCoord:
		mov		r3, #0x11
		ldsb	r3, [r0,r3]
		sub		r0, r3, r2
		cmp		r0, #0
		bge		ReturnDistance
		
			sub		r0, r2, r3
		
		ReturnDistance:
		add		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

