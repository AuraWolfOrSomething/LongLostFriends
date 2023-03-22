.thumb

.global BonusEXPForUndeployedChapters
.type BonusEXPForUndeployedChapters, %function

@r0 = current EXP
@r1 = this unit's struct/battle struct

		BonusEXPForUndeployedChapters:
		@check bit for 2 undeployed chapters
		  @if set, check bit for 1
		    @if set, 1.5x exp
			@if not, 1.25x exp
		  @if not, still check bit for 1
		    @if set, 1.25x exp
			@if not, no bonus exp
		
		mov		r3, #1
		add		r1, #0x3B
		ldrb	r1, [r1]
		mov		r2, #0x80
		tst		r1, r2
		bne		CheckNextBit
		
			add		r3, #1
		
		CheckNextBit:
		mov		r2, #0x40
		tst		r1, r2
		bne		CheckIfAnyBitsSet
		
			add		r3, #1
		
		CheckIfAnyBitsSet:
		cmp		r3, #3
		beq		End
		
			mov		r1, r0
			lsr		r1, r3
			add		r0, r1
		
		End:
		bx		lr
		
		.align

