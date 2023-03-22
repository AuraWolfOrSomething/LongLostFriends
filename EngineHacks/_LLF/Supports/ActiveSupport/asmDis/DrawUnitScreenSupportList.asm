.thumb

.equ origin, 0x08087698
.include "../ActiveSupportDefs.s"

.global DrawUnitScreenSupportList
.type DrawUnitScreenSupportList, %function

@sp,#0x18: icon color font
@sp,#0x1C: replacing r9
@sp,#0x20: replacing r10
@sp,#0x24: partner character table entry


		DrawUnitScreenSupportList:
		push	{r4-r7,r14}
		add		sp, #-0x28
		
		mov		r0, #5 @lines from top of the page
		str		r0, [sp,#8]
		ldr		r7, =StatScreenStruct
		ldr		r0, [r7,#0x0C]
		bl		bl_GetROMUnitSupportCount
		str		r0, [sp,#0x20]
		mov		r1, #0
		str		r1, [sp,#0x1C]
		cmp		r1, r0
		bge		End
		
		mov		r1, #0x80
		lsl		r1, #1
		add		r1, r7
		str		r1, [sp,#0x10]
		
		DrawPartnerLoop:
		ldr		r0, [r7,#0x0C]
		ldr		r1, [sp,#0x1C]
		bl		bl_GetROMUnitSupportingId
		mov		r4, r0

		@Affinity
		bl		bl_GetCharacterData
		str		r0, [sp,#0x24] @store name for later
		ldrb	r0, [r0,#9]
		sub		r0, #1
		
		@This utilizes icon rework (affinities have their own icon sheet instead of being shared with item icons/other stuff)
		mov		r1, #2
		lsl		r1, #8
		orr		r1, r0
		ldr		r0, [sp,#8]
		lsl		r6, r0, #6
		ldr		r0, =Const_2003D3C
		add		r0, r6
		mov		r2, #0xA0
		lsl		r2, #7
		bl		bl_DrawIcon
		
		@Check if active support
		  @if so, use a different color
		ldr		r0, [r7,#0x0C]
		mov		r1, r4
		ldr		r2, =IsSupportActive
		bl		bl_BXR2
		cmp		r0, #0
		beq		NotActiveSupport
		
			ldr		r1, =ActiveSupportColorLink
			ldrb	r0, [r1]
			ldrb	r1, [r1,#1]
			b		StoreSupportColors
		
			NotActiveSupport:
			mov		r0, #0
			mov		r1, #0
		
			StoreSupportColors:
			str		r0, [sp,#0x0C] @name's color
			str		r1, [sp,#0x18] @rank's color
			
			@Name
			@mov		r0, r4
			@bl		bl_GetCharacterData
			
			ldr		r0, [sp,#0x24]
			
			ldrh	r0, [r0]
			bl		bl_String_GetFromIndex
			ldr		r1, =Const_2003D3C
			add		r1, #4 @spacing from icon
			add		r1, r6
			mov		r2, #0
			str		r2, [sp]
			str		r0, [sp,#4]
			ldr		r0, [sp,#0x10]
			ldr		r2, [sp,#0x0C] @color font
			mov		r3, #0
			bl		bl_DrawTextInline
			
			@Rank
			ldr		r4, =Const_2003D3C
			add		r4, #0x10 @spacing from icon
			add		r4, r6
		
			@using r7 for other stuff, so go back and get what vanilla used r7 for (level of the support)
			ldr		r0, [r7,#0x0C]
			ldr		r1, [sp,#0x1C]
			bl		bl_0802823C
			cmp		r0, #0
			beq		AddNewLine @if no rank, don't draw
		
				bl		bl_080286EC
				mov		r2, r0
				mov		r0, r4
				ldr		r1, [sp,#0x18]
				bl		bl_DrawSpecialUiChar
		
				AddNewLine:
				ldr		r1, [sp,#8]
				add		r1, #2
				str		r1, [sp,#8]
				ldr		r0, [sp,#0x10]
				add		r0, #8
				str		r0, [sp,#0x10]
		
				@check if more partners to draw
				ldr		r0, [sp,#0x1C]
				add		r0, #1
				str		r0, [sp,#0x1C]
				ldr		r1, [sp,#0x20]
				cmp		r0, r1
				blt		DrawPartnerLoop
		
		End:
		add		sp, #0x28
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

