.thumb
.equ	origin, 0x2C398
@.equ	Routine_0x19444, . + 0x19444 - origin @Idr what this is or if this is needed


.global ClassPowerDefeatExp
.type ClassPowerDefeatExp, %function


		ClassPowerDefeatExp:
		push	{r4}
		mov		r2, #0x08
		ldsb	r2, [r0,r2]
		lsl		r2, #1
		ldr		r3, [r0,#0x04]
		ldr		r0, [r0]
		ldr		r0, [r0,#0x28]
		ldr		r4, [r3,#0x28]
		orr		r0, r4
		mov		r4, #0x80
		lsl		r4, r4, #0x01
		and		r0, r4
		cmp		r0, #0x00	@checks if promoted; if unpromoted, go to End
		beq		End
		
			@mov		r0, #20
			@add		r0, r1 @additional levels if promoted enemy
			@add		r2, r0
			
			add		r2, #4 @additional levels if promoted
		
		End:
		mov		r0, #0x1A
		ldsb	r0, [r3,r0]
		sub		r0, #3
		lsl		r1, r0, #2
		add		r0, r1
		neg		r0, r0
		sub		r2, r0
		
		mov		r0, r2
		pop		{r4}
		bx		r14
		
		.align

