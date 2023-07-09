@mostly references Fortify

.thumb

.include "../AbsorbDefs.s"

.global AbsorbEffect
.type AbsorbEffect, %function


		AbsorbEffect:
		push	{r4-r7,r14}
		add		sp, #-0x04
		mov		r7, r0
		ldr		r4, =gActionData
		ldrb	r0, [r4,#0x0C]
		ldr		r6, =GetUnit
		mov		lr, r6
		.short	0xF800
		mov		r5, r0 @staff user
		ldrb	r1, [r4,#0x12] @item slot id
		ldr		r2, =SetupSubjectBattleUnitForStaff
		mov		lr, r2
		.short	0xF800
		
		ldr		r0, =GetPlayerLeaderUnitId
		mov		lr, r0
		.short	0xF800
		ldr		r1, =GetUnitByCharId
		mov		lr, r1
		.short	0xF800
		ldr		r1, =SetupTargetBattleUnitForStaff
		mov		lr, r1
		.short	0xF800
		
		mov		r0, r5
		ldrb	r1, [r4,#0x12]
		lsl		r1, #1
		add		r1, #0x1E
		ldrh	r1, [r0,r1]
		ldr		r2, =MakeTargetListForAbsorb
		mov		lr, r2
		.short	0xF800
		
		mov		r0, r5
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		str		r0, [sp]
		
		ldr		r0, =GetTargetListSize
		mov		lr, r0
		.short	0xF800
		mov		r5, r0 @total number of units absorb will affect
		mov		r4, #0
		cmp		r4, r5
		bge		FinalizeAbsorbEffect @failsafe I guess
		
			LoopThroughTargetList:
			mov		r0, r4
			ldr		r1, =GetTarget
			mov		lr, r1
			.short	0xF800
			ldrb	r0, [r0,#2]
			mov		lr, r6
			.short	0xF800
			ldr		r1, =GetDebuffs
			mov		lr, r1
			.short	0xF800
			ldr		r1, [sp]
			ldr		r2, =AbsorbTransferTargetDebuffs
			mov		lr, r2
			.short	0xF800
			add		r4, #1
			cmp		r4, r5
			blt		LoopThroughTargetList
				
		FinalizeAbsorbEffect:
		
		@Set Absorb debuff on staff user
		ldr		r0, [sp]
		ldrb	r1, [r0,#3]
		mov		r2, #1
		orr		r1, r2
		strb	r1, [r0,#3]
		
		@Remove buffs on staff user
		mov		r1, #0
		strh	r1, [r0,#4]
		
		mov		r0, r7
		ldr		r1, =FinishUpItemBattle
		mov		lr, r1
		.short	0xF800
		ldr		r0, =BeginBattleAnimations
		mov		lr, r0
		.short	0xF800
		add		sp, #0x04
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

