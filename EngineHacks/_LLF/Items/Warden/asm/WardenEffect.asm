.thumb

.include "../WardenDefs.s"

.global WardenEffect
.type WardenEffect, %function


		WardenEffect:
		push	{r4-r6,r14}
		mov		r6, r0
		ldr		r4, =gActionData
		ldrb	r0, [r4,#0x0C]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		mov		r5, r0
		ldrb	r1, [r4,#0x12]
		ldr		r2, =SetupSubjectBattleUnitForStaff
		mov		lr, r2
		.short	0xF800
		
		@Set up coordinates for staff animation
		ldr		r0, =gTargetBattleUnit
		ldrb	r1, [r4,#0x13]
		strb	r1, [r0,#0x10]
		ldrb	r2, [r4,#0x14]
		strb	r2, [r0,#0x11]
		mov		r3, #0x73
		strb	r1, [r0,r3]
		mov		r3, #0x74
		strb	r2, [r0,r3]
		
		@The actual effect
		ldr		r0, =ForEachTileInAoe
		mov		lr, r0
		ldrb	r0, [r4,#0x13]
		ldrb	r1, [r4,#0x14]
		ldr		r2, =WardenAoeMap
		ldr		r3, =ApplyWardenBuffOnUnit
		.short	0xF800
		
		@Apply on staff user if applicable
		mov		r0, r5
		ldrb	r1, [r4,#0x13]
		ldrb	r2, [r4,#0x14]
		ldr		r3, =GetDistanceFromCoords
		mov		lr, r3
		.short	0xF800
		cmp		r0, #2
		bgt		GoToFinishUpItemBattle
		
			mov		r0, r5
			ldr		r1, =ApplyWardenBuffOnUnit
			mov		lr, r1
			.short	0xF800
		
		GoToFinishUpItemBattle:
		mov		r0, r6
		ldr		r1, =FinishUpItemBattle
		mov		lr, r1
		.short	0xF800
		ldr		r0, =BeginBattleAnimations
		mov		lr, r0
		.short	0xF800
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

