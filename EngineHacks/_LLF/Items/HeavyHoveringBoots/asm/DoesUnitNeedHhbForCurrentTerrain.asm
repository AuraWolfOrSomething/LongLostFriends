
.thumb

.include "../HeavyHoveringBootsDefs.s"

.global DoesUnitNeedHhbForCurrentTerrain
.type DoesUnitNeedHhbForCurrentTerrain, %function

@similar to TerrainMovementCost, except for a few things
@1) a unit is passed through r0
@2) HeavyHoveringBootsCheck is ignored
@3) only the terrain that unit is on will be considered for all the modifiers
@4) this will return whether or not the unit can be on this terrain


		DoesUnitNeedHhbForCurrentTerrain:
		push	{r4-r6,r14}
		
		@Get class movement cost
		@Note: if your hack has movement costs affected by rain/snow, you will want to check if rain/snow is happening and then load the appropriate table instead
		ldr		r3, [r0,#4]
		ldr		r3, [r3,#0x38]
		
		@Get terrain that the unit is standing on
		ldr		r2, =gMapTerrain
		ldr		r2, [r2]
		ldrb	r1, [r0,#0x11] @unit's y-coord
		lsl		r1, #2
		ldr		r2, [r2,r1]
		ldrb	r1, [r0,#0x10] @unit's x-coord
		ldrb	r2, [r2,r1]
		
		@Default mov cost for class on this terrain
		ldrb	r3, [r3,r2]
		cmp		r3, #0xFF
		bne		ReturnFalse
		
			mov		r4, r0
			ldr		r5, =GiveFlightMovementList
			ldr		r6, =HeavyHoveringBootsCheck
		
			LoopThroughChecks_GiveFlight:
			ldr		r3, [r5]
			cmp		r3, #0
			beq		ReturnTrue
			
				cmp		r3, r6
				beq		ContinueLoop_GiveFlight
			
					mov		r0, r4
					mov		lr, r3
					.short	0xF800
					cmp		r0, #0
					bne		ReturnFalse
			
						ContinueLoop_GiveFlight:
						add		r5, #4
						b		LoopThroughChecks_GiveFlight
		
		ReturnTrue:
		mov		r0, #1
		b		End
		
		ReturnFalse:
		mov		r0, #0
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		
		.align
		.ltorg

