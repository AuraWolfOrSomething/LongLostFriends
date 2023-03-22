.thumb

.equ origin, 0
.include "../StatusDebuffsDefs.s"

.global GetUnitStatusString
.type GetUnitStatusString, %function


		GetUnitStatusString:
		push	{r4-r7,r14}
		mov		r4, r0 @unit
		mov		r5, r1 @x tile
		mov		r6, r2 @y tile
		push	{r3}
		
		ldr		r1,	=CountActiveEffects
		mov		lr, r1
		.short	0xF800
		mov		r7, r0
		cmp	  	r0, #0
		beq	  	TextForNoEffects
		
			cmp	  r0, #2
			bge	  TextForMultipleEffects
		
				ldr		r7, =StatScreenStatusDebuffSetUp
		
				FindEffectLoop:
				add		r7, #8
				mov		r0, r4
				ldr		r1, [r7,#4]
				mov		lr, r1
				.short	0xF800
				cmp		r0, #0
				beq		FindEffectLoop
		  
					@Found the effect; check if this is Absorb
					ldrh	r1, [r7,#2]
					ldr		r2, =AbsorbDebuffNameLink
					ldrh	r2, [r2]
					cmp		r1, r2
					bne		PassOnNameAndNumber
					
						mov		r0, #0xFF
					
					PassOnNameAndNumber:
					mov		r7, r0
					mov		r0, r1
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
		mov		r3, r0
		ldr		r0, =Text_InsertString
		mov		lr, r0
		pop		{r0}
		mov		r1, #0x16        @16 if status, otherwise 18???
		mov		r2, #2
		.short	0xF800
		cmp		r7, #0
		beq		End
		
			cmp		r7, #0xFF
			beq		End

				ldr		r3, =DrawUiSmallNumber
				mov 	r2, r7
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

