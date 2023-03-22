.thumb

.include "../CheckBeforeMiscEventsDefs.s"

.global Ch3_IsWallDestroyed
.type Ch3_IsWallDestroyed, %function


		Ch3_IsWallDestroyed:
		push	{r4,r14}
		
		@if not Chapter 3, skip
		ldr		r0, =gChapterData
		ldrb	r0, [r0,#0x0E]
		cmp		r0, #3
		bne		End
		
			@if event ID is already set, skip
			ldr		r4, =Ch3WallDestroyedEventIDLink
			ldrh	r0, [r4]
			ldr		r1, =CheckEventID
			mov		lr, r1
			.short	0xF800
			cmp		r0, #1
			beq		End
			
				@check if wall is broken
				  @if so, set event ID
				ldr		r0, =Ch3Wall
				ldr		r3, =CallWithinAsmCheckIfTerrainAtCoord
				mov		lr, r3
				.short	0xF800
				cmp		r0, #0
				bne		End
		
		SetWallDestroyedEventID:
		ldrh	r0, [r4]
		ldr		r1, =SetEventID
		mov		lr, r1
		.short	0xF800
				
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


