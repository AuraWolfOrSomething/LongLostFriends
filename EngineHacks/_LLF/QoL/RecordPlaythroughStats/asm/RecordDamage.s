.thumb

.include "RecordPlaythroughStatsDefinitions.asm"

.global RecordDamage
.type RecordDamage, %function

@TODO: register optimization (definitely do not need 8 registers ready)

		RecordDamage:
		push	{r4-r7}
		mov		r4, r0
		mov		r5, r1
		
		@vanilla stuff
		
		@level
		ldrb	r0, [r5,#8]
		strb	r0, [r4,#8]
		
		@exp
		ldrb	r0, [r5,#9]
		strb	r0, [r4,#9]
		
		@current hp
		@r7 = oldHp - newHp
		ldrb	r1, [r4,#0x13]
		ldrb	r0, [r5,#0x13]
		sub		r7, r1, r0
		strb	r0, [r4,#0x13]
		
		@if no damage to record, skip to End
		cmp		r7, #0
		beq		End
		
		ldr		r3, =PlaythroughStatsRAM
		
		@check unit's allegiance
		  @if player, add to damage received (if negative, add to damage healed)
		  @if not, check if attacker has player allegiance
		    @if so, add to damage dealt on player phase (if 0 or negative, skip)
			@if not, check if defender has player allegiance
			  @if so, add to damage dealt on enemy phase (if 0 or negative, skip)
			  @if not, don't add to any record
		
		ldrb	r0, [r4,#0xB]
		lsr		r0, #6
		cmp		r0, #0
		beq		AddToDamageReceived
		
		ldr		r2, =BattleUnitAttacker
		ldrb	r0, [r2,#0xB]
		lsr		r0, #6
		cmp		r0, #0
		beq		AddToDamageDealtPlayerPhase
		
		ldr		r2, =BattleUnitDefender
		ldrb	r0, [r2,#0xB]
		lsr		r0, #6
		cmp		r0, #0
		bne		End
		
		@AddToDamageDealtEnemyPhase
		add		r3, #0x3E
		b		CheckForOverflow
		
		AddToDamageDealtPlayerPhase:
		add		r3, #0x3C
		b		CheckForOverflow
		
		AddToDamageReceived:
		cmp		r7, #0
		blt		AddToDamageHealed
		
		add		r3, #0x40
		b		CheckForOverflow
		
		AddToDamageHealed:
		neg		r7, r7
		add		r3, #0x42
		
		CheckForOverflow:
		ldrh	r0, [r3]
		add		r0, r7
		ldr		r1, =MaxAccRecStat
		cmp		r0, r1
		ble		StoreNewDamageRecord
		
		mov		r0, r1
		
		StoreNewDamageRecord:
		strh	r0, [r3]
		
		End:
		pop		{r4-r7}
		bx		r14

