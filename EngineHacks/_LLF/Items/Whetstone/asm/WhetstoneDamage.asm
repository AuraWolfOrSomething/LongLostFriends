.thumb

.global WhetstoneDamage
.type WhetstoneDamage, %function

.equ UnitHasItem, 0x080179F8
.equ GetItemWType, 0x08017548
.equ GetItemAttributes, 0x0801756C


		WhetstoneDamage:
		push	{r4-r7,r14}
		mov		r4, r0 @user
		mov		r5, r2 @wielded weapon
		mov		r6, r1 @effectiveness
		mov		r7, #0 @return result
		
		@check if unit has whetstone
		  @if not, skip
		ldr		r1, =WhetstoneIDLink
		ldrb	r1, [r1]
		ldr		r3, =UnitHasItem
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@check if attacker has A or S rank with wielded weapon
			  @if not, skip
			mov		r0, r5
			ldr		r3, =GetItemWType
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0xFF
			beq		End
		
				mov		r1, r4
				add		r1, #0x28
				add		r1, r0
				ldrb	r0, [r1]
				cmp		r0, #181 @A rank WEXP requirement
				blt		End
		
					@get damage boost if at least one of the following is true:
					  @effectiveness greater than x1
					  @attacker has reaver with WTA
					cmp		r6, #0
					bgt		ReturnDamageBoost
		
						mov		r0, r5
						ldr		r3, =GetItemAttributes
						mov		lr, r3
						.short	0xF800
						mov		r1, #0x80
						lsl		r1, #1
						tst		r0, r1
						beq		End
		
							mov		r0, #0x54
							ldsb	r0, [r4,r0]
							cmp		r0, #0
							ble		End
		
		ReturnDamageBoost:
		ldr		r0, =WhetstoneDamageBoostLink
		ldrb	r7, [r0]
		
		End:
		mov		r0, r7
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


