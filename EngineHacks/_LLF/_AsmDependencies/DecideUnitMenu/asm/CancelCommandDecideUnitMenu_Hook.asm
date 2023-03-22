.thumb

.equ origin, 0x08022874

.global CancelCommandDecideUnitMenu_Hook
.type CancelCommandDecideUnitMenu_Hook, %function

.equ bl_BXR0, . + 0x080D18C0 - origin
.equ ContinueRoutine, . + 0x08022884 - origin


		CancelCommandDecideUnitMenu_Hook:
		ldr		r0, =CancelCommandDecideUnitMenu
		bl		bl_BXR0
		b		ContinueRoutine
		
		.align
		.ltorg

