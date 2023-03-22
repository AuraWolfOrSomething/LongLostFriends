.thumb

.include "../TerrainAtCoordsDefs.s"

.global AsmcReturnTerrainAtCoord
.type AsmcReturnTerrainAtCoord, %function


		AsmcReturnTerrainAtCoord:
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
		
		@store terrain type
		ldr		r1, =memSlotC
		str		r0, [r1]
		bx		r14
		
		.align
		.ltorg

