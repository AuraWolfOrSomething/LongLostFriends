.thumb

.include "../CheckIfDoublingDefs.s"

.global CheckIfEnoughAS
.type CheckIfEnoughAS, %function

		
		CheckIfEnoughAS:
		push  	{r4-r6,r14}
		mov   	r4, r0
		mov   	r5, r1
		
		@Get AS for each unit
		mov   	r3, #0x5E
		ldsh  	r2, [r5,r3] @Defender
		ldsh  	r3, [r4,r3] @Attacker
		
		@Get attacker - defender and save result for now
		sub   	r6, r3, r2
		
		@Check if either unit has a weapon with Distort's weapon effect
		add   	r0, #0x4A
		ldrh  	r0, [r0]
		ldr	  	r3, =GetItemWeaponEffect
		mov	  	lr, r3
		.short 	0xF800
		
		cmp		r0, #0xD
		beq		DistortWeaponEffect
		
			mov		r0, r5
			add		r0, #0x4A
			ldrh  	r0, [r0]
			ldr	  	r3, =GetItemWeaponEffect
			mov	  	lr, r3
			.short 	0xF800
			
			cmp		r0, #0xD
			beq		DistortWeaponEffect
		
				cmp   	r6, #3
				ble   	NotEnoughAS
				b   	EnoughAS
		
		DistortWeaponEffect: @if unit has -4 AS compared to enemy, they double attack
		mov		r0, #3
		neg		r0, r0
		cmp   	r6, r0
		bge   	NotEnoughAS
		
			EnoughAS:
			mov		r0, #1
			b		End
		
		NotEnoughAS:
		mov   	r0, #0
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

