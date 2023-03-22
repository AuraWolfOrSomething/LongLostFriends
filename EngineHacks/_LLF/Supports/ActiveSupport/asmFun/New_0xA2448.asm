.thumb

.equ origin, 0x080A2448
.include "../ActiveSupportDefs.s"

.global New_0xA2448
.type New_0xA2448, %function


		New_0xA2448:
		push	{r4-r7,r14}
		add		sp, #-0x04
		mov		r6, r0
		
		@Store if in prep or in extra
		mov		r5, #0x38
		ldrb	r5, [r0,r5]
		
		@Current selected conversation/partner
		add		r0, #0x39
		str		r0, [sp]
		ldrb	r7, [r0]
		
		@Checking B button
		ldr		r0, =KeyStatusBuffer
		ldr		r1, [r0]
		ldrh	r4, [r1,#8]
		mov		r0, #2
		tst		r0, r4
		beq		CheckButton_R
		
			ldr		r0, =gChapterData
			add		r0, #0x41
			ldrb	r0, [r0]
			lsl		r0, #0x1E
			cmp		r0, #0
			blt		Label_080A2470
		
				mov		r0, #0x6B
				bl		bl_m4aSongNumStart
		
			Label_080A2470:
			mov		r1, #3
			b		CallProcGoto
		
		CheckButton_R: @080A2484
		mov		r0, #0x80
		lsl		r0, #1
		tst		r0, r4
		beq		CheckButton_L
		
			mov		r1, #4
			b		CallProcGoto
		
		CheckButton_L: @080A249A
		mov		r0, #0x80
		lsl		r0, #2
		tst		r0, r4
		beq		CheckButton_A
		
			mov		r1, #5
			b		CallProcGoto
		
		CheckButton_A: @080A24CA
		mov		r0, #1
		tst		r0, r4
		beq		CheckDirButton_Left
		
			@check if in prep or extra
			cmp		r5, #0
			beq		ButtonA_Extra
		
				@get support total
				mov		r0, #0x3D
				ldrb	r0, [r6,r0] @number of remaining supports this unit can do
				cmp		r0, #5
				beq		DenyButton_A
		
					mov		r0, r6
					ldr		r1, =SupportListSetNewActive
					mov		lr, r1
					.short	0xF800
		
					mov		r0, #0x6A
					bl		bl_m4aSongNumStart
					b		End
		
			ButtonA_Extra: @080A24DA
			mov		r0, #0x3B
			ldrb	r0, [r6,r0]
			cmp		r0, #0
			beq		DenyButton_A
			@bne	ButtonA_Extra_2
			@b		DenyButton_A
		
				@ButtonA_Extra_2:
				ldr		r0, =gChapterData
				add		r0, #0x41
				ldrb	r0, [r0]
				lsl		r0, #0x1E
				cmp		r0, #0
				blt		Label_080A24EC
				
					mov		r0, #0x6A
					bl		bl_m4aSongNumStart
		
				Label_080A24EC:
				mov		r1, #2
		
		CallProcGoto:
		mov		r0, r6
		bl		bl_ProcGoto
		b		End
		
		CheckDirButton_Left: @080A24FC
		@if in extra, don't allow going left/right
		cmp		r5, #0
		bne		CheckDirButton_Up
		
			mov		r0, #0x20
			tst		r0, r4
			beq		CheckDirButton_Right
		
				mov		r1, #3
				and		r1, r7
				cmp		r1, #0 @not worth using tst in this scenario
				beq		CheckDirButton_Right
		
					@080A250C
					mov		r0, #0xFC
					and		r0, r7
					add		r0, #0xFF
					add		r0, r1
					ldr		r1, [sp]
					strb	r0, [r1]
		
			CheckDirButton_Right: @080A251C
			mov		r0, #0x10
			tst		r0, r4
			beq		CheckDirButton_Up
			
				ldr		r0, [r6,#0x2C]
				lsr		r1, r7, #2
				mov		r2, #7
				and		r1, r2
				bl		bl_080A0AD4
				sub		r0, #1
				mov		r3, #3
				and		r3, r7
				cmp		r3, r0
				bge		CheckDirButton_Up @false
			
					@080A2540
					mov		r0, #0xFC
					and		r0, r7
					add		r0, #1
					mov		r1, #3
					and		r1, r7
					add		r0, r1
					ldr		r1, [sp]
					strb	r0, [r1]
		
		CheckDirButton_Up: @080A2556
		mov		r0, #0x40
		tst		r0, r4
		beq		CheckDirButton_Down
		
			lsr		r1, r7, #2
			mov		r0, #7
			and		r1, r0
			sub		r1, #1
			mov		r2, #1
			neg		r2, r2
			mov		r0, r6
			bl		bl_080A2154
		
		CheckDirButton_Down: @080A2576
		mov		r0, #0x80
		tst		r0, r4
		beq		Label_080A2590
		
			lsr		r1, r7, #2
			mov		r0, #7
			and		r1, r0
			add		r1, #1
			mov		r0, r6
			mov		r2, #1
			bl		bl_080A2154
		
		Label_080A2590:
		ldr		r1, [sp]
		ldrb	r1, [r1]
		cmp		r7, r1
		beq		End
		
			@X-coord
			mov		r0, #3
			and		r0, r1
			lsl		r0, #3
		
			@Y-coord
			lsr		r1, #2
			mov		r2, #7
			and		r1, r2
			lsl		r1, #4
		
			cmp		r5, #0
			bne		InPrep_SetCursor
		
				add		r0, #0xC4
				add		r1, #0x18
				mov		r2, #1
				b		SetUpCursor
		
		InPrep_SetCursor:
		add		r0, #0x6C
		add		r1, #0x16
		@mov		r2, #7
		mov		r2, #0 @no highlight
		
		SetUpCursor:
		mov		r3, #0x80
		lsl		r3, #4
		bl		bl_CursorRoutineThing
		
		@080A25B2
		ldr		r0, =gChapterData
		add		r0, #0x41
		ldrb	r0, [r0]
		lsl		r0, #0x1E
		cmp		r0, #0
		blt		End
		
			mov		r0, #0x65
			bl		bl_m4aSongNumStart
			b		End
		
		@080A25D0
		DenyButton_A:
		mov		r0, #1
		tst		r0, r4
		beq		End
		
			ldr		r0, =gChapterData
			add		r0, #0x41
			ldrb	r0, [r0]
			lsl		r0, #0x1E
			cmp		r0, #0
			blt		End
		
				mov		r0, #0x6C
				bl		bl_m4aSongNumStart
		
		End: @080A25EA
		add		sp, #0x04
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

