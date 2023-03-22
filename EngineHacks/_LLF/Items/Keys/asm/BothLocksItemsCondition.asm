.thumb

.include "../KeysDefs.s"

.global BothLocksItemsCondition
.type BothLocksItemsCondition, %function

@r0 = character
@r1 = item being checked (short of item uses + item id)


		BothLocksItemsCondition:
		push	{r4,r14}
		mov		r4, r0
		mov		r0, r1 @requires new CanUnitUseItem in ItemParameterTableInstaller
		ldr		r3, =GetItemIndex
		mov		lr, r3
		.short	0xF800
		
		ldr		r1, =MasterKeyLink
		ldrb	r1, [r1]
		cmp		r0, r1
		beq		CheckIfTileRequiresOpening @if master key, skip this ability check
		
			@Vanilla check for if the "thief skill" is on the character or the class; at least one of the two is required for a lockpick to be usable
			@ldr		r0, [r4]
			@ldr		r1, [r4,#0x04]
			@ldr		r0, [r0,#0x28]
			@ldr		r1, [r1,#0x28]
			@orr		r0, r1
			@mov		r1, #0x08
			@and		r0, r1
			@cmp		r0, #0x00
			@beq		CannotUseItem
			
			@Check for Cunning skill; if unit doesn't have it, then the lockpick/fragile lockpick can't be used
			mov		r0, r4
			ldr		r1, =CunningLink
			ldrb	r1, [r1]
			ldr		r3, =SkillTester
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		CannotUseItem
		
		CheckIfTileRequiresOpening:
		mov		r0, r4
		ldr		r3, =CanUseChestKey
		mov		lr, r3
		.short	0xF800
		lsl		r0, #0x18
		cmp		r0, #0x00
		bne		CanUseItem
		
			mov		r0, r4
			ldr		r3, =CanUseDoorKey
			mov		lr, r3
			.short	0xF800
			lsl		r0, #0x18
			cmp		r0, #0x00
			bne		CanUseItem
		
				mov		r0, r4
				ldr		r3, =CanOpenBridge
				mov		lr, r3
				.short	0xF800
				lsl		r0, #0x18
				cmp		r0, #0x00
				bne		CanUseItem
		
					CannotUseItem:
					mov		r0, #0x00
					b		End
		
		CanUseItem:
		mov		r0, #0x01
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1

		.align
		.ltorg

