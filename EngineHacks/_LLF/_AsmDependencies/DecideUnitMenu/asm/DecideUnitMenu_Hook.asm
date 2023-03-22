.thumb

.equ origin, 0x0801D4EC

.global DecideUnitMenu_Hook
.type DecideUnitMenu_Hook, %function

.equ bl_BXR0, . + 0x080D18C0 - origin
.equ ContinueRoutine, . + 0x0801D4FC - origin


		DecideUnitMenu_Hook:
		ldr		r0, =DecideUnitMenu
		bl		bl_BXR0
		b		ContinueRoutine
		
		.align
		.ltorg

