@Vanilla formula starts with loading weapon might and including weapon triangle, checking for effectiveness, reloading weapon might, reapplying weapon triangle (twice if effective), adding user power, and then checking for Stone (0 Atk if it is Stone)

@New formula: check for Stone -> save user power and weapon might -> apply weapon triangle -> get effectiveness -> subtract might if weapon is penalized 

.thumb

.include "../BattleStatFormulaDefs.s"

.global AttackFormula
.type AttackFormula, %function

@When this routine is called:
  @r0 = User
  @r1 = Opponent
  @r2 = User's Pow

@r4 = Attack (current calculated value)
@r5 = Effectiveness
@r6 = User
@r7 = Equipped item
@sp = Opponent
@sp,#0x04 = Item Might 
@sp,#0x08 = Number of Half Guards


		AttackFormula:
		push 	{r4-r7,r14}
		add		sp, #-0x0C
		mov		r6, r0
		str		r1, [sp]
		mov		r7, r6
		add		r7, #0x48
		
		@Pow
		mov		r4, r2
		ldrb	r0, [r7]
		
		@Check if item is stone;
		  @If so, set final attack to 0
		  @If not, get item might
		cmp		r0, #0xB5
		bne		GoToGetItemMight 
		
			mov		r4, #0
			b		StoreFinalAtk
		
		GoToGetItemMight:
		ldrh	r0, [r7]
		ldr		r3, =GetItemMight
		mov		lr, r3
		.short	0xF800
		
		@Weapon Triangle
		mov		r2, #0x54
		ldsb	r2, [r6,r2]
		add		r0, r2 @Might + WTA/WTD
		str		r0, [sp,#4]
		
		@credit to Teq for slayer redux and effectiveness redux (mostly copy-pasted
		@go through slayer and effectiveness routines and use the highest multiplier
		
		mov		r0, r6
		ldr		r1, [sp]
		ldr		r3, =IsSlayerApplied
		mov		lr, r3
		.short	0xF800
		mov		r5, #0
		cmp		r0, #0
		beq		GoToIsWeaponEffectiveAgainst
		
			mov		r5, r0
		
		GoToIsWeaponEffectiveAgainst:
		ldrh	r0, [r7]
		ldr		r1, [sp]
		ldr		r3, =IsWeaponEffectiveAgainst
		mov		lr, r3
		.short	0xF800
		
		cmp		r0, #0
		beq		CheckIfAnyDefender
		
			@use weapon effectiveness if greater than slayer effectiveness
			cmp		r0, r5
			ble		CalcHalfGuards 
		 
				mov		r5, r0
		
		CalcHalfGuards:
		@Get number of Half Guards opponent has
		ldr		r0, [sp]
		ldr		r1, =HalfGuardIDLink
		ldrb	r1, [r1]
		ldr		r3, =CountCopiesOfItem
		mov		lr, r3
		.short	0xF800
		str		r0, [sp,#8]
		
		@See if opponent has Expertise
		ldr		r0, [sp]
		ldr		r1, =ExpertiseIDLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		ldr		r1, [sp,#8]
		add		r0, r1
		
			cmp		r0, #0
			beq		WhetstoneCheck
		
				@1 Half Guard or Expertise
				sub		r1, r5, #2
				lsr		r1, #1
				sub		r5, r1
				cmp		r0, #1
				ble		WhetstoneCheck
		
					@Expertise & Half Guard or at least 2 Half Guards
					sub		r5, r1
					b		WhetstoneCheck
		
		CheckIfAnyDefender:
		ldr		r1, [sp]
		ldr		r0, [r1,#4]
		cmp		r0, #0 @if no defender (no battle forecast, just looking at the unit's stats alone), then no penalty
		beq		NoMightPenalty
		
			@Check if item has any effectiveness; if not effective against anything, then no penalty
			ldrh	r0, [r7]
			ldr		r3, =GetItemEffectivenessPtr
			mov		r14, r3
			.short	0xF800
			cmp		r0, #0
			beq		WhetstoneCheck
		
				@Check if item is on exception list (mainly bows); if so, then no penalty
				ldrb	r0, [r7]
				ldr		r1, =MightPenaltyExceptionList

					LoopThroughList:
					ldrb	r2, [r1]
					cmp		r2, #0
					beq		MightPenalty @if reached the end of the table and item not found, then Mt will have a penalty
		
						cmp		r2, r0
						beq		NoMightPenalty
						
							add		r1, #1
							b		LoopThroughList
		
		MightPenalty:
		ldr		r0, [sp,#4]
		@lsr		r0, r0, #1
		sub		r0, #9
		b		AddFinalWeaponMight
		
		NoMightPenalty:
		mov		r0, #0
		b		LoadWeaponMight

		WhetstoneCheck:
		mov		r0, r6
		mov		r1, r5
		ldrb	r2, [r7]
		ldr		r3, =WhetstoneDamage
		mov		lr, r3
		.short	0xF800
		
		LoadWeaponMight:
		ldr		r1, [sp,#4]
		add		r0, r1
		cmp		r5, #0
		beq		AddFinalWeaponMight
		
			mul		r0, r5
			lsr		r0, #1
			
		AddFinalWeaponMight:
		add		r4, r0
		
		StoreFinalAtk:
		mov		r0, r6
		add		r0, #0x5A
		strh	r4, [r0]
		add		sp, #0x0C
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


