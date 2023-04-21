.thumb

.include "../../MultipleHelpTextPagesDefs.s"

.global HelpTextNonStatScreenCheckButton_A
.type HelpTextNonStatScreenCheckButton_A, %function


		HelpTextNonStatScreenCheckButton_A:
		push	{r4-r5,r14}
		mov		r4, r0
		ldr		r0, =gProc_HelpBoxControl
		ldr		r1, =ProcFind
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		bne		CheckButton_A
		
			mov		r0, r4
			mov		r1, #1 @label 1: end HelpTextMultiplePageProc
			b		LongcallProcGoto
		
		CheckButton_A:
		ldr		r2, =KeyStatusBuffer
		ldr		r2, [r2]
		ldrh	r0, [r2,#6]
		mov		r1, #1
		tst		r0, r1
		beq		Idle
		
			ldr		r0, [r4,#0x2C]
			ldr		r1, =CanCurrentHelpTextHaveMultiplePages
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			beq		Idle
			
				ldr		r0, =gSomeTextRelatedStuff
				ldr		r3, =Routine_0x88E9C
				mov		lr, r3
				.short	0xF800
				
				mov		r0, #0x67
				ldr		r1, =m4aSongNumStart
				mov		lr, r1
				.short	0xF800
		
		Idle:
		mov		r0, r4
		mov		r1, #0 @label 0: repeat
		
		LongcallProcGoto:
		ldr		r2, =ProcGoto
		mov		lr, r2
		.short	0xF800
		
		End:
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		
		.align
		.ltorg

