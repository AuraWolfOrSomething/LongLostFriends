.thumb

.global DivineInterventionCheck
.type DivineInterventionCheck, %function

.global DivineInterventionProc
.type DivineInterventionProc, %function

.global DivineInterventionPostBattle
.type DivineInterventionPostBattle, %function

.equ gUnitLookup, 0x0859A5D0
.equ UnitState, 0x0001002C
.equ gBattleStats, 0x0203A4D4


@mostly copied from MapMain_UpdateUnitStatus

		DivineInterventionCheck:
		push	{r4-r7,r14}
		mov		r7, r1 @whether we're looking for a unit that hasn't activated divine intervention (0) or has activated it (1)
		mov		r1, #0xC0
		and		r0, r1
		add		r5, r0, #1 @unit faction
		mov		r6, r0
		add		r6, #0x40 @stop once all units from this faction have been checked
		
		CheckForNextUnit:
		ldr		r1, =gUnitLookup
		mov		r0, #0xFF
		and		r0, r5
		lsl		r0, #2
		add		r0, r1
		ldr		r4, [r0]
		cmp		r4, #0
		beq		AddToFactionCount
		
			ldr		r0, [r4]
			cmp		r0, #0
			beq		AddToFactionCount
			
				ldr		r0, [r4,#0x0C]
				ldr		r1, =UnitState
				tst		r0, r1
				bne		AddToFactionCount
				
					mov		r0, r4
					ldr		r1, =DivineInterventionIDLink
					ldrb	r1, [r1]
					ldr		r3, =SkillTester
					mov		lr, r3
					.short	0xF800
					cmp		r0, #0
					beq		AddToFactionCount
					
						mov		r0, r4
						ldr		r1, =GetDebuffs
						mov		lr, r1
						.short	0xF800
						mov		r4, r0
						ldr		r0, =GetSkillUsageByte
						mov		lr, r0
						.short	0xF800
						lsr		r2, r0, #8 @how much of the byte is for skill usage
						mov		r1, #0xFF
						and		r0, r1 @location in unit debuff entry
						add		r0, r4
						ldrb	r1, [r0]
						
						@if unit already used in a past battle, skip
						cmp		r1, r2
						beq		AddToFactionCount
						
							@if we need the unit that just activated the skill or not
							cmp		r7, #0
							beq		End
							
								cmp		r1, #0
								bne		End
		
		AddToFactionCount:
		add		r5, #1
		cmp		r5, r6
		blt		CheckForNextUnit
		
			mov		r0, #0 @No eligible unit found
		
		End:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-------------------------------------
@DivineInterventionProc
@-------------------------------------

@mostly taken from Miracle

		DivineInterventionProc:
		push	{r4-r6,r14}
		mov		r4, r0 @unit doing damage
		mov		r5, r1 @unit taking damage
		@mov		r6, r2 @battle buffer
		mov		r6, r3 @battle data
		
		@skip all of this unless a battle is actually happening
		ldr		r0, =gBattleStats
		ldrh	r1, [r0]
		mov		r0, #2
		tst		r0, r1
		bne		ReturnToProcLoop
		
			@if attacking unit missed, don't need to check
			ldr		r0, [r2]
			lsl		r0, #0xD
			lsr		r0, #0xD
			mov		r1, #2
			tst		r0, r1
			bne		ReturnToProcLoop
			
				@check if incoming attack does lethal damage
				mov		r0, #4
				ldrsh	r0, [r6,r0] @damage dealt
				ldrb	r1, [r5,#0x13] @current hp
				cmp		r0, r1
				blt		ReturnToProcLoop
				
					@do not activate for walls or snags
					ldr		r0, [r5]
					ldrb	r0, [r0,#0x04]
					cmp		r0, #0xFE
					bge		ReturnToProcLoop
					
						@check if the unit taking damage has an ally with an unused Divine Intervention
						ldrb	r0, [r5,#0x0B]
						mov		r1, #0
						ldr		r2, =DivineInterventionCheck
						mov		lr, r2
						.short	0xF800
						cmp		r0, #0
						beq		ReturnToProcLoop
						
							@set damage to current hp - 1
							ldrb	r1, [r5,#0x13]
							sub		r1, #1
							strh	r1, [r6,#4]
							
							@increment skill counter on unit
							ldr		r1, =IncrementSkillUsage
							mov		lr, r1
							.short	0xF800
		
		ReturnToProcLoop:
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-------------------------------------
@DivineInterventionPostBattle
@-------------------------------------

		DivineInterventionPostBattle:
		push	{r4-r7,r14}
		
		@If something other than combat just happened, skip
		ldrb	r0, [r6,#0x11]
		cmp		r0, #2
		bne		ReturnToPostBattleLoop
		
			@Check if unit was left at 0 HP
			ldrb	r0, [r4,#0x13]
			cmp		r0, #1
			bne		CheckDefenderFaction
			
				ldrb	r0, [r4,#0x0B]
				mov		r1, #1
				ldr		r2, =DivineInterventionCheck
				mov		lr, r2
				.short	0xF800
				cmp		r0, #0
				beq		CheckDefenderFaction
				
					@this unit can no longer activate this skill for the rest of the chapter
					ldrb	r1, [r0]
					mov		r2, #0x0F
					orr		r1, r2
					strb	r1, [r0]
			
			CheckDefenderFaction:
			ldrb	r0, [r5,#0x13]
			cmp		r0, #1
			bne		ReturnToPostBattleLoop
			
				ldrb	r0, [r5,#0x0B]
				mov		r1, #1
				ldr		r2, =DivineInterventionCheck
				mov		lr, r2
				.short	0xF800
				cmp		r0, #0
				beq		ReturnToPostBattleLoop
					
					@this unit can no longer activate this skill for the rest of the chapter
					ldrb	r1, [r0]
					mov		r2, #0x0F
					orr		r1, r2
					strb	r1, [r0]
		
		ReturnToPostBattleLoop:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

