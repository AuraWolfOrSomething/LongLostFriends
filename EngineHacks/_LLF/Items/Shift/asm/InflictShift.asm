.thumb

.include "../ShiftDefs.s"

.global InflictShift
.type InflictShift, %function


		InflictShift:
		push	{r4-r6,r14}
		add		sp, #-0x04
		str		r0, [sp] @proc stuff or something
		ldr		r4, =gActionData
		ldrb	r0, [r4,#0x0C]
		ldr		r6, =GetUnit
		mov		lr, r6
		.short	0xF800
		mov		r5, r0 @staff user
		ldrb	r1, [r4,#0x12]
		ldr		r2, =SetupSubjectBattleUnitForStaff
		mov		lr, r2
		.short	0xF800
		
		ldrb	r0, [r4,#0x0D]
		mov		lr, r6
		.short	0xF800
		mov		r6, r0 @target
		ldr		r1, =SetupTargetBattleUnitForStaff
		mov		lr, r1
		.short	0xF800
		
		mov		r0, r6
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r1, [r0,#1] @where debuff is in unit debuff
		mov		r2, #0x0F
		and		r1, r2
		add		r1, #0x30
		strb	r1, [r0,#1]
		
		FinalizeShiftEffect:
		ldr		r0, [sp]
		ldr		r1, =FinishUpItemBattle
		mov		lr, r1
		.short	0xF800
		ldr		r0, =BeginBattleAnimations
		mov		lr, r0
		.short	0xF800
		add		sp, #0x04
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

