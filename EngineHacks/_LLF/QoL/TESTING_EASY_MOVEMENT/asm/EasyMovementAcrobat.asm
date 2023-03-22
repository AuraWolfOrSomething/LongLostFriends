.thumb

.global EasyMovementAcrobat
.type EasyMovementAcrobat, %function

		@r0=movement cost table. Function originally at 1A4CC, now jumped to here (jumpToHack)
		
		EasyMovementAcrobat:
		push  	{r4-r5,r14}
		mov   	r4, r0
		ldr   	r0, CurrentCharPtr
		ldr   	r0, [r0]
		cmp   	r0, #0
		bne   	NoDZ
		
		mov   	r0, r2 @if the active unit is 0, we're being called from dangerzone
		
		NoDZ:
		ldrb	r0, [r0,#0xB]
		lsr		r0, #6
		cmp		r0, #0
		bne		NotPlayerUnit
		
		mov		r0, #1
		b		LoadMoveCostLoc
		
		NotPlayerUnit:
		mov		r0, #0

		LoadMoveCostLoc:
		mov		r1, #0
		ldr   	r5, MoveCostLoc
		
		@TileId0/Tile1 must be untraversable to avoid weird map fill overflow?
		ldrb	r2, [r4]
		mov		r3, r5
		b		NoAcrobat
		
		Loop1:
		add   	r2, r4, r1
		add   	r3, r5, r1
		ldrb  	r2, [r2]
		cmp   	r0, #0
		beq   	NoAcrobat

		mov   	r2, #0x1
		
		NoAcrobat:
		strb  	r2, [r3]
		add   	r1, #1
		cmp   	r1, #0x40
		ble   	Loop1
		pop   	{r4-r5}
		pop   	{r0}
		bx    	r0

		.align
		
		CurrentCharPtr:
		.long 0x03004E50
		
		MoveCostLoc:
		.long 0x03004BB0

