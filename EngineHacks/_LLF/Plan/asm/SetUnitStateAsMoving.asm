.thumb

.global SetUnitStateAsMoving
.type SetUnitStateAsMoving, %function


		SetUnitStateAsMoving:
		ldr		r1, [r0,#0x0C]
		mov		r2, #1
		orr		r1, r2
		
		@planning allows grayed out units to be moved; this removes some visual/technical bugs by simply ungraying them
		mov		r2, #0x42 
		mvn		r2, r2
		and		r1, r2
		
		@store new unit state
		str		r1, [r0,#0x0C]
		
		@overwritten by hook
		mov		r0, #0x11
		ldsb	r0, [r4,r0]
		bx		r14
		
		.align
		.ltorg


