.thumb

.global WeaponRankModifierLoop
.type WeaponRankModifierLoop, %function


		WeaponRankModifierLoop:
		push	{r4-r7,r14}
		mov		r4, r0 @character
		mov		r5, r1 @character's rank (before being modified)
		
		@if unit has no wexp in rank, cannot be modified
		cmp		r1, #0
		beq		End
		
			mov		r6, #0 @net amount of modification
			ldr		r7, =WeaponRankModifierList
			
			LoopThroughList:
			ldr		r1, [r7]
			cmp		r1, #0
			beq		ApplyModifiers
			
				mov		r0, r4
				mov		lr, r1
				.short	0xF800
				add		r6, r0
				add		r7, #4
				b		LoopThroughList
			
			ApplyModifiers:
			cmp		r6, #0
			beq		End
			
				ldr		r1, =WEXPRankRequirementsTable
				
				@Determine character's rank based on WEXP
				LoopThroughRankTable:
				ldrb	r0, [r1]
				cmp		r5, r0
				beq		LetterRankFound
				
					ldrb	r0, [r1,#1]
					cmp		r5, r0
					blt		LetterRankFound
					
						NextEntryInTable:
						add		r1, #1
						b		LoopThroughRankTable
				
				LetterRankFound:
				add		r1, r6
				ldrb	r5, [r1]
				
				@If modifiers make the rank below E, return 0 WEXP/no rank
				ldr		r2, =WEXPRankRequirementsTable
				cmp		r1, r2 
				bge		AboveSRankCheck
				
					mov		r5, #0
					b		End
					
				AboveSRankCheck:
				@If modifiers make the rank above S, return 251 WEXP/S Rank
				ldr		r2, =WEXPRankRequirementsTable
				add		r2, #5 @number of ranks-1 (excluding having no WEXP)
				cmp		r1, r2
				ble		End
				
					ldrb	r5, [r2]
		
		End:
		mov		r0, r5
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

