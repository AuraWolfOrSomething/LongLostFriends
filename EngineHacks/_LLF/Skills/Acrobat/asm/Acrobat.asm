.thumb

.global Acrobat
.type Acrobat, %function


		Acrobat:
		push	{r14}
		ldr		r1, =AcrobatIDLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

