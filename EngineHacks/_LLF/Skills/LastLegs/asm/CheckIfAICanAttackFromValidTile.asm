.thumb

.include "../LastLegsDefs.s"

.global CheckIfAICanAttackFromValidTile
.type CheckIfAICanAttackFromValidTile, %function


		CheckIfAICanAttackFromValidTile:
		push	{r4-r7,r14}
		mov		r4, r8
		mov		r5, r9
		mov		r6, r10
		mov		r7, r11
		push	{r4-r7}
		mov		r7, r0
		ldr		r0, =gActiveUnit
		ldr		r0, [r0]
		mov		r9, r0
		mov		r0, #0
		mov		r11, r0
		
		ldr		r0, =gMapSize
		mov		r1, #2
		ldsh	r0, [r0,r1]
		sub		r5, r0, #1
		cmp		r5, #0
		blt		CheckIfAnyTileFound
		
		NextRow: @0803DCDC
		ldr		r0, =gMapSize
		mov		r1, #0
		ldsh	r0, [r0,r1]
		sub		r4, r0, #1
		sub		r0, r5, #1
		mov		r8, r0
		cmp		r4, #0
		blt		CheckIfAnotherRow
		
			lsl		r6, r5, #2
		
			NextTile: @0803DCEE
			ldr		r0, =gMapMovement
			ldr		r0, [r0]
			add		r0, r6, r0
			ldr		r0, [r0]
			add		r0, r4
			ldrb	r0, [r0]
			cmp		r0, #0x78
			bhi		CheckNextInRow
		
				@Check for Last Legs
				mov		r10, r0
				mov		r0, r9
				ldr		r1, =LastLegsLink
				ldrb	r1, [r1]
				ldr		r3, =SkillTester
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				beq		ContinueNormalCheck
		
					@Get unit's mov
					mov		r0, r9
					ldr		r3, =prGotoMovGetter
					mov		lr, r3
					.short	0xF800
		
					@If unit cannot move, then continue normal check
					cmp		r0, #0
					beq		ContinueNormalCheck
		
						@If tile requires full movement, then enemy cannot go to that tile in order to attack target
						mov		r1, r10
						cmp		r0, r1
						beq		CheckNextInRow
		
			ContinueNormalCheck:
			ldr		r0, =gMapRange
			ldr		r0, [r0]
			add		r0, r6, r0
			ldr		r0, [r0]
			add		r0, r4
			ldrb	r0, [r0]
			lsl		r0, #0x18
			asr		r0, #0x18
			cmp		r0, #0
			beq		CheckNextInRow
			
				ldr		r0, =gMapUnit
				ldr		r0, [r0]
				add		r0, r6, r0
				ldr		r0, [r0]
				add		r0, r4
				ldrb	r1, [r0]
				cmp		r1, #0
				beq		GoGetTileWeight
			
					ldr		r0, =gActiveUnitId
					ldrb	r0, [r0]
					cmp		r1, r0
					bne		CheckNextInRow
			
				GoGetTileWeight: @0803DD2A
				ldr		r1, =AiGetTileWeightForAttack
				mov		lr, r1
				mov		r0, r4
				mov		r1, r5
				mov		r2, r7
				.short	0xF800
				mov		r3, r11
				cmp		r0, r3
				bls		CheckNextInRow
		
					strb	r4, [r7]
					strb	r5, [r7,#1]
					mov		r11, r0
		
				CheckNextInRow: @0803DD42
				sub		r4, #1
				cmp		r4, #0
				bge		NextTile
			
					CheckIfAnotherRow: @0803DD48
					mov		r5, r8
					cmp		r5, #0
					bge		NextRow
					
		CheckIfAnyTileFound: @0803DD4E
		mov		r0, r11
		cmp		r0, #0
		beq		NoValidTile

			mov		r0, r7
			ldr		r3, =AiSimulateBattle
			mov		lr, r3
			.short	0xF800
			lsl		r0, #0x18
			asr		r0, #0x18
			b		End
		
		NoValidTile: @0803DD74
		mov		r0, #0
		
		End:
		pop		{r4-r7}
		mov		r11, r7
		mov		r10, r6
		mov		r9, r5
		mov		r8, r4
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

