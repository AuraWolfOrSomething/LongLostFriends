.thumb

.global ScoutBadgeCheck
.type ScoutBadgeCheck, %function

.equ UnitHasItem, 0x080179F8


		ScoutBadgeCheck:
		push	{r14}
		ldr		r1, =ScoutBadgeIDLink
		ldrb	r1, [r1]
		ldr		r3, =UnitHasItem
		mov		lr, r3
		.short	0xF800
		
		@use return directly for TerrainMovementCost subtract
		  @if scout badge (r0 = 1), subtract by 1 (1)
		  @else if no scout badge (r0 = 0), nothing is subtracted
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

