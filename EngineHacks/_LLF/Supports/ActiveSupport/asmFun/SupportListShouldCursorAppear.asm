.thumb

.equ origin, 0
.include "../ActiveSupportDefs.s"

.global SupportListShouldCursorAppear
.type SupportListShouldCursorAppear, %function

@if 0 supports unlocked, no cursor
@if at least 1 unlocked, cursor


		SupportListShouldCursorAppear:
		push	{r4-r5,r14}
		mov		r4, r0
		
		@check if in extra or prep
		mov		r5, #0x38
		ldrb	r5, [r4,r5]
		cmp		r5, #0
		bne		InPrep_GetSupportSum
		
			@Extra already has a total count, so grab that as the return result
			  @If so, return 1
			mov		r0, #0x3B
			ldrb	r0, [r4,r0]
			b		CheckSupportTotal
		
			@Prep doesn't have a direct total, but it does have the "unspent" support total
			InPrep_GetSupportSum:
			mov		r0, #0x3D
			ldrb	r0, [r4,r0] @number of remaining supports this unit can do
			sub		r0, #5

		CheckSupportTotal:
		cmp		r0, #0
		beq		End
		
			@X-coord
			mov		r0, #0x39
			ldrb	r1, [r4,r0]
			mov		r0, #3
			and		r0, r1
			lsl		r0, #3
		
			@Y-coord
			lsr		r1, #2
			mov		r2, #7 @hightlight width
			and		r1, r2
			lsl		r1, #4
			
			cmp		r5, #0
			bne		InPrep_SetCursor
		
				add		r0, #0xC4
				add		r1, #0x18
				mov		r2, #1
				b		SetupCursor

		InPrep_SetCursor:
		add		r0, #0x6C
		add		r1, #0x16
		@mov		r2, #7
		mov		r2, #0 @no highlight
		
		SetupCursor:
		ldr		r3, =CursorRoutineThing
		mov		lr, r3
		mov		r3, #0x80
		lsl		r3, #4
		.short	0xF800
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

