.thumb

.equ origin, 0
.include "../HealingDefs.s"

.global HealingItemEffect
.type HealingItemEffect, %function


		HealingItemEffect:
		push	{r4-r7,r14}
		mov		r6, r0
		mov		r7, r1
		ldr		r5, =gActionData
		ldrb	r0, [r5,#0x0C]
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		
		@instead of always doing 10 for vulnerary effect, go to item healing routine to get the amount
		mov		r1, r7
		ldr		r3, =ItemHealingRoutine
		mov		lr, r3
		.short	0xF800
		mov		r4, r0
		
		@Back to vanilla stuff
		ldr		r5, =gActionData
		ldrb	r0, [r5,#0x0C]
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		ldrb	r1, [r5,#0x12]
		ldr		r3, =SetupSubjectBattleUnitForStaff
		mov		lr, r3
		.short	0xF800
		
		ldrb	r0, [r5,#0x0C]
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		mov		r1, r4
		ldr		r3, =UnitTryHeal
		mov		lr, r3
		.short	0xF800
		
		ldrb	r0, [r5,#0x0C]
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		ldr		r3, =GetUnitCurrentHP
		mov		lr, r3
		.short	0xF800
		ldr		r1, =gpCurrentRound
		ldr		r2, [r1]
		ldr		r4, =gActiveBattleUnit
		ldrb	r1, [r4,#0x13]
		sub		r1, r0
		strb	r1, [r2,#0x03]
		
		ldrb	r0, [r5,#0x0C]
		ldr		r3, =GetUnit
		mov		lr, r3
		.short	0xF800
		ldr		r3, =GetUnitCurrentHP
		mov		lr, r3
		.short	0xF800
		strb	r0, [r4,#0x13]
		add		r4, #0x4A
		mov		r0, #0x6C
		strh	r0, [r4]
		
		mov		r0, r6
		ldr		r3, =FinishUpItemBattle
		mov		lr, r3
		.short	0xF800
		ldr		r3, =BeginBattleAnimations
		mov		lr, r3
		.short	0xF800
		
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

