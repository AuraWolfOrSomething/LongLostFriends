.thumb

.equ origin, 0x08017D3C
.equ bl_GenUnitDefinitionFinalPosition, . + 0x0807A054 - origin
.equ bl_SetUnitAiFromDefinition, . + 0x0803C258 - origin

.global NewPopulateUnitFromDefinition
.type NewPopulateUnitFromDefinition, %function

.global NewPopulateUnitLevelAndPosition
.type NewPopulateUnitLevelAndPosition, %function

.global NewPopulateUnitGorgonEgg
.type NewPopulateUnitGorgonEgg, %function


		NewPopulateUnitFromDefinition:
		push	{r4-r6,r14}
		mov		r4, r0 @unit storing at enemy faction RAM
		mov		r5, r1 @unit loading from events
		ldrb	r1, [r5]
		cmp		r1, #0
		bgt		LoadCharacterPointer
		
			mov		r1, #0
			b		StoreCharacterPointer
		
		LoadCharacterPointer:
		mov		r0, #0x34
		mul		r1, r0
		ldr		r0, =CharacterTable
		add		r1, r0
		
		StoreCharacterPointer:
		str		r1, [r4]
		ldrb	r0, [r5,#1]
		cmp		r0, #0
		beq		_0x17D68
		
			cmp		r0, #0
			ble		_0x17D6E
		
				b		LoadClassPointer
		
		@this is so this won't conflict with mss (unless user modifies it themselves)
		.align
		.ltorg
		
		_0x17D68:
		ldrb	r0, [r1,#5]
		cmp		r0, #0
		bgt		LoadClassPointer
		
			_0x17D6E:
			mov		r1, #0
			b		StoreClassPointer
		
		LoadClassPointer:
		mov		r1, #0x54
		mul		r1, r0
		ldr		r0, =ClassTable
		add		r1, r0
		
		StoreClassPointer:
		str		r1, [r4,#4]
		
		@Remaining functions are handled through a loop
		ldr		r6, =NewPopulateUnitFunctionList
		
		LoopThroughList:
		ldr		r2, [r6]
		cmp		r2, #0
		beq		End
		
			mov		r0, r4
			mov		r1, r5
			mov		lr, r2
			.short	0xF800
			add		r6, #4
			b		LoopThroughList
		
		End:
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg
		
		
		NewPopulateUnitLevelAndPosition:
		push	{r14}
		
		@Level
		ldrb	r2, [r1,#3]
		lsr		r2, #3
		strb	r2, [r0,#8]
		
		@Position (this is gonna be a little weird since we aren't pushing extra registers)
		mov		r2, r0
		mov		r0, r1
		mov		r1, r2
		add		r1, #0x10
		add		r2, #0x11
		mov		r3, #0
		bl		bl_GenUnitDefinitionFinalPosition
		pop		{r0}
		bx		r0
		
		.align
		.ltorg
		
		
		NewPopulateUnitGorgonEgg:
		push	{r4-r5,r14}
		ldr		r2, [r0,#4]
		ldrb	r2, [r2,#4]
		cmp		r2, #0x62
		beq		IsGorgonEgg
		
			cmp		r2, #0x34
			bne		ReturnToLoop
		
		IsGorgonEgg:
		mov		r5, #0
		strh	r5, [r0,#0x1E]
		mov		r2, r1
		add		r2, #0x0C
		mov		r3, r0
		add		r3, #0x20
		
		GorgonEggLoop:
		add		r4, r2, r5
		ldrb	r4, [r4]
		strh	r4, [r3]
		add		r3, #2
		add		r5, #1
		cmp		r5, #3
		ble		GorgonEggLoop
		
		ReturnToLoop:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

