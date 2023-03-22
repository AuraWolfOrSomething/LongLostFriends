.thumb

.global prGemAid
.type prGemAid, %function


		prGemAid:
		push	{r4,r14}
		mov		r4, r0 @stat
		
		mov		r0, r1
		ldr		r1, =PassiveGemAidBoostList
		ldr		r3, =GetGemSpecialStatBoost
		mov		lr, r3
		.short	0xF800
		
		add		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1

