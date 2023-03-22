.thumb

.equ gGameState, 0x0202BCB0

.global Transmitter
.type Transmitter, %function


		Transmitter:
		push	{r4-r6,r14}
		mov		r5, r0
		mov		r6, r2
		
		@Check for Transmitter+
		ldr		r1, =TransmitterPlusLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		CheckForTransmitter
		
			@Transmitter+ resets unit regardless of any actions they did before using Give
			mov		r4, #0
			ldr		r1, =gGameState
			add		r1, #0x3D
			strb	r4, [r1]
			b		StoreNewStatus
		
		CheckForTransmitter:
		mov		r0, r5
		ldr		r1, =TransmitterLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		NoTransmitter
		
			@Transmitter only resets unit if they didn't use other actions
			ldr		r1, =gGameState
			add		r1, #0x3D
			ldrb	r1, [r1]
			cmp		r1, #0
			bne		NoTransmitter
		
				mov		r4, #0
				b		StoreNewStatus
		
		NoTransmitter:
		mov		r4, #0x0C
		
		StoreNewStatus:
		strb	r4, [r6,#0x11]
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

