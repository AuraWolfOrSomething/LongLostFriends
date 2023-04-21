.thumb

.global GrayCommandIfSilenced
.type GrayCommandIfSilenced, %function


		GrayCommandIfSilenced:
		push	{r14}
		ldr		r1, =IsSilenceStatusActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		beq		CanUse
		
			mov		r0, #2
			b		End
		
		CanUse:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

