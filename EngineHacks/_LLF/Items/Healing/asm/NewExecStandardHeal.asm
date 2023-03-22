.thumb

.equ origin, 0x0802EB98
.include "../HealingDefs.s"

.global NewExecStandardHeal
.type NewExecStandardHeal, %function

@r4 = gActionData
@r5 = healer -> target unit as battle unit defender
@r6 = healed amount
@r7 = target unit


		NewExecStandardHeal:
		push	{r4-r7,r14}
		push	{r0} @don't need this variable until the end; we can make do with r4-r7 if we do this
		
		ldr		r4, =gActionData
		ldrb	r0, [r4,#0x0C]
		bl		blGetUnit
		mov		r5, r0
		
		ldrb	r1, [r4,#0x12]
		bl		blSetupSubjectBattleUnitForStaff
		ldrb	r0, [r4,#0x0D]
		bl		blGetUnit
		mov		r7, r0
		bl		blSetupTargetBattleUnitForStaff
		
		ldrb	r1, [r4,#0x12]
		lsl		r1, #1
		add		r2, r5, r1
		add		r2, #0x1E
		ldrh	r1, [r2]
		mov		r0, r5
		mov		r2, r7
		bl		blGetItemHealAmount
		mov		r6, r0
		
		mov		r0, r7
		mov		r1, r6
		bl		blUnitTryHeal
		
		mov		r0, r7
		bl		blGetUnitCurrentHP
		ldr		r1, =gpCurrentRound
		ldr		r2, [r1]
		ldr		r5, =gTargetBattleUnit
		ldrb	r1, [r5,#0x13]
		sub		r1, r0
		strb	r1, [r2,#3]
		
		mov		r0, r7
		bl		blGetUnitCurrentHP
		strb	r0, [r5,#0x13]
		
		pop		{r0} @we finally need this
		bl		blFinishUpItemBattle
		bl		blBeginBattleAnimations
		
		pop		{r4-r7}
		pop		{r0}
		bx		r0


