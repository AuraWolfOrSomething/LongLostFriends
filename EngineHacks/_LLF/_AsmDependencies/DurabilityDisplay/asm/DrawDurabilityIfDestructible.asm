.thumb

.equ origin, 0x0801685C
.include "../DurabilityDisplayDefs.s"

.global DrawDurabilityIfDestructible
.type DrawDurabilityIfDestructible, %function


		DrawDurabilityIfDestructible:
		push	{r14}
		cmp		r2, #0xFF @if indestructible, skip
		beq		End
		
			bl		bl_DrawUiNumberOrDoubleDashes
		
		End:
		pop		{r0}
		bx		r0

