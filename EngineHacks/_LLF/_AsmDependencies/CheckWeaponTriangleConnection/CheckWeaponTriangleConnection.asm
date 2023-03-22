.thumb

.global CheckWeaponTriangleConnection
.type CheckWeaponTriangleConnection, %function


		CheckWeaponTriangleConnection:
		push	{r4-r6,r14}
		mov		r3, r0
		mov		r5, r0
		add		r3, #0x50
		mov		r4, r1
		mov		r6, r1
		add		r4, #0x50
		ldr		r2, =WeaponAndMagicTriangles
		b		CheckForTriangleConnection
		
		GoToNextEntry:
		add		r2, #4
		
		CheckForTriangleConnection:
		mov		r0, #0
		ldsb	r0, [r2,r0]
		cmp		r0, #0 @if end of the list is reached, then no advantage or disadvantage on either side
		blt		Neutral
		
			ldrb	r1, [r3]
			cmp		r1, r0
			bne		GoToNextEntry
		
				ldrb	r0, [r4]
				ldrb	r1, [r2,#1]
				cmp		r1, r0
				bne		GoToNextEntry
		
					@check mt bonus/penalty to determine wta/wtd
					mov		r0, #1
					mov		r1, #3
					ldsb	r1, [r2,r1]
					cmp		r1, #0
					bgt		CheckAttackerForReaver
		
						@WTD
						neg		r0, r0
						b		CheckAttackerForReaver
		
		Neutral:
		mov		r0, #0
		b		End
		
		CheckAttackerForReaver:
		mov		r3, #0 @reaver count
		ldr		r1, [r5,#0x4C]
		mov		r2, #0x80
		lsl		r2, #1
		tst		r1, r2
		beq		CheckDefenderForReaver
		
			add		r3, #1
		
		CheckDefenderForReaver:
		ldr		r1, [r6,#0x4C]
		tst		r1, r2
		beq		CheckReaverCount
		
			add		r3, #1
		
		CheckReaverCount:
		cmp		r3, #1
		bne		End @if 0 or 2, don't reverse triangle
		
			neg		r0, r0

		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

