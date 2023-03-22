.thumb

@ r0 = Unit
@ r1 = Spd
@ r2 = Lck

.global AvoidFormula
.type AvoidFormula, %function


		AvoidFormula:
		lsr		r3, r1, #1 @AS*0.5
		add		r1, r3 @AS*1.5
		add		r1, r2 @AS*1.5 + Lck
		
		@Terrain
		mov		r2, r0
		add		r2, #0x57
		ldrb	r2, [r2]
		add		r1, r2 @AS*2 + Lck + Terrain
		lsl		r3, r1, #0x10
		cmp		r3, #0
		bge		StoreAvoid
		
			mov		r1, #0
		
		StoreAvoid:
		add		r0, #0x62
		strh	r1, [r0]
		bx		r14

