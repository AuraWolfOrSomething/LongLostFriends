.thumb

.include "../WardenDefs.s"

.global RemoveWardenBuffOnUnit
.type RemoveWardenBuffOnUnit, %function


		RemoveWardenBuffOnUnit:
		push	{r14}
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r1, [r0,#4]
		mov		r2, #0x0F
		and		r1, r2
		strb	r1, [r0,#4]
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

