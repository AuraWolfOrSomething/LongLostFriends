.thumb

@r0 = User
@r1 = Skl
@r2 = Lck

.include "../BattleStatFormulaDefs.s"

.global HitFormula
.type HitFormula, %function


		HitFormula:
		push	{r4-r5,r14}
		mov		r4, r0
		lsl		r5, r2, #0x01 @r5 = Skl*2

		AddLckModifier:
		lsr		r1, r3, #0x1F
		add		r3, r1
		asr		r3, r3, #1 @Lck/2
		add		r5, r3 @Skl*2 + Lck/2
		
		@Weapon Hit
		mov		r0, r4
		add		r0, #0x48
		ldrh	r0, [r0]
		ldr		r3, =GetItemHit 
		mov		lr, r3
		.short	0xF800
		add		r5, r0 @Skl*2 + Lck/2 + Weapon Hit
		
		@Weapon Triangle modifier
		mov		r0, r4
		add		r0, #0x53
		ldrb	r0, [r0]
		lsl		r0, r0, #0x18
		asr		r0, r0, #0x18
		add		r5, r0 @Skl*2 + Lck/2 + Weapon Hit + WTBonus
		
		@Store
		mov		r0, r4
		add		r0, #0x60
		strh	r5, [r0]
		
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

