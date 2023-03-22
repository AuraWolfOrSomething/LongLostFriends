.thumb

.global NoDoublingBlitz
.type NoDoublingBlitz, %function

@simply returns if unit has Blitz or not
  @if unit has Blitz, SkillTester will return 1, which will then be returned as 1 by NoDoublingBlitz for no doubling
  @if unit doesn't have Blitz, then 0 will be returned by both routines

		NoDoublingBlitz:
		push	{r14}
		ldr		r1, =BlitzLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

