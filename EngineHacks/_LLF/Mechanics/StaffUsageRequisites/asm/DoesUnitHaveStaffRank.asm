.thumb

.global DoesUnitHaveStaffRank
.type DoesUnitHaveStaffRank, %function


		DoesUnitHaveStaffRank:
		push	{r4,r14}
		mov		r4, r1 @staff halfword

		@get unit's current staff rank
		mov		r1, #0x2C
		ldrb	r1, [r0,r1]
		ldr		r2, =WeaponRankModifierLoop @in EngineHacks/_RS
		mov 	lr, r2
		.short 	0xF800
		
		@get item's staff rank
		mov		r1, #0xFF
		and		r4, r1
		
		@get item entry in ItemTable
		lsl		r1, r4, #3
		add		r1, r4
		lsl		r1, #2
		ldr		r2, =ItemTable
		add		r1, r2
		ldrb	r1, [r1,#0x1C] @item staff rank
		cmp		r0, r1
		blt		CannotWield

			mov		r0, #1
			b		End
			
		CannotWield:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

