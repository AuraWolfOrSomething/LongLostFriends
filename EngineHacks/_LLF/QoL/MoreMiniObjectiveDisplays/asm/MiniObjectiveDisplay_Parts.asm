.thumb

.include "../MoreMiniObjectiveDisplayDefs.s"

.global MiniObjectiveDisplay_Parts
.type MiniObjectiveDisplay_Parts, %function


		MiniObjectiveDisplay_Parts:
		mov		r4, r6
		add		r4, #0x34
		
		@Display the text "Part"
		ldr		r0, =MiniObjectiveDisplay_PartsTextLink
		ldrh	r0, [r0]
		ldr		r3, =String_GetFromIndex
		mov		lr, r3
		.short	0xF800
		ldr		r3, =Text_InsertString
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0
		mov		r2, #0
		.short	0xF800
		
		@Get chapter ID
		ldr		r0, =gChapterData
		ldrb	r0, [r0,#0x0E]
		ldr		r7, =ConvertChapterToPartList
		
		LoopThroughList:
		ldrb	r1, [r7]
		cmp		r0, r1
		beq		DisplayCurrentPart
		
			cmp		r1, #0xFF
			beq		DisplayCurrentPart
			
				add		r7, #3
				b		LoopThroughList
		
		DisplayCurrentPart:
		ldr		r0, =Text_InsertNumberOr2Dashes
		mov		lr, r0
		mov		r0, r4
		mov		r1, #0x1C
		mov		r2, #2
		ldrb	r3, [r7,#1]
		.short	0xF800
		
		@"of"
		ldr		r0, =MiniObjectiveDisplay_PartsTextLink
		ldrh	r0, [r0,#2]
		ldr		r3, =String_GetFromIndex
		mov		lr, r3
		.short	0xF800
		ldr		r3, =Text_InsertString
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x2A
		mov		r2, #0
		.short	0xF800
		
		@Display total number of parts (according to entry)
		
		ldr		r0, =Text_InsertNumberOr2Dashes
		mov		lr, r0
		mov		r0, r4
		mov		r1, #0x38
		mov		r2, #2
		ldrb	r3, [r7,#2]
		.short	0xF800
		
		@Done
		ldr		r3, =MiniObjectiveDisplaysEnd
		@add		r3, #1
		bx		r3
		
		.align
		.ltorg

