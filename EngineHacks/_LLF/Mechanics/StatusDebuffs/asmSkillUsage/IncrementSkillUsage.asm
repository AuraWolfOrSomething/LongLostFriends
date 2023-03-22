.thumb

.global IncrementSkillUsage
.type IncrementSkillUsage, %function


		IncrementSkillUsage:
		push	{r4,r14}
		mov		r4, r0
		ldr		r0, =GetSkillUsageByte
		mov		lr, r0
		.short	0xF800
		lsr		r0, #8
		ldrb	r1, [r4]
		and		r1, r0
		cmp		r1, r0
		bge		End
		
			cmp		r0, #0xF0
			bne		StandardIncrement
			
				mov		r1, #0x10
				b		AddToByte
				
			StandardIncrement:
			mov		r1, #1
			
			AddToByte:
			ldrb	r0, [r4]
			add		r0, r1
			strb	r0, [r4]
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

