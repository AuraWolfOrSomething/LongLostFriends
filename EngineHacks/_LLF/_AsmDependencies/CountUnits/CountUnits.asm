
.thumb

.include "CountUnitsDefs.s"

.global CountUnits
.type CountUnits, %function

.global CheckIfAcceptedTurnStatus
.type CheckIfAcceptedTurnStatus, %function

@new r4 = loop tracker

@r0 -> r5 = current unit

@r1 -> r6 = exceptions/inclusions
@0x02 include units that are rescued
@0x04 only include units that are dead
@0x20 only include units that are rescued
@0x40 include units that are dead


@r2 = faction comparison
@0x00 = can trade
@0x03 = are enemies (can attack each other)
@Any other value = any faction

@r3 -> r7 = range
@if 0, count all units in faction memory

@r8 = current faction "base" address for calculating

@r4 -> r9 = included routine to utilize (check if equipping a bow, check level, etc.)

@r10 = number of units that meet conditions

@r11 = id of repeat pattern to follow, 0 = no more repeats

		CountUnits:
		push	{r4-r7,lr}
		mov		r5, r0
		mov		r6, r1
		mov		r7, r3
		mov		r0, r8
		mov		r1, r9
		push	{r0-r1}
		mov		r0, r10
		mov		r1, r11
		push	{r0-r1}
		mov		r0, #0
		mov		r8, r0
		mov		r10, r0
		mov		r11, r0
		mov		r9, r4
		
		ldrb	r0, [r5,#0x0B]
		mov		r1, #0x40
		and		r1, r0
		cmp		r1, #0x40
		beq		CurrentUnitNPC
		mov		r1, #0x80
		and		r1, r0
		cmp		r1, #0x80
		beq		CurrentUnitEnemy
		
		@current unit is a player unit
		cmp		r2, #0
		beq		SearchPlayerUnits
		cmp		r2, #3
		beq		SearchEnemyUnits
		mov		r0, #2
		mov		r11, r0
		b		SearchPlayerUnits
		
		CurrentUnitNPC:
		cmp		r2, #0
		beq		SearchNPCUnits
		cmp		r2, #3
		beq		SearchEnemyUnits
		mov		r0, #2
		mov		r11, r0
		b		SearchPlayerUnits
		
		CurrentUnitEnemy:
		cmp		r2, #0
		beq		SearchEnemyUnits
		mov		r0, #1
		mov		r11, r0
		cmp		r2, #3
		beq		SearchPlayerUnits
		mov		r0, #2
		mov		r11, r0
		
		SearchPlayerUnits:
		ldr		r0, =PlayerBaseOffset
		mov		r8, r0
		b		SetUpLoop
		
		SearchNPCUnits:
		ldr		r0, =NPCBaseOffset
		mov		r8, r0
		b		SetUpLoop
		
		SearchEnemyUnits:
		ldr		r0, =EnemyBaseOffset
		mov		r8, r0
		
		SetUpLoop:
		mov		r4, #0
		
		CheckIfDoneWithFaction:
		add		r4, #1
		cmp		r4, #51
		bge		CheckIfMoreFactions
		
		mov		r0, #0x48
		mul		r0, r4
		add		r0, r8
		ldr		r2, [r0,#4]
		cmp		r2, #0 @if no class, then no unit is there, so cancel with this check
		beq		CheckIfDoneWithFaction
		ldrb	r1, [r5,#0x0B]
		ldrb	r2, [r0,#0x0B]
		cmp		r1, r2 @if same unit as current, then cancel with this unit
		beq		CheckIfDoneWithFaction
		
		@if range doesn't matter, skip to rescue check
		cmp		r7, #0
		beq		RescueCheck
		
		@check if unit is in range of current unit
		push	{r0}
		mov		r1, r5
		ldr		r3, =GetDistance
		mov		lr, r3
		.short	0xF800
		
		pop		{r1}
		cmp		r0, r7 @if unit is farther than accepted range, cancel this check
		bgt		CheckIfDoneWithFaction
		
		RescueCheck:
		mov		r3, #0x02
		and		r3, r6
		cmp		r3, #0x02 @if rescued and unrescued are accepted, skip to dead check
		beq		DeadCheck
		mov		r0, #0x48
		mul		r0, r4
		add		r0, r8
		mov		r1, #0x20
		mov		r2, r6
		ldr		r3, =CheckIfAcceptedTurnStatus
		mov		lr, r3
		.short	0xF800
		
		cmp		r0, #0
		beq		CheckIfDoneWithFaction

		DeadCheck:
		mov		r3, #0x40
		and		r3, r6
		cmp		r3, #0x40 @if dead and alive are accepted, skip to checking for included routine
		beq		CheckIncludedRoutine
		mov		r0, #0x48
		mul		r0, r4
		add		r0, r8
		mov		r1, #0x04
		mov		r2, r6
		ldr		r3, =CheckIfAcceptedTurnStatus
		mov		lr, r3
		.short	0xF800
		
		cmp		r0, #0
		beq		CheckIfDoneWithFaction
		
		CheckIncludedRoutine:
		mov		r3, r9
		cmp		r3, #0
		beq		CountThisUnit @if no routine, then no more conditions to be met in order to add this unit to the total
		
		mov		r0, #0x48
		mul		r0, r4
		add		r0, r8
		mov		r1, r5
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		CheckIfDoneWithFaction
		
		@if unit made it this far, then unit is counted
		CountThisUnit:
		mov		r0, r10
		add		r0, #1
		mov		r10, r0
		b		CheckIfDoneWithFaction
		
		CheckIfMoreFactions:
		mov		r1, r11
		cmp		r1, #0
		ble		End
		
		@if there's at least one more repeat left
		cmp		r1, #1
		beq		LastCheckNPC
		cmp		r1, #2
		beq		SecondCheckNPC
		cmp		r1, #3
		beq		LastCheckEnemy
		b		End @shouldn't be any possibility that links to this, but just in case
		
		LastCheckNPC:
		mov		r1, #0
		mov		r11, r1
		b		SearchNPCUnits
		
		SecondCheckNPC:
		mov		r1, #3
		mov		r11, r1
		b		SearchNPCUnits
		
		LastCheckEnemy:
		mov		r1, #0
		mov		r11, r1
		b		SearchEnemyUnits
		
		End:
		mov		r0, r10
		pop		{r1-r4}
		mov		r11, r2
		mov		r10, r1
		mov		r9, r4
		mov		r8, r3
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-------------------------------------------
@CheckIfAcceptedTurnStatus
@-------------------------------------------


		CheckIfAcceptedTurnStatus:
		mov		r3, r1
		and		r3, r2
		cmp		r3, r1
		beq		OnlyIncludeSpecial
		
			ldrb	r0, [r0,#0x0C]
			and		r0, r1
			cmp		r0, r1
			beq		TurnStatusNotAccepted
			
				b		TurnStatusAccepted
		
		OnlyIncludeSpecial:
		ldrb	r0, [r0,#0x0C]
		and		r0, r1
		cmp		r0, r1
		bne		TurnStatusNotAccepted
		
			TurnStatusAccepted:
			mov		r0, #1
			b		GoBack
		
		TurnStatusNotAccepted:
		mov		r0, #0
		
		GoBack:
		bx		r14
		
		.align
		.ltorg

