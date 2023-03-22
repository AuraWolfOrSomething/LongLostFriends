.thumb

.include "../DecideUnitMenuDefs.s"

.global CancelCommandDecideUnitMenu
.type CancelCommandDecideUnitMenu, %function


		CancelCommandDecideUnitMenu:
		push	{r14}
		
		@do Cancel_Capture stuff
		ldr		r0, =gActiveUnit
		ldr		r0, [r0]
		ldr		r1, [r0,#0x0C]
		mov		r2, #0x80
		lsl		r2, #0x17
		mvn		r2, r2
		and		r1, r2
		str		r1, [r0,#0x0C]
		
		@check if map menu command "Plan" is usable
		  @if so, use normal unit menu
		  @if not, use plan unit menu (very limited selection of commands)
		ldr		r0, =DecideUnitMenu
		mov		lr, r0
		.short	0xF800
		
		pop		{r3}
		bx		r3
		
		.align
		.ltorg

