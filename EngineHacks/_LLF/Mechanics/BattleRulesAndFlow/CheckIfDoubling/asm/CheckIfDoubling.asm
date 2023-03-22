.thumb

.include "../CheckIfDoublingDefs.s"

.global CheckIfDoubling
.type CheckIfDoubling, %function

@mostly copied from wary fighter

@r0,r1 are stack pointers that will contain attacker and defender struct
@returns a bool for can double


		CheckIfDoubling:
		push  	{r4-r7,r14}
		mov   	r4,r0
		ldr   	r5,=gActiveBattleUnit
		ldr   	r6,=gTargetBattleUnit
		mov   	r7,r1
		
		@Not using Wary Fighter, so this can be commented
		@ldr   	r5,=SkillTester
		@mov   	r14,r5
		@ldr   	r6,gTargetBattleUnit
		@mov   	r0,r6
		@ldr   	r1, =WaryFighterLink
		@ldrb  	r1, [r1]
		@.short  0xF800
		@cmp   	r0,#0x0 @does the defender have wary fighter?
		@bne   	RetFalse
		@mov   	r14,r5
		@ldr   	r5,gActiveBattleUnit
		@mov   	r0,r5
		@ldr   	r1, =WaryFighterLink
		@ldrb  	r1, [r1]
		@.short  0xF800
		@cmp   	r0,#0x0 @does the attacker?
		@bne   	RetFalse
		
		@Check if either unit has a weapon with Distort's weapon effect
		mov		r0,r5
		add   	r0,#0x4A
		ldrh  	r0,[r0]
		ldr	  	r3,=GetItemWeaponEffect
		mov	  	lr,r3
		.short 	0xF800
		
		cmp		r0,#0xD
		beq		DistortWeaponEffect
		
			mov		r0,r6
			add		r0,#0x4A
			ldrh  	r0,[r0]
			ldr	  	r3,=GetItemWeaponEffect
			mov	  	lr,r3
			.short 	0xF800
			
			cmp		r0,#0xD
			beq		DistortWeaponEffect
		
				mov   	r3,#0x5E
				ldsh  	r2,[r6,r3]    @defender's AS
				cmp   	r2,#0xFA
				bgt   	RetFalse    @something about snags, possibly. Or just IntSys being IntSys.
				
					ldsh  	r3,[r5,r3]    @attacker's AS
					sub   	r1,r3,r2    @Attacker-defender
					cmp   	r1,#0
					blt   	DefDoubAtk
				
						cmp   	r1,#3
						ble   	RetFalse
						
							str   	r5,[r4]
							str   	r6,[r7]
							b   	Label1
							
						DefDoubAtk:
						sub   	r1,r2,r3
						cmp   	r1,#3
						ble   	RetFalse
						
							str   	r6,[r4]
							str   	r5,[r7]
							b		Label1
		
		DistortWeaponEffect: @if unit has -4 AS compared to enemy, they double attack
		mov   	r3,#0x5E
		ldsh  	r2,[r6,r3]    @defender's AS
		cmp   	r2,#0xFA
		bgt   	RetFalse    @something about snags, possibly. Or just IntSys being IntSys.
		
			ldsh  	r3,[r5,r3]    @attacker's AS
			mov		r0,#3
			neg		r0,r0
			sub   	r1,r3,r2    @Attacker-defender
			cmp   	r1,#0
			bgt   	DistortDefDoubAtk
		
				cmp   	r1,r0
				bge   	RetFalse
		
					str   	r5,[r4]
					str   	r6,[r7]
					b   	Label1
		
				DistortDefDoubAtk:
				neg		r1,r1
				cmp		r1,r0
				bge		RetFalse
			
					str   	r6,[r4]
					str   	r5,[r7]
		
		Label1:
		ldr		r7, =NeverFollowUpConditionsList
		
		@loop through NeverFollowUpConditionsList
		  @if r0 ever returns as 1, can't double
		  @if end of the list is reached, can double
		
		LoadNextCheck:
		ldr		r3, [r7]
		cmp		r3, #0
		beq		PossibleToDoubleAttack
		
			ldr		r0, [r4]
			mov		lr, r3
			.short	0xF800
			cmp		r0, #1
			beq		RetFalse
		
				add		r7, #4
				b		LoadNextCheck
		
		PossibleToDoubleAttack:
		mov		r0, #1
		b		End
		
		RetFalse:
		mov   	r0, #0
		
		End:
		pop   {r4-r7}
		pop   {r1}
		bx    r1

		.align
		.ltorg

