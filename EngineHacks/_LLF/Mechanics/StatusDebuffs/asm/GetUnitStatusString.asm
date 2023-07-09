.thumb

.equ origin, 0
.include "../StatusDebuffsDefs.s"

.global GetUnitStatusString
.type GetUnitStatusString, %function


		GetUnitStatusString:
		push	{r4-r5,r14}
		mov		r4, r0 @unit

		ldr		r1,	=CountActiveEffects
		mov		lr, r1
		.short	0xF800
		cmp	  	r0, #0
		beq	  	TextForNoEffects
		
			cmp	  r0, #2
			bge	  TextForMultipleEffects
		
				ldr		r5, =StatScreenStatusDebuffSetUp
		
				FindEffectLoop:
				add		r5, #8
				mov		r0, r4
				ldr		r1, [r5,#4]
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				beq		FindEffectLoop
		  
					@Found the effect
					ldrh	r0, [r5,#2]
					b		GoToString_GetFromIndex
		  
		TextForNoEffects:
		ldr		r0, =ConditionNormalHelpTextLink
		ldrh	r0, [r0,#2]
		b		GoToString_GetFromIndex

		TextForMultipleEffects:
		ldr		r0, =StatScreenStatusDebuffSetUp
		ldrh	r0, [r0,#2]
		
		GoToString_GetFromIndex:
		ldr		r1, =String_GetFromIndex
		mov		lr, r1
		.short	0xF800
		pop		{r4-r5}
		pop		{r1}
		bx		r1

		.align
		.ltorg

