.thumb

.include "../CheckIfDoublingDefs.s"

.global NoDoublingWeaponEffect
.type NoDoublingWeaponEffect, %function


		NoDoublingWeaponEffect:
		push	{r14}
		add   	r0, #0x4A
		ldrh  	r0, [r0]
		ldr	  	r3, =GetItemWeaponEffect
		mov	  	lr, r3
		.short 	0xF800
		cmp   	r0, #0x0C
		beq		CannotDouble
		
			mov		r0, #0
			b		End
		
		CannotDouble:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1

		.align
		.ltorg

