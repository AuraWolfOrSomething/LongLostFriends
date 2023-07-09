.thumb

.include "../IneptDefs.s"

.global InflictInept
.type InflictInept, %function


		InflictInept:
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
		
		@If you want to have non-100% staff accuracy, add code for that functionality here (look at ExecStatusStaff, 0802F010)
		
		
		
		@Get target res to calculate duration
		mov		r0, r6
		ldr		r1, =CalculateDebuffDuration
		mov		lr, r1
		.short	0xF800
		
		@If res is too high, treat it as a miss
		cmp		r0, #0
		bgt		NonZeroDuration
		
			ldr		r0, =gpCurrentRound
			ldr		r3, [r0]
			ldr		r2, [r3]
			lsl		r1, r2, #0x0D
			lsr		r1, #0x0D
			mov		r0, #2
			orr		r1, r0
			ldr		r0, =#0xFFF80000
			and		r0, r2
			orr		r0, r1
			str		r0, [r3]
			b		FinalizeIneptEffect
		
		NonZeroDuration:
		lsl		r3, r0, #4
		ldr		r0, =SetDebuffOrRemoveProtection
		mov		lr, r0
		mov		r0, r6
		mov		r1, #0 @where debuff is in unit debuff entry
		mov		r2, #0xF0 @how much of the byte is for this debuff
		.short	0xF800
		
		FinalizeIneptEffect:
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

