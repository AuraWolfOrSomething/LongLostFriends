.thumb

.equ origin, 0x0808C390
.include "../StatusDebuffsDefs.s"

.global SS_WriteEffect
.type SS_WriteEffect, %function


		SS_WriteEffect:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r1
		mov		r6, r2
		mov		r7, r3
		
		ldr		r1, =GetUnitStatusString
		mov		lr, r1
		.short	0xF800
		mov		r3, r0
		ldr		r0, =Text_InsertString
		mov		lr, r0
		mov		r0, r7
		mov		r1, #0x16
		mov		r2, #2
		.short	0xF800
		
		mov		r0, r4
		ldr		r1,	=CountActiveEffects
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			@If multiple effects are active, draw the quantity next to text
			cmp		r0, #2
			bge		EffectFound
			
				@Do not draw a number for Absorb
				mov		r0, r4
				ldr		r1, =IsAbsorbDebuffActive
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				bne		End
				
					ldr		r7, =StatScreenStatusDebuffSetUp
					
					LoopThroughList:
					add		r7, #8
					mov		r0, r4
					ldr		r1, [r7,#4]
					mov		lr, r1
					.short	0xF800
					cmp		r0, #0
					beq		LoopThroughList
		
		EffectFound:
		mov		r2, r0
		ldr		r3, =DrawUiSmallNumber
		ldr		r0, =Const_2003CA4
		lsl		r1, r5, #1
		add		r0, r1
		lsl		r1, r6, #6
		add		r0, r1
		mov 	r1, #0
		mov		lr, r3
		.short	0xF800
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

