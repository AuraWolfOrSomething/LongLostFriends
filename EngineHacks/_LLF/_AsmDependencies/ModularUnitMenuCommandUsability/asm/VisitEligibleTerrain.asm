.thumb

.include "../MumcuDefs.s"

.global VisitEligibleTerrain
.type VisitEligibleTerrain, %function


		VisitEligibleTerrain:
		ldr		r1, =gMapTerrain
		ldr		r1, [r1]
		ldrb	r2, [r0,#0x11]
		lsl		r2, #2
		add		r1, r2
		ldr		r1, [r1]
		ldrb	r2, [r0,#0x10]
		add		r1, r2
		ldrb	r1, [r1]
		
		@village
		cmp		r1, #5
		beq		CanUse
		
			@house
			cmp		r1, #3
			beq		CanUse
			
				mov		r0, #0
				b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

