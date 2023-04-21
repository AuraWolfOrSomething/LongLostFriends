
.thumb

@ r0 = Unit
@ r1 = Opponent (attacking r0)
@ r2 = Unit's Def
@ r3 = Unit's Res

.include "../BattleStatFormulaDefs.s"

.global DefensiveStatFormula
.type DefensiveStatFormula, %function


		DefensiveStatFormula:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r2
		mov		r6, r3
		
		CheckIfMagicWeapon:
		add		r1, #0x48
		ldrh	r0, [r1]
		ldr		r3, =GetItemAttributes
		mov		lr, r3
		.short	0xF800
		mov		r7, #2
		mov		r1, #0x40
		tst		r1, r0
		bne		CheckIfUnitIsUtilizingHhb
		
			@Check if tome
			mov		r1, #0x02
			tst		r1, r0
			bne		CheckIfUnitIsUtilizingHhb
			
				mov		r7, #0
		
		CheckIfUnitIsUtilizingHhb:
		mov		r0, r4
		ldr		r1, =DoesUnitNeedHhbForCurrentTerrain
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		LoadTerrainThenStat
		
			mov		r0, #0
			b		CheckIfDefOrRes
		
		LoadTerrainThenStat:
		@load approriate terrain bonus + approriate stat
		mov		r0, r4
		add		r0, #0x56
		ldrb	r0, [r0,r7]
		
		CheckIfDefOrRes:
		cmp		r7, #0
		bne		AddRes
		
			@Add Def
			mov		r1, r5
			b		AddTerrainAndStat
		
		AddRes:
		mov		r1, r6
		
		AddTerrainAndStat:
		add		r0, r1
		mov		r1, r4
		add		r1, #0x5C
		strh	r0, [r1]
		
		pop		{r4-r7}
		pop		{r0}
		bx		r0

		.align
		.ltorg

