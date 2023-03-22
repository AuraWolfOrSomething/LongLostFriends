.thumb

.include "../CheckIfDoublingDefs.s"

.global NoDoublingVanilla
.type NoDoublingVanilla, %function


		NoDoublingVanilla:
		push	{r4,r14}
		mov		r4, r0
		add   	r0, #0x4A
		ldrh  	r0, [r0]
		ldr	  	r3, =GetItemWeaponEffect
		mov	  	lr, r3
		.short 	0xF800
		
		cmp   	r0, #0x3
		beq   	CannotDouble @Eclipse weapons can't double
		
			add		r4, #0x48
			ldrb	r0, [r0]
			cmp		r0, #0xB5 @Stone can't double
			beq		CannotDouble
		
				mov		r0, #0
				b		End
		
		CannotDouble:
		mov		r0, #1
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1

