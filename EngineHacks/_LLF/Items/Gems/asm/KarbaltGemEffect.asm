.thumb

.global KarbaltGemEffect
.type KarbaltGemEffect, %function

@r4 = unit we're checking
@r5 = unit's opponent (if any)

		KarbaltGemEffect:
		push	{r4-r5,r14}
		mov		r4, r0
		mov		r5, r1
		
		ldr		r1, =KarbaltGemLink
		ldrb	r1, [r1]
		ldr		r3, =CheckIfGemIsActive
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@Check if WTA
			mov		r0, r4
			mov		r1, r5
			ldr		r3, =CheckWeaponTriangleConnection
			mov		lr, r3
			.short	0xF800
			cmp		r0, #1
			bne		End
		  
				@Add to damage dealt
				mov		r1, r4
				add		r1, #0x5A
				ldrb	r0, [r1]
				add		r0, #6
				strb	r0, [r1]
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0

