.thumb

.include "../CheckBeforeMiscEventsDefs.s"

.global Ch1_IsArlettFree
.type Ch1_IsArlettFree, %function


		Ch1_IsArlettFree:
		push	{r4,r14}
		
		@if not Chapter 1, skip
		ldr		r0, =gChapterData
		ldrb	r0, [r0,#0x0E]
		cmp		r0, #1
		bne		End
		
			@if event ID is already set, skip
			ldr		r4, =ArlettFreedEventIDLink
			ldrb	r0, [r4]
			ldr		r1, =CheckEventID
			mov		lr, r1
			.short	0xF800
			cmp		r0, #1
			beq		End
			
				@check if wall is broken
				  @if so, set event ID
				ldr		r0, =ArlettCellWall
				ldr		r3, =CallWithinAsmCheckIfTerrainAtCoord
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				beq		SetArlettFreedEventID
				
					@check if Arlett is outside of cell
					  @if so, set event ID
					ldr		r2, =Unit_NPC_1
					ldr		r3, =ArlettFreed_StartingLocation
					ldrb	r0, [r2,#0x10]
					ldrb	r1, [r3]
					cmp		r0, r1
					bne		SetArlettFreedEventID
					
						ldrb	r0, [r2,#0x11]
						ldrb	r1, [r3,#1]
						cmp		r0, r1
						beq		End
		
		SetArlettFreedEventID:
		ldrb	r0, [r4]
		ldr		r1, =SetEventID
		mov		lr, r1
		.short	0xF800
				
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


