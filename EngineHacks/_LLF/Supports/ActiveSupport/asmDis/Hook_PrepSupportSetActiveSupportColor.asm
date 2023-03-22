.thumb

@inline at 080A1D50

.global Hook_PrepSupportSetActiveSupportColor
.type Hook_PrepSupportSetActiveSupportColor, %function


		Hook_PrepSupportSetActiveSupportColor:
		ldr		r3, =PrepSupportSetActiveSupportColor
		mov		lr, r3
		.short	0xF800
		lsr		r7, r0, #0x1C
		lsl		r0, #4
		lsr		r0, #4
		mov		r2, r10
		b		ContinueVanilla
		
		.align
		.ltorg
		
		ContinueVanilla:

