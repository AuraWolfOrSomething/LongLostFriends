.thumb

.global FocusBeltEffect
.type FocusBeltEffect, %function

.equ gTargetBattleUnit, 0x0203A56C
.equ CheckIfUnitHasItem, 0x080179F8

@r4 = unit we're checking
@r5 = unit's opponent (if any)


		FocusBeltEffect:
		push	{r4-r7,r14}
		
		@check if any defender
		  @if none, skip
		ldr		r2, =gTargetBattleUnit
		ldr		r3, [r2,#4]
		cmp		r3, #0
		beq		End
		
			@check if on attacker or defender during PreBattleCalc
			  @if attacker, skip for now
			  @if defender, do this for both units
			cmp		r0, r2
			bne		End
		
				mov		r4, r0
				mov		r5, r1
				ldr		r6, =FocusBeltIDLink
				ldr		r7, =CheckIfUnitHasItem
		
				@Check for item on defender
				ldrb	r1, [r6]
				mov		lr, r7
				.short	0xF800
				cmp		r0, #0
				bne		ActivateFocusBelt
		
					@Check for item on attacker
					mov		r0, r5
					ldrb	r1, [r6]
					mov		lr, r7
					.short	0xF800
					cmp		r0, #0
					beq		End
		
		ActivateFocusBelt:
		@get a LOT of hit
		mov		r1, #0x80
		lsl		r1, #8
		
		@store new hit on both units
		add		r4, #0x60
		strh	r1, [r4]
		add		r5, #0x60
		strh	r1, [r5]
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.ltorg
		.align

