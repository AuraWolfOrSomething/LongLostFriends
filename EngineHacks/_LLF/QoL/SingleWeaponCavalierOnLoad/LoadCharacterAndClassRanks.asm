.thumb

.include "SingleWeaponCavalierOnLoadDefinitions.asm"

.global LoadCharacterAndClassRanks
.type LoadCharacterAndClassRanks, %function


		LoadCharacterAndClassRanks:
		push	{r4-r6,r14}
		mov		r4, r0
		mov		r5, #0
		
		@Get class id and list of specified class ids
		ldr		r1, [r4,#4]
		ldrb	r1, [r1,#4]
		ldr		r2, =LimitToSingleWeaponClassList
		
		CheckIfClassIsOnList:
		ldrb	r0, [r2]
		cmp		r0, r1
		beq		CheckTopItemInInvetory
		cmp		r0, #0
		beq		LoadRanks
		add		r2, #1
		b		CheckIfClassIsOnList
		
		CheckTopItemInInvetory:
		mov		r5, #1
		mov		r0, r4
		add		r0, #0x1E
		ldrh	r0, [r0]
		ldr		r3, =GetItemWType
		mov		lr, r3
		.short	0xF800
		mov		r6, r0
		
		@check if class is set to use that item type
		  @if so, only load the class & character base of that type
		  @if not, skip all class bases and use all character bases (r6 = 0xFF)
		  
		ldr		r0, [r4,#4]
		add		r0, #0x2C
		add		r0, r6
		ldrb	r0, [r0]
		cmp		r0, #0
		bne		LoadRanks
		
		mov		r6, #0xFF
		
		LoadRanks:
		mov		r1, #0
		mov		r3, r4
		add		r3, #0x28
		
		LoopThroughRanks:
		add		r2, r3, r1
		cmp		r5, #1
		bne		StoreClassRank
		cmp		r6, r1
		bne		CheckIfStoringCharacterRank

		StoreClassRank:
		ldr		r0, [r4,#4]
		add		r0, #0x2C
		add		r0, r1
		ldrb	r0, [r0]
		strb	r0, [r2]
		
		CheckIfStoringCharacterRank:
		cmp		r5, #1
		bne		StoreCharacterRank
		cmp		r6, #0xFF
		beq		StoreCharacterRank
		cmp		r6, r1
		bne		DoNextRank
		
		StoreCharacterRank:
		ldr		r0, [r4]
		add		r0, #0x14
		add		r0, r1
		ldrb	r0, [r0]
		cmp		r0, #0
		beq		DoNextRank
		
		strb	r0, [r2]
		
		DoNextRank:
		add		r1, #1
		cmp		r1, #7
		ble		LoopThroughRanks
		
		pop		{r4-r6}
		pop		{r0}
		bx		r0

