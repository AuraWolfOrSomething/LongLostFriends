.thumb

.include "../TerrainAtCoordsDefs.s"

.global AsmcCheckIfTerrainAtCoord
.type AsmcCheckIfTerrainAtCoord, %function

.global CallWithinAsmCheckIfTerrainAtCoord
.type CallWithinAsmCheckIfTerrainAtCoord, %function


		AsmcCheckIfTerrainAtCoord:
		ldr		r2, =memSlotB
		ldr		r2, [r2] @coordinates
		ldr		r0, =gMapTerrain
		ldr		r0, [r0]
				
		@get row (from y-coord)
		lsr		r1, r2, #8
		lsl		r1, #2
		ldr		r0, [r0,r1]
				
		@get tile (just need x-coord)
		lsl		r1, r2, #24
		lsr		r1, #24
		ldrb	r0, [r0,r1]
		
		@check if terrain type is the "requested" terrain
		ldr		r2, =memSlot1
		ldr		r2, [r2]
		cmp		r0, r2
		bne		RetFalse
		
			mov		r0, #1
			b		End
		
		RetFalse:
		mov		r0, #0
		
		End:
		ldr		r1, =memSlotC
		str		r0, [r1]
		bx		r14
		
		.align
		.ltorg


		CallWithinAsmCheckIfTerrainAtCoord:
		ldr		r2, =gMapTerrain
		ldr		r2, [r2]
		
		@get row (from y-coord)
		ldrb	r1, [r0,#1]
		lsl		r1, #2
		ldr		r2, [r2,r1]
		
		@get tile (just need x-coord)
		ldrb	r1, [r0]
		ldrb	r2, [r2,r1]
		
		@check if terrain type is the "requested" terrain
		ldrb	r1, [r0,#2]
		cmp		r1, r2
		bne		RetFalse2
		
			mov		r0, #1
			b		End2
		
		RetFalse2:
		mov		r0, #0
		
		End2:
		bx		r14
		
		.align
		.ltorg


