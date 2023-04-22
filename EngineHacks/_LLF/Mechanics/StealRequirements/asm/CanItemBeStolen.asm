.thumb

.equ origin, 0
.include "../StealRequirementsDefs.s"

.global CanItemBeStolen
.type CanItemBeStolen, %function


		CanItemBeStolen:
		push	{r4-r7,r14}
		mov		r4, r0 @unit
		mov		r5, r1 @inventory slot
		
		ldr		r1, =WatchfulIDLink
		mov		lr, r1
		.short	0xF00
		cmp		r0, #1
		beq		CannotSteal
		
			lsl		r0, r5, #1
			add		r0, #0x1E
			ldrh	r0, [r4,r0]
			cmp		r0, #0
			beq		CannotSteal
			
			ldr		r1, =GetItemWType
			mov		lr, r1
			.short	0xF800
			cmp		r0, #9
			beq		CanSteal
			
				mov		r0, r4
				ldr		r1, =IsSleepStatusActive
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				beq		CannotSteal
			
		CanSteal:
		mov		r0, #1
		b		End
		
		CannotSteal:
		mov		r0, #0
		
		End:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

