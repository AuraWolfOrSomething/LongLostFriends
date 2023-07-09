.thumb

.include "../WardenDefs.s"

.global WardenTargetSelection_Loop
.type WardenTargetSelection_Loop, %function


		WardenTargetSelection_Loop:
		push	{r4-r7,r14}
		mov		r6, r0
		ldr		r5, =gGameState
		mov		r0, #0x14
		ldsh	r2, [r5,r0]
		mov		r1, #0x16
		ldsh	r0, [r5,r1]
		ldr		r1, =gMapRange
		ldr		r1, [r1]
		lsl		r0, #2
		add		r0, r1
		ldr		r0, [r0]
		add		r0, r2
		ldrb	r4, [r0]
		ldr		r0, =HandlePlayerCursorMovement
		mov		lr, r0
		.short	0xF800
		
		@Check if "A" was pressed
		ldr		r7, =KeyStatusBuffer
		ldr		r7, [r7]
		ldrh	r7, [r7,#8]
		mov		r0, #1
		tst		r0, r7
		beq		CheckButton_B
		
			cmp		r4, #0
			beq		TileNotInRange
			
				@Only play sound effect if settings has sound and/or music on?
				ldr		r0, =gChapterData
				add		r0, #0x41
				ldrb	r0, [r0]
				lsl		r0, #0x1E
				cmp		r0, #0
				blt		GoToBreakProcLoop
				
					@Play confirmation sound effect
					mov		r0, #0x6A
					ldr		r1, =m4aSongNumStart
					mov		lr, r1
					.short	0xF800
					
				GoToBreakProcLoop:
				mov		r0, r6
				ldr		r1, =BreakProcLoop
				mov		lr, r1
				.short	0xF800
				ldr		r1, =gActionData
				ldrh	r0, [r5,#0x14]
				strb	r0, [r1,#0x13]
				ldrh	r0, [r5,#0x16]
				strb	r0, [r1,#0x14]
				ldr		r0, =gActiveUnit
				ldr		r0, [r0]
				ldr		r1, =EndItemEffectSelectionThing
				mov		lr, r1
				.short	0xF800
				b		End
		
		TileNotInRange:
		@Only play sound effect if settings has sound and/or music on?
		ldr		r0, =gChapterData
		add		r0, #0x41
		ldrb	r0, [r0]
		lsl		r0, #0x1E
		cmp		r0, #0
		blt		CheckButton_B
		
			@Play denied sound effect
			mov		r0, #0x6C
			ldr		r1, =m4aSongNumStart
			mov		lr, r1
			.short	0xF800
		
		CheckButton_B:
		mov		r0, #2
		tst		r0, r7
		beq		CheckCursorType
		
			ldr		r0, =gBg2MapBuffer
			mov		r1, #0
			ldr		r2, =FillBgMap
			mov		lr, r2
			.short	0xF800
			mov		r0, #4
			ldr		r1, =EnableBgSyncByMask
			mov		lr, r1
			.short	0xF800
			mov		r0, r6
			mov		r1, #0x63
			ldr		r2, =ProcGoto
			mov		lr, r2
			.short	0xF800
			ldr		r0, [r6,#0x30]
			ldr		r1, =AP_Delete
			mov		lr, r1
			.short	0xF800
			
			@Only play sound effect if settings has sound and/or music on?
			ldr		r0, =gChapterData
			add		r0, #0x41
			ldrb	r0, [r0]
			lsl		r0, #0x1E
			cmp		r0, #0
			blt		CheckCursorType
			
				@Play backed out sound effect
				mov		r0, #0x6B
				ldr		r1, =m4aSongNumStart
				mov		lr, r1
				.short	0xF800
		
		CheckCursorType:
		ldr		r0, [r6,#0x30]
		mov		r1, #0
		cmp		r4, #0
		bne		SetCursor
			
			mov		r1, #1
		
		SetCursor:
		ldr		r2, =AP_SetAnimation
		mov		lr, r2
		.short	0xF800
		
		GoToAP_Update:
		ldr		r0, [r6,#0x30]
		
		@Draw at X (Cursor X - Camera X)
		mov		r3, #0x20
		
		ldsh	r1, [r5,r3]
		mov		r3, #0x0C
		ldsh	r2, [r5,r3]
		sub		r1, r2
		
		@Draw at Y (Cursor Y - Camera Y)
		mov		r3, #0x22
		ldsh	r2, [r5,r3]
		mov		r3, #0x0E
		ldsh	r3, [r5,r3]
		sub		r2, r3
		
		ldr		r3, =AP_Update
		mov		lr, r3
		.short	0xF800
		
		@Make aoe show up (credit Vesly)
		ldr		r0, =gMapMovement
		ldr		r0, [r0]
		mov		r1, #0xFF
		ldr		r2, =ClearMapWith
		mov		lr, r2
		.short	0xF800
		ldr		r0, =gMapMovement2
		ldr		r0, [r0]
		mov		r1, #0xFF
		ldr		r2, =ClearMapWith
		mov		lr, r2
		.short	0xF800
		
		ldrb	r0, [r5,#0x18]
		ldrb	r1, [r5,#0x1A]
		ldr		r2, =WardenAoeMap
		ldr		r3, =CreateMoveMapFromTemplate
		mov		lr, r3
		.short	0xF800
		mov		r0, #0x44
		ldr		r1, =DisplayMoveRangeGraphics
		mov		lr, r1
		.short	0xF800
		
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

