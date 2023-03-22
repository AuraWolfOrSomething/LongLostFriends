.thumb

.global prNocStatBoost
.type prNocStatBoost, %function


		prNocStatBoost:
		@As enemy/npc generics are loaded by events, they can have a skill stored with specific ones (doesn't have to be shared with all units of the same id)
		@...but this skill is stored where Fatigue is for player units, so limit rest bonuses to only player units
		ldrb	r3, [r1,#0xB]
		lsr		r3, #6
		cmp		r3, #0
		bne		ReturnValue

			@load unit fatigue
			mov		r2, #0x3B
			ldrb	r2, [r1,r2]
		
			@check if rested bonus is set; if not, skip
			mov		r3, #0x20
			tst		r2, r3
			beq		ReturnValue
	
				@if set, +1 to stat
				add		r0, #1
	
			@check for 2 or 3+ undeployed chapters for another +1
			mov		r3, #0x80
			tst		r2, r3
			beq		ReturnValue
		
				add		r0, #1
		
			@check for 3+ undeployed chapters for another +1
			mov		r3, #0xC0
			tst		r2, r3
			beq		ReturnValue
		
				add		r0, #1
		
		ReturnValue:
		bx		r14

