.thumb

.equ origin, 0x0802EC20
.include "../RestoreDefs.s"

.global ExecRestore
.type ExecRestore, %function


		ExecRestore:
		push	{r4-r6,r14}
		mov		r5, r0
		ldr		r4, =gActionData
		
		ldrb	r0, [r4,#0x0C]
		bl		bl_GetUnit
		ldrb	r1, [r4,#0x12]
		bl		bl_SetupSubjectBattleUnitForStaff
		
		ldrb	r0, [r4,#0x0D]
		bl		bl_GetUnit
		mov		r6, r0
		bl		bl_SetupTargetBattleUnitForStaff
		
		mov		r1, #0x30
		ldrb	r1, [r6,r1]
		mov		r0, #0x0F
		and		r0, r1
		cmp		r0, #0x0B
		bne		ClearStatus
		
			@Idk what this is for
			ldr		r0, [r6,#0x0C]
			ldr		r1, =UnitStateAnd
			and		r0, r1
			str		r0, [r6,#0x0C]
		
		ClearStatus:
		mov		r0, r6
		mov		r1, #0
		bl		bl_SetUnitNewStatus
		
		mov		r0, r6
		ldr		r1, =RestoreClearDebuffs
		mov		lr, r1
		.short	0xF800

		mov		r0, r5
		bl		bl_FinishUpItemBattle
		bl		bl_BeginBattleAnimations
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

