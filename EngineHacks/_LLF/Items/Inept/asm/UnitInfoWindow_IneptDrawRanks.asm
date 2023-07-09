.thumb

.include "../IneptDefs.s"

.global UnitInfoWindow_IneptDrawRanks
.type UnitInfoWindow_IneptDrawRanks, %function


		UnitInfoWindow_IneptDrawRanks:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r1 @unit
		ldr		r6, =Text_InsertString
		
		@Text: "Rank"
		ldr		r1, =Text_Clear
		mov		lr, r1
		.short	0xF800
		ldr		r0, =RankLabelLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0 @spacing
		mov		r2, #3 @font
		mov		lr, r6
		.short	0xF800
		
		@Convert unit's highest wexp into rank
		mov		r0, r5
		ldr		r1, =GetUnitHighestWexp
		mov		lr, r1
		.short	0xF800
		mov		r1, r0
		mov		r0, r5
		ldr		r2, =WeaponRankModifierLoop
		mov		lr, r2
		.short	0xF800
		
		@Display rank
		ldr		r2, =WEXPRankRequirementsTable
		cmp		r0, #0
		bgt		LoopThroughTable
		
			@Display -- if unit cannot use weapons/magic
			mov		r7, #0
			ldr		r3, =Text_InsertNumberOr2Dashes
			mov		lr, r3
			mov		r0, r4
			mov		r1, #0x20 @spacing
			mov		r2, #2 @font
			mov		r3, #0xFF
			.short	0xF800
			b		DisplayArrow
			
			LoopThroughTable:
			ldrb	r1, [r2,#1]
			cmp		r0, r1
			blt		GetFirstTextId
		
				add		r2, #1
				b		LoopThroughTable
			
			GetFirstTextId:
			mov		r7, r2
			ldr		r1, =WEXPRankRequirementsTable
			sub		r2, r1
			ldr		r1, =gWRankTextIdArray
			add		r2, #1 @first entry in WEXPRankRequirementsTable is E Rank, but not in gWRankTextIdArray
			lsl		r2, #2
			ldrh	r0, [r1,r2]
			ldr		r1, =String_GetFromIndex
			mov		lr, r1
			.short	0xF800
			mov		r3, r0
			mov		r0, r4
			mov		r1, #0x1C @spacing
			mov		r2, #2 @font
			mov		lr, r6
			.short	0xF800

		DisplayArrow:
		ldr		r0, =ArrowTextIdLink
		ldrh	r0, [r0]
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x26 @spacing
		mov		r2, #3 @font
		mov		lr, r6
		.short	0xF800
		
		@Display rank after inept
		cmp		r7, #0
		beq		DashesForSecondRankDisplay
		
			mov		r0, r5
			ldr		r1, =DetermineIneptSeverity
			mov		lr, r1
			.short	0xF800
			add		r7, r0
			ldr		r2, =WEXPRankRequirementsTable
			cmp		r7, r2 @if modifiers make rank below E, return as no rank
			bge		UsableRank
			
				DashesForSecondRankDisplay:
				ldr		r3, =Text_InsertNumberOr2Dashes
				mov		lr, r3
				mov		r0, r4
				mov		r1, #0x38 @spacing
				mov		r2, #2 @font
				mov		r3, #0xFF
				.short	0xF800
				b		End
				
				UsableRank:
				sub		r2, r7, r2
				ldr		r1, =gWRankTextIdArray
				add		r2, #1 @first entry in WEXPRankRequirementsTable is E Rank, but not in gWRankTextIdArray
				lsl		r2, #2
				ldrh	r0, [r1,r2]
				ldr		r1, =String_GetFromIndex
				mov		lr, r1
				.short	0xF800
				mov		r3, r0
				mov		r0, r4
				mov		r1, #0x34 @spacing
				mov		r2, #2 @font
				mov		lr, r6
				.short	0xF800
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

