.thumb

.equ origin, 0x080A22D8
.include "../ActiveSupportDefs.s"

.equ ContinueVanilla, . + 0x080A2340 - origin

.global Hook_SupportListShouldCursorAppear_Init
.type Hook_SupportListShouldCursorAppear_Init, %function


		Hook_SupportListShouldCursorAppear_Init:
		@if in prep, skip setting text speed
		mov		r0, #0x38
		ldrb	r0, [r5,r0]
		cmp		r5, #0
		bne		AfterSetTextSpeed
		
			@set game & text speed to fast
			add		r2, #0x40
			mov		r0, #0xC0
			strb	r0, [r2]
		
			@vanilla code
			@add		r2, #0x40
			@ldrb	r1, [r2]
			@mov		r0, #0x61
			@neg		r0, r0
			@and		r0, r1
			@mov		r1, #0x20
			@orr		r0, r1
			@strb	r0, [r2]
		
		AfterSetTextSpeed:
		mov		r0, r5
		bl		bl_080AD47C
		mov		r0, #0xC0
		lsl		r0, #3
		mov		r1, #1
		bl		bl_080AD4A0
		mov		r0, #1
		bl		bl_080AD594
		mov		r1, r5
		add		r1, #0x3A
		mov		r0, #0xFF
		strb	r0, [r1]
		
		mov		r0, r5
		ldr		r1, =SupportListShouldCursorAppear
		bl		BXR1
		b		ContinueVanilla
		
		.align
		.ltorg

