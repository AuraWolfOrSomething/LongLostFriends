.thumb

.include "../BattleStatFormulaDefs.s"

.global AttackSpeedFormula
.type AttackSpeedFormula, %function

		AttackSpeedFormula:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, r1
		
		@lsr		r3, r3, #2 @Skl/4
		@add		r6, r3, r2 @Skl/4 + Con
		mov		r6, r2
		
		@Lower AS penalty by 1 for each point of Skl after 20 (e.g. Skl of 23 = -3 to Wt)
		sub		r3, #20
		cmp		r3, #0
		ble		GoToGetWeaponWeight
		
			add		r6, r3

		GoToGetWeaponWeight:
		add		r0, #0x4A
		ldrh	r0, [r0]
		ldr		r3, =GetWeaponWeight
		mov		lr, r3
		.short	0xF800
		sub		r0, r6	@Wt - Con (- Skl bonus if applicable)
		cmp		r0, #0
		bgt		CheckForGems
		
			mov		r0, #0
			b		ApplyPenalty
		
		CheckForGems:
		mov		r1, r4
		ldr		r3, =GemLowerASPenalty
		mov		lr, r3
		.short	0xF800
		
		ApplyPenalty:
		sub		r5, r0 @AS = Spd - Wt penalty (if any)
		lsl		r1, r5, #0x10
		cmp		r1, #0
		bge		StoreAS
		
			mov		r5, #0
		
		StoreAS:
		mov		r0, r4
		add		r0, #0x5E
		strh	r5, [r0]
		pop		{r4-r6}
		pop		{r0}
		bx		r0

