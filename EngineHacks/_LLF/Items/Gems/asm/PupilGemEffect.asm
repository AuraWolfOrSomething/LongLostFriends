.thumb

.include "../GemDefs.s"

.global PupilGemEffect
.type PupilGemEffect, %function

@if pupil gem is active (return result of 1), lower weapon rank requirements by 1


		PupilGemEffect:
		push	{r4-r6,r14}
		mov		r4, #0 @effect on weapon rank
		mov		r5, r0 @unit
		
		@If pupil gem isn't active, no effect
		ldr		r6, =PupilGemLink
		ldrb	r1, [r6] @pupil gem item id
		ldr		r3, =CheckIfGemIsActive
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r4, #1
			
			@If unit is promoted, don't count number of pupil gems
			ldr		r0, [r5,#4]
			ldr		r0, [r0,#0x28]
			mov		r1, #0x80
			lsl		r1, #1
			tst		r0, r1
			bne		End

				mov		r0, r5
				ldrb	r1, [r6]
				ldr		r2, =CountCopiesOfItem
				mov		lr, r2
				.short	0xF800
				mov		r4, r0
				
				@If unit has Selna Gem, double effect on weapon rank
				mov		r0, r5
				ldr		r1, =SelnaGemLink
				ldrb	r1, [r1]
				ldr		r2, =CheckIfUnitHasItem
				mov		lr, r2
				.short	0xF800
				lsl		r4, r0
		
		End:
		mov		r0, r4
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

