.thumb

.global PostCombatPerfectus
.type PostCombatPerfectus, %function


		PostCombatPerfectus:
		push	{r4-r7,r14}
		
		@Check if combat just happened
		  @If not, skip
		ldrb	r0, [r6,#0x11]
		cmp		r0, #2
		bne		End
		
		ldr		r6, =PerfectusIDLink
		mov		r7, #0
		mov		r0, r4 @Attacker
		
		PerfectusCheck:
		ldrb	r1, [r6]
		mov		r2, #1
		ldr		r3, =FindItemInUnitInventory
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		CheckDefender
		
			ldrb	r1, [r0,#1]
			sub		r1, #2 @lower durability by 2
			cmp		r1, #0
			bge		StoreNewDurability
		
				mov		r1, #0
		
			StoreNewDurability:
			strb	r1, [r0,#1]
		
			CheckDefender:
			add		r7, #1
			cmp		r7, #2
			bge		End
		
				mov		r0, r5
				b		PerfectusCheck
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		
		.align
		.ltorg

