.thumb

.include "SetUpPrepScreenMapMenuDefinitions.asm"

.global SetUpPrepScreenMapMenu
.type SetUpPrepScreenMapMenu, %function


		SetUpPrepScreenMapMenu:
		push	{r4-r5,r14}
		add		sp, #-0x04
		mov		r4, r0
		mov		r1, #1
		neg		r1, r1
		mov		r0, #0
		bl		bl_LoadDialogueBoxGfx
		bl		bl_Text_InitFont
		bl		bl_EndPlayerPhaseSideWindows
		bl		bl_HideMoveRangeGraphics
		mov		r0, r4
		bl		bl_08096FAC
		ldr		r5, =PrepScreenMapMenuList
		
		LoopThroughList:
		ldr		r0, [r5]
		cmp		r0, #0
		beq		ContinueLoop_AlwaysUsable
		
		mov		lr, r0
		.short	0xF800
		cmp		r0, #0
		bne		ContinueLoop_AlwaysUsable
		
		mov		r2, #1
		b		CheckIfEndReached
		
		ContinueLoop_AlwaysUsable:
		mov		r2, #0
		
		CheckIfEndReached:
		ldr		r1, [r5,#4]
		cmp		r1, #0
		beq		EndOfLoop
		
		ldrh	r3, [r5,#8]
		ldrh	r0, [r5,#0xA]
		str		r0, [sp]
		ldrb	r0, [r5,#0x0C]
		bl		bl_08097024
		add		r5, #0x10
		b		LoopThroughList
		
		EndOfLoop:
		mov		r0, r4
		bl		bl_08033620
		ldr		r0, =Routine_080333C5
		bl		bl_08096FD0
		ldr		r0, =Routine_080333A5
		bl		bl_08096FEC
		ldr		r0, =Routine_08033635
		bl		bl_08097008
		mov		r0, #0x0A
		mov		r1, #2
		bl		bl_08097154
		ldr		r0, [r4,#0x58]
		bl		bl_080970CC
		mov		r0, #3
		bl		bl_EnableBgSyncByMask
		add		sp, #4
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


