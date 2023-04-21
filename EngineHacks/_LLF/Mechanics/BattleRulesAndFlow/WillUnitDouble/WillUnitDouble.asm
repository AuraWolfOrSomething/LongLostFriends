.thumb

.equ GetItemWeaponEffect, 0x08017724

.global WillUnitDouble
.type WillUnitDouble, %function

@r0 = unit (attacker or defender)
@r1 = opponent (attacker or defender)


		WillUnitDouble:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r1
		
		@Check for Snag?
		mov		r0, #0x5E
		ldsh	r7, [r5,r0]
		cmp		r7, #0xFA
		bgt		RetFalse
		
			ldsh	r6, [r4,r0]
		
			@Check for Distort
			mov		r0, #0x4A
			ldrh	r0, [r4,r0]
			ldr		r1, =GetItemWeaponEffect
			mov	  	lr, r1
			.short 	0xF800
			cmp		r0, #0x0D
			beq		DistortWeaponEffect
			
				mov		r0, #0x4A
				ldrh	r0, [r5,r0]
				ldr		r1, =GetItemWeaponEffect
				mov	  	lr, r1
				.short 	0xF800
				cmp		r0, #0x0D
				bne		CheckAttackSpeedDifference
				
					DistortWeaponEffect:
					neg		r6, r6
					neg		r7, r7
				
		CheckAttackSpeedDifference:
		sub		r6, r7
		cmp		r6, #4
		blt		RetFalse
		
			ldr		r6, =NeverFollowUpConditionsList
			
		LoopThroughList:
		ldr		r2, [r6]
		cmp		r2, #0
		beq		RetTrue
		
			ldr		r0, [r4]
			ldr		r1, [r5]
			mov		lr, r2
			.short	0xF800
			cmp		r0, #1
			beq		RetFalse
			
				add		r6, #4
				b		LoopThroughList
		
		RetTrue:
		mov		r0, #1
		b		End
		
		RetFalse:
		mov		r0, #0
		
		End:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

