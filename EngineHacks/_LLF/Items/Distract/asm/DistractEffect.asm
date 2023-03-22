.thumb

.include "../DistractDefs.s"

.global DistractEffect
.type DistractEffect, %function


		DistractEffect:
		push	{r4-r7,r14}
		mov		r6, r0
		ldr		r4, =gActionData
		ldrb	r0, [r4,#0x0C]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		mov		r5, r0
		ldrb	r1, [r4,#0x12]
		ldr		r2, =SetupSubjectBattleUnitForStaff
		mov		lr, r2
		.short	0xF800
		ldrb	r0, [r4,#0x0D]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		mov		r7, r0
		
		@Set debuff
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r1, [r0,#2]
		mov		r2, #2
		orr		r1, r2
		strb	r1, [r0,#2]
		
		@Get coords
		ldrb	r0, [r4,#0x13] @x-coord
		ldrb	r1, [r4,#0x14] @y-coord
		
		@Store coords (for animation)
		ldr		r2, =gTargetBattleUnit
		strb	r0, [r2,#0x10]
		strb	r1, [r2,#0x11]
		add		r2, #0x73
		strb	r0, [r2]
		strb	r1, [r2,#1]
		
		@Store coords (so target unit moves there)
		lsl		r1, #6
		add		r0, r1
		ldr		r1, =gEventSlot1
		str		r0, [r1]
		
		GoToFinishUpItemBattle:
		mov		r0, r6
		ldr		r1, =FinishUpItemBattle
		mov		lr, r1
		.short	0xF800
		ldr		r0, =BeginBattleAnimations
		mov		lr, r0
		.short	0xF800
		
		@Store emotion bubble location
		ldrb	r0, [r7,#0x10] @x-coord
		ldrb	r1, [r7,#0x11] @y-coord
		lsl		r1, #16
		add		r0, r1
		ldr		r1, =gEventSlotB
		str		r0, [r1]
		
		@Store target unit
		ldr		r1, =gEventSlot2
		str		r0, [r1]
		
		@Play event
		ldr		r0, =DistractEffectEvent
		mov		r1, #1
		ldr		r2, =CallMapEventEngine
		mov		lr, r2
		.short	0xF800
		
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

