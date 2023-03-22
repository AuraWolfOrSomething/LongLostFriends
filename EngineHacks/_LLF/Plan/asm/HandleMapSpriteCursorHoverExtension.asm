.thumb

.global HandleMapSpriteCursorHoverExtension
.type HandleMapSpriteCursorHoverExtension, %function


		HandleMapSpriteCursorHoverExtension:
		push	{r4,r14}
		mov		r4, r0
		
		@check if map menu command "Plan" is usable
			@if not (planning is on), skip grayed out check and allegiance check
		ldr		r0, =MM_PlanUsability
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		bne		AllowNewMapSpriteAnimation
		
			@check if unit isn't grayed out
			ldr		r0, [r4,#0x0C]
			mov		r1, #2
			and		r0, r1
			cmp		r0, #0
			bne		ReturnToHandleMapSpriteCursorHover
			
				@check if unit isn't in player unit faction
				mov		r0, #0x0B
				ldsb	r0, [r4,r0]
				lsr		r0, #6
				b		ReturnToHandleMapSpriteCursorHover
		
		AllowNewMapSpriteAnimation:
		mov		r0, #0
		
		ReturnToHandleMapSpriteCursorHover:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


