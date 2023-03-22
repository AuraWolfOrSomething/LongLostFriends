.thumb

.include "../KeysDefs.s"

.global KeysCondition
.type KeysCondition, %function


		KeysCondition:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, r1
		mov		r6, #0x00
		
		@Vanilla check for if the "thief skill" is on the character or the class; at least one of the two is required for a lockpick to be usable
		@ldr		r0, [r4]
		@ldr		r1, [r4,#0x04]
		@ldr		r0, [r0,#0x28]
		@ldr		r1, [r1,#0x28]
		@orr		r0, r1
		@mov		r1, #0x08
		@and		r0, r1
		@cmp		r0, #0x00
		@beq		NoLockpick
		
		@Check for Cunning skill; if unit doesn't have it, then skip the check for the fragile lockpick and lockpick
		ldr		r1, =CunningLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		NoLockpick
		
			@mov		r0, r4
			@ldr		r1, =FragileLockpickLink
			@ldrb	r1, [r1]
			@ldr		r3, =GetUnitItemSlot
			@mov		lr, r3
			@.short	0xF800
			@cmp		r0, #0x00
			@bge		End
			
			mov		r0, r4
			mov		r1, #0x6B @lockpick
			ldr 	r3, =GetUnitItemSlot
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0x00
			bge		End
		
		NoLockpick:
		mov		r0, r4
		ldr		r1, =MasterKeyLink
		ldrb	r1, [r1]
		ldr 	r3, =GetUnitItemSlot
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0x00
		bge		End
		
			cmp		r5, #0x1E
			beq		CheckForDoorKey
		
				cmp		r5, #0x21
				bne		Branch_0x18AE2
		
					mov		r0, r4
					mov		r1, #0x69 @chest key with 1 use
					ldr 	r3, =GetUnitItemSlot
					mov		lr, r3
					.short	0xF800
					b		End
		
		cmp		r0, #0x00
		bge		End
		
			mov		r0, r4
			mov		r1, #0x79 @5 use chest key
			ldr		r3, =GetUnitItemSlot
			mov		lr, r3
			.short	0xF800
			b		End
		
		CheckForDoorKey:
		mov		r6, #0x6A @door key
		
		Branch_0x18AE2:
		mov		r0, r4
		mov		r1, r6
		ldr 	r3, =GetUnitItemSlot
		mov		lr, r3
		.short	0xF800
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

