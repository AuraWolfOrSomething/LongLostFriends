.thumb

.global RallyTileDisplayOn
.type RallyTileDisplayOn, %function

.global RallyTileDisplayReturnRange
.type RallyTileDisplayReturnRange, %function

.equ gActiveUnit, 0x03004E50
.equ gMapMovement, 0x0202E4E0
.equ gMapRange, 0x0202E4E4

.equ ClearMapWith, 0x080197E4
.equ DisplayMoveRangeGraphics, 0x0801DA98


		RallyTileDisplayOn:
		push	{r4-r6,r14}
		ldr		r5, =gActiveUnit
		ldr		r0, =gMapMovement
		ldr		r0, [r0]
		mov		r4, #1
		neg		r4, r4
		mov		r1, r4
		ldr		r6, =ClearMapWith
		mov		lr, r6
		.short	0xF800
		ldr		r0, =gMapRange
		ldr		r0, [r0]
		mov		r1, #0
		mov		lr, r6
		.short	0xF800
		ldr		r0, [r5]
		mov		r1, r4
		bl		RallyTileDisplayReturnRange
		mov		r0, #5
		ldr		r1, =DisplayMoveRangeGraphics
		mov		lr, r1
		.short	0xF800
		mov		r0, #0
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg
		
		
		RallyTileDisplayReturnRange:
		push	{r4,r14}
		mov		r4, r0
		ldr		r0, =RallyRangeLink
		ldrb	r1, [r0] @min range
		ldrb	r0, [r0,#1] @max range
		mov		r2, #0
		
		CalcRangeLoop:
		add		r2, r1
		lsl		r1, #1
		sub		r0, #1
		cmp		r0, #0
		bgt		CalcRangeLoop
			
		RangeDetermined:
		mov		r12, r2
		mov		r3, #0
		mov		r0, #0x10
		ldsb	r0, [r4,r0]
		mov		r1, #0x11
		ldsb	r1, [r4,r1]
		bl		Write_Range @from ItemRangeFix
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

