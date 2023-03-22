.thumb

.equ origin, 0x080167A4
.include "../ItemEffectDefs.s"

.global CanUnitWieldStaff
.type CanUnitWieldStaff, %function

@r0 = unit
@r1 = item


		CanUnitWieldStaff:
		push	{r4,r14}
		
		@make sure we're not checking an empty inventory slot
		cmp		r1, #0
		beq		CannotWield
		
			@get item id
			mov		r2, #0xFF
			and		r1, r2
			
			@get item entry in ItemTable
			lsl		r2, r1, #3
			add		r2, r1
			lsl		r2, #2
			ldr		r3, =ItemTable
			add		r2, r3
			
			@check if staff
			ldr		r3, [r2,#8]
			mov		r4, #4
			tst		r3, r4
			beq		CannotWield
			
				@new check for other requirements
				ldr		r3, =StaffUsageRequisites
				mov		lr, r3
				.short	0xF800
				b		End
		
		CannotWield:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

