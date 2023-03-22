.thumb

@inline at 080A1E38

.global Hook_PrepSupportRankColor
.type Hook_PrepSupportRankColor, %function


		Hook_PrepSupportRankColor:
		mov		r0, r9
		mov		r1, r10
		mov		r2, r5
		ldr		r3, =PrepSupportRankColor
		mov		lr, r3
		.short 	0xF800
		mov		r7, r0
		b		GoToDrawSpecialUiChar
		
		.align
		.ltorg
		
		GoToDrawSpecialUiChar:

