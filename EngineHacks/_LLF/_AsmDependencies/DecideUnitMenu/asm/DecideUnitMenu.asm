.thumb

.include "../DecideUnitMenuDefs.s"

.global DecideUnitMenu
.type DecideUnitMenu, %function


		DecideUnitMenu:
		push	{r14}
		
		@check if map menu command "Plan" is usable
		  @if so, use normal unit menu
		  @if not, use plan unit menu (very limited selection of commands)
		  
		ldr		r0, =MM_PlanUsability
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		beq		LoadNormalUnitMenu
		
		ldr		r0, =gMenu_PlanUnitMenu
		b		HookOverwrite
		
		LoadNormalUnitMenu:
		ldr		r0, =gMenu_UnitMenu
		
		HookOverwrite:
		@do what hook is overwriting
		ldr		r2, =gGameState
		mov		r3, #0x1C
		ldsh	r1, [r2,r3]
		mov		r3, #0x0C
		ldsh	r2, [r2,r3]
		sub		r1, r2
		mov		r2, #1
		
		@now we're done
		pop		{r3}
		bx		r3
		
		.align
		.ltorg

		