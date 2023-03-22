.thumb

.global PlayerPhaseMainIdle
.type PlayerPhaseMainIdle, %function

.include "../PlayerPhaseMainIdleDefs.s"


		PlayerPhaseMainIdle:
		push	{r4-r7,r14}
		ldr		r5, =gGameState
		mov		r6, r0
		bl		bl_HandlePlayerCursorMovement
		ldr		r7, =KeyStatusBuffer
		ldr		r7, [r7]
		ldrh	r7, [r7,#8]
		
		@0801C94E (check L button)
		mov		r0, #0x80
		lsl		r0, #2
		tst		r0, r7 
		beq		GoToBMXFADEExists

		mov		r2, #0x14
		ldsh	r0, [r5,r2]
		mov		r3, #0x16
		ldsh	r1, [r5,r3]
		bl		bl_FindNextCursorUnit
		ldr		r0, =gChapterData
		add		r0, #0x41
		ldrb	r0, [r0]
		lsl		r0, #0x1E
		cmp		r0, #0
		blt		Branch_GoToHandleMapSpriteCursorHover
		
		@0801C974
		mov		r0, #0x6B
		bl		bl_m4aSongNumStart
		
		Branch_GoToHandleMapSpriteCursorHover:
		b		GoToHandleMapSpriteCursorHover
		
		GoToBMXFADEExists: @0801C988
		bl		bl_BMXFADEExists
		lsl		r0, #0x18
		cmp		r0, #0
		bne		Branch_GoToHandleMapSpriteCursorHover
		
		@0801C998 (check R button)
		mov		r0, #0x80
		lsl		r0, #1
		tst		r0, r7
		beq		CheckButton_A
		
		bl		GoToGetUnitAtCursor
		cmp		r0, #0
		beq		CheckButton_A
		
		@0801C9BE
		bl		bl_CanShowUnitStatScreen
		lsl		r0, #0x18
		cmp		r0, #0
		beq		CheckButton_A
		
		@0801C9CC
		bl		bl_MU_EndAll
		bl		bl_EndPlayerPhaseSideWindows
		mov		r0, #0x1F
		bl		bl_08086DE4
		bl		GoToGetUnitAtCursor
		mov		r1, r6
		bl		bl_StartStatScreen
		mov		r0, r6
		mov		r1, #5
		bl		bl_ProcGoto
		b		End
		
		CheckButton_A:
		mov		r0, #1
		tst		r0, r7
		beq		CheckButton_Select
		
		@ldr		r5, =gGameState
		bl		GoToGetUnitAtCursor
		mov		r4, r0
		bl		bl_GetUnitSelectionValueThing
		
		@0801CA3C
		cmp		r0, #2
		beq		Label_0801CA9C
		
		cmp		r0, #2
		ble		Label_0801CA58
		
		cmp		r0, #3
		beq		Label_0801CABC
		b		CheckButton_Select
		
		Label_0801CA58:
		cmp		r0, #0
		blt		CheckButton_Select
		
		bl		bl_EndPlayerPhaseSideWindows
		ldr		r0, =gChapterData
		ldrh	r1, [r5,#0x14]
		strb	r1, [r0,#0x12]
		ldrh	r1, [r5,#0x16]
		strb	r1, [r0,#0x13]
		cmp		r4, #0
		beq		Label_0801CA78
		
		@0801CA6E
		bl		bl_MU_EndAll
		mov		r0, r4
		bl		bl_ShowUnitSMS
		
		Label_0801CA78:
		ldr		r0, =gMenu_MapMenu
		mov		r3, #0x1C
		ldsh	r1, [r5,r3]
		mov		r3, #0x0C
		ldsh	r2, [r5,r3]
		sub		r1, r2
		mov		r2, #1 @map menu left x-coord
		mov		r3, #0x15 @map menu right x-coord (vanilla has this set to 0x17)
		bl		bl_StartMenuAdjusted
		bl		bl_080832CC
		
		@0801CB20
		mov		r0, r6
		mov		r1, #9
		bl		bl_ProcGoto
		b		End
		
		Label_0801CA9C:
		mov		r0, r4
		bl		bl_SetupActiveUnit
		ldr		r0, =gActiveUnit
		ldr		r0, [r0]
		ldr		r0, [r0]
		ldrb	r0, [r0,#4]
		bl		bl_BWL_IncrementMoveValue
		mov		r0, r6
		bl		bl_BreakProcLoop
		b		GoToHandleMapSpriteCursorHover
		
		Label_0801CABC:
		mov		r0, r4
		bl		bl_SetupActiveUnit
		mov		r1, r5
		add		r1, #0x3E
		mov		r0, #0
		strb	r0, [r1]
		mov		r0, r6
		mov		r1, #0x0B
		bl		bl_ProcGoto
		b		GoToHandleMapSpriteCursorHover
		
		CheckButton_Select:
		mov		r0, #4
		tst		r0, r7
		beq		CheckButton_Start
		
		bl		bl_EndPlayerPhaseSideWindows
		ldr		r2, =gGameState
		ldr		r0, =GoToDangerZone+1
		mov		lr, r0
		push	{r4,r14}
		bl		bl_Midway_HandleMapSpriteCursorHover
		
		GoToDangerZone:
		bl		bl_DangerZone
		b		GoToHandleMapSpriteCursorHover
		
		CheckButton_Start:
		mov		r0, #8
		tst		r0, r7
		@beq		CheckButton_B
		beq		GoToHandleMapSpriteCursorHover
		
		bl		GoToGetUnitAtCursor
		mov		r4, r0
		cmp		r4, #0
		beq		Label_0801CB18
		
		@0801CB0E
		bl		bl_MU_EndAll
		mov		r0, r4
		bl		bl_ShowUnitSMS
		
		Label_0801CB18:
		bl		bl_EndPlayerPhaseSideWindows
		bl		bl_080A87C8
		mov		r0, r6
		mov		r1, #9
		bl		bl_ProcGoto
		b		End
		
		@CheckButton_B:
		@mov		r0, #2
		@tst		r0, r7
		@beq		GoToHandleMapSpriteCursorHover
		
		@ldr		r4, =AiToggleEventIDLink
		@ldrb	r0, [r4]
		
		@If AI display is off, turn it on
		  @Otherwise, if AI display is on, turn if off
		@bl		bl_CheckEventID
		@cmp		r0, #1
		@beq		TurnDisplayOff
		
		@ldrb	r0, [r4]
		@bl		bl_SetEventID
		@b		GoToHandleMapSpriteCursorHover
		
		@TurnDisplayOff:
		@ldrb	r0, [r4]
		@bl		bl_UnsetEventID
		
		GoToHandleMapSpriteCursorHover: @0801CB38
		bl		bl_HandleMapSpriteCursorHover
		@ldr		r1, =gGameState
		mov		r0, #0x20
		ldsh	r4, [r5,r0]
		mov		r2, #0x22
		ldsh	r6, [r5,r2]
		mov		r3, #0x14
		ldsh	r0, [r5,r3]
		mov		r2, #0x16
		ldsh	r1, [r5,r2]
		bl		bl_08027B0C
		lsl		r0, #0x18
		mov		r2, #0
		cmp		r0, #0
		beq		GoToDisplayCursor
		
		@0801CB5A
		mov		r2, #3
		
		GoToDisplayCursor:
		mov		r0, r4
		mov		r1, r6
		bl		bl_DisplayCursor
		
		End: @0801CB64
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg
		
		GoToGetUnitAtCursor:
		ldr		r0, =GetUnitAtCursor
		bx		r0

