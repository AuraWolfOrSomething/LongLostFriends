.thumb

.equ origin, 0
.include "../ExperienceDefs.s"

.global ExperienceForDamage
.type ExperienceForDamage, %function


		ExperienceForDamage:
		push	{r4-r7,r14}
		mov		r6, r0
		mov		r4, r1
		
		@Get player unit's lv
		ldr		r3, =GetUnitActualLevel
		mov		lr, r3
		.short	0xF800
		mov		r5, r0
		
		@Get enemy unit's lv
		mov		r0, r4
		ldr		r3, =GetUnitActualLevel
		mov		lr, r3
		.short	0xF800
		
		@08BC8132
		sub		r5, r5, r0
		lsl		r0, r5, #3
		mov		r1, #60
		sub		r0, r1, r0
		cmp		r0, #0x00
		bge		DivideExpBy4
		
			mov		r0, #0
		
		DivideExpBy4:
		@mov		r1, #3
		@swi		0x6
		lsr		r0, #2
		
		@get player unit's class power
		ldr		r2, [r6,#0x04]
		mov		r1, #0x1A
		ldsb	r1, [r2,r1]
		sub		r1, #0x03
		lsl		r2, r1, #0x02
		add		r1, r2
		sub		r7, r0, r1 @exp = exp + (classPower - 3) * 5
		
		@check if novice weapon; if so, add 10 exp
		mov		r0, r6
		add		r0, #0x4A
		ldrh	r0, [r0]
		ldr		r3, =GetItemWeaponEffect
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0x0F
		bne		ReturnDamageExp
		
			add		r7, #10
		
		ReturnDamageExp:
		mov		r0, r7
		pop		{r4-r7}
		pop		{r1}
		bx		r1

