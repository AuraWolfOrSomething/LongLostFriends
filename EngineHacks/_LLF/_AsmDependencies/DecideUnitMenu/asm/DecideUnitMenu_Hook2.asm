.thumb

.equ origin, 0x08022808

.global DecideUnitMenu_Hook2
.type DecideUnitMenu_Hook2, %function

.equ bl_BXR0, . + 0x080D18C0 - origin
.equ ContinueRoutine, . + 0x0802281A - origin


		DecideUnitMenu_Hook2:
		push	{r14}
		ldr		r0, =DecideUnitMenu
		bl		bl_BXR0
		b		ContinueRoutine
		
		.align
		.ltorg

	