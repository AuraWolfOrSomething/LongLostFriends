.thumb

.global GetChapterAllyUnitCount_2
.type GetChapterAllyUnitCount_2, %function


		GetChapterAllyUnitCount_2:
		push	{r14}
		ldr		r3, GetChapterAllyUnitDefinitions
		mov		lr, r3
		.short	0xF800
		
		mov		r2, #0
		b		CheckIfDeploymentSlotLoop
		
		IncreaseSlots:
		add		r2, #1
		add		r0, #0x14
		
		CheckIfDeploymentSlotLoop:
		ldrb	r1, [r0]
		cmp		r1, #0 @if no more units, we're done
		beq		End
		
		cmp		r1, #0xFF @if set as extra deployment tile, we're done
		bne		IncreaseSlots
		
		End:
		mov		r0, r2
		pop		{r1}
		bx		r1
		
		.align
		
		GetChapterAllyUnitDefinitions:
		.long	0x08083348

